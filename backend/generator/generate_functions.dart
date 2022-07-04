import 'dart:async';
import 'dart:io';

import 'dmmf.dart';
import 'generate_options.dart';
import 'generator.dart';

const generatorName = 'DART GENERATOR';

FutureOr<JsonRPCResponse> getManifest(JsonRPCRequest request) {
  if (request.params['name'] != 'dart') {
    exit(0);
  }
  print('✔ $generatorName Registered.');
  return request.respond({
    'version': '1.0.0',
    'defaultOutput': '../lib',
    'prettyName': generatorName,
  });
}

FutureOr<JsonRPCResponse> generate(JsonRPCRequest request) async {
  final options = GenerateOptions.fromJson(request.params);
  var output = options.generator.output.fromEnvVar ?? options.generator.output.value ?? './';
  final dir = Directory('$output${Platform.pathSeparator}prisma');
  if (dir.existsSync()) {
    dir.deleteSync(recursive: true);
  }
  dir.createSync(recursive: true);

  await generateModels(dir, options.dmmf.datamodel);
  // await generateSchemas(dir, options.dmmf);
  return request.respond({});
}

String _findManyGenerator(ModelMapping mapping, Schema schema) {
  final mapbody = StringBuffer();
  final methodName = mapping.findMany;
  final model = schema.outputObjectTypes.model.firstWhere((element) => element.name == mapping.model);
  mapbody.writeln('Future<List<${mapping.model}>> findMany(){');
  mapbody.writeln('final queryBuffer = StringBuffer();');
  mapbody.write('final fields = ');

  String mapFields(OutputType model, [String? currentModelName]) {
    final innerField = StringBuffer('<Map<String, List>>[');

    for (var fieldModel in model.fields) {
      /*
    final fields = <Map<String, List>>[
      {'id': []},
      {'title': []},
      {'published': []},
      {'authorId': []},
      {
        'author': [
          {'id': []},
          {'name': []},
        ]
      },
    ];
    */

      if (fieldModel.outputType.namespace != 'model') {
        if (!fieldModel.name.contains('_')) {
          innerField.write("{'${fieldModel.name}': []}");
        } else {
          continue;
        }
      } else {
        final innerModel = schema.outputObjectTypes.model.firstWhere((element) => element.name == fieldModel.outputType.type);

        if (currentModelName == innerModel.name) {
          continue;
        }
        final result = mapFields(innerModel, model.name);
        innerField.write("{'${fieldModel.name}': $result}");
      }

      innerField.write(',');
    }
    innerField.writeln(']');
    return innerField.toString();
  }

  mapbody.write(mapFields(model));
  mapbody.writeln(';');

  mapbody.writeln(
      """
  void _addField(Map<String, List> field) {
    for (var key in field.keys) {
      queryBuffer.writeln(key);
      if (field[key]!.isNotEmpty) {
        queryBuffer.writeln('{');
        for (var localField in field[key]!) {
          _addField(localField);
        }
        queryBuffer.writeln('}');
      }
    }
  }


queryBuffer.writeln('query {');
queryBuffer.writeln(' result: $methodName');
queryBuffer.writeln('{');
for (var field in fields) {
    _addField(field);
}
queryBuffer.writeln('}');
queryBuffer.writeln('}');
""");
  // end
  mapbody.writeln('}');
  return mapbody.toString();
}

FutureOr<void> generateSchemas(Directory dir, Dmmf dmmf) {
  final schema = dmmf.schema;
  final mappings = dmmf.mappings;
  final body = StringBuffer();
  for (var mapping in mappings.modelOperations) {
    final mapbody = StringBuffer();
    mapbody.writeln('class ${mapping.model}Schema {');

    mapbody.writeln(_findManyGenerator(mapping, schema));

    mapbody.writeln('}');
    body.writeln(mapbody);
  }
  print(body);
}

FutureOr<void> generateModels(Directory dir, DataModel dataModel) {
  final bodyString = StringBuffer();

  for (var model in dataModel.models) {
    final constructor = StringBuffer();
    final fromJson = StringBuffer();
    bodyString.writeln('class ${model.name} {');
    constructor.writeln(' ${model.name}({');
    fromJson.writeln('static ${model.name} fromJson(Map json) {');
    fromJson.writeln('return ${model.name}(');

    for (var field in model.fields) {
      var type = _convertType(field.type);
      var requiredValue = 'required ';
      var propertie = "json['${field.name}']";
      if (field.isList) {
        propertie = '$propertie == null ? [] : ($propertie as List).map((e) => $type.fromJson(e)).toList()';
        type = 'List<$type>';
      }

      if (!field.isRequired) {
        type = '$type?';
        requiredValue = '';
      }

      if (field.hasDefaultValue && field.fieldDefault?.value != null) {
        var value = field.fieldDefault!.value;
        if (field.kind == 'enum') {
          value = '${field.type}.$value';
        }
        constructor.writeln('   this.${field.name} = $value,');
      } else {
        constructor.writeln('   $requiredValue this.${field.name},');
      }

      fromJson.writeln("    ${field.name}: $propertie,");
      bodyString.writeln('  final $type ${field.name};');
    }

    constructor.write(' });');
    bodyString.writeln();
    bodyString.writeln(constructor);
    bodyString.writeln();
    fromJson.writeln(' );');
    fromJson.writeln('}');
    bodyString.writeln(fromJson);

    bodyString.writeln('}');
    bodyString.writeln();
  }

  for (var enumValue in dataModel.enums) {
    bodyString.writeln('enum ${enumValue.name} {');
    for (var value in enumValue.values) {
      bodyString.writeln('${value.name},');
    }

    bodyString.writeln('}');
    bodyString.writeln('\n');
  }

  final file = File('${dir.path}${Platform.pathSeparator}models_prisma.dart');
  file.writeAsStringSync(bodyString.toString());
}

String _convertType(String type) {
  final typeMap = <String, String>{
    'Int': 'int',
    'BigInt': 'int',
    'Float': 'float',
    'Decimal': 'float',
    'Boolean': 'bool',
    'Json': 'Map',
  };

  return typeMap[type] ?? type;
}
