class Dmmf {
  DataModel datamodel;
  Schema schema;
  Mappings mappings;

  Dmmf({
    required this.datamodel,
    required this.schema,
    required this.mappings,
  });

  static Dmmf fromJson(Map json) {
    return Dmmf(
      datamodel: DataModel.fromJson(json['datamodel']),
      mappings: Mappings.fromJson(json['mappings']),
      schema: Schema.fromJson(json['schema']),
    );
  }
}

class DataModel {
  List<ModelEnum> enums;
  List<Model> models;
  List<Model> types;

  DataModel({
    this.enums = const [],
    this.models = const [],
    this.types = const [],
  });

  static DataModel fromJson(Map json) {
    return DataModel(
      models: (json['models'] as List).map((e) => Model.fromJson(e)).toList(),
      enums: (json['enums'] as List).map((e) => ModelEnum.fromJson(e)).toList(),
      types: json['types'] == null ? [] : (json['types'] as List).map((e) => Model.fromJson(e)).toList(),
    );
  }
}

class ModelEnum {
  String name;
  List<EnumValue> values;
  String? dbName;
  String? documentation;
  ModelEnum({
    required this.name,
    required this.values,
    this.dbName,
    this.documentation,
  });

  static ModelEnum fromJson(Map json) {
    return ModelEnum(
      name: json['name'],
      dbName: json['dbName'],
      documentation: json['documentation'],
      values: (json['values'] as List).map((e) => EnumValue.fromJson(e)).toList(),
    );
  }
}

class EnumValue {
  String name;
  String? dbName;
  EnumValue({
    required this.name,
    this.dbName,
  });

  static EnumValue fromJson(Map json) {
    return EnumValue(
      name: json['name'],
      dbName: json['dbName'],
    );
  }
}

class Model {
  String name;
  String? dbName;
  List<Field> fields;
  String? primaryKey;
  List<String> uniqueFields;
  List<UniqueIndex> uniqueIndexes;
  bool isGenerated;
  String? documentation;

  Model({
    required this.name,
    this.dbName,
    this.fields = const [],
    this.primaryKey,
    this.uniqueFields = const [],
    this.uniqueIndexes = const [],
    this.isGenerated = false,
    this.documentation,
  });

  static Model fromJson(Map json) {
    return Model(
      name: json['name'],
      dbName: json['dbName'],
      isGenerated: json['isGenerated'] ?? false,
      primaryKey: json['primaryKey'],
      fields: json['fields'] == null ? [] : (json['fields'] as List).map((e) => Field.fromJson(e)).toList(),
      uniqueFields: json['uniqueFields'] == null ? [] : (json['uniqueFields'] as List).map<String>((e) => e).toList(),
      uniqueIndexes: json['uniqueIndexes'] == null ? [] : (json['uniqueIndexes'] as List).map((e) => UniqueIndex.fromJson(e)).toList(),
      documentation: json['documentation'],
    );
  }
}

class UniqueIndex {
  String name;
  List<String> fields;
  UniqueIndex({
    required this.name,
    required this.fields,
  });

  static UniqueIndex fromJson(Map json) {
    return UniqueIndex(
      name: json['name'],
      fields: (json['fields'] as List).map<String>((e) => e).toList(),
    );
  }
}

class Field {
  String name;
  String kind;
  bool isList;
  bool isRequired;
  bool isUnique;
  bool isId;
  bool isReadOnly;
  bool hasDefaultValue;
  String type;
  FieldDefault? fieldDefault;
  bool? isGenerated;
  bool? isUpdatedAt;
  String? relationName;
  List<String> relationFromFields;
  List<dynamic> relationToFields;

  Field({
    required this.name,
    required this.kind,
    required this.isList,
    required this.isRequired,
    required this.isUnique,
    required this.isId,
    required this.isReadOnly,
    required this.hasDefaultValue,
    required this.type,
    required this.fieldDefault,
    required this.isGenerated,
    required this.isUpdatedAt,
    required this.relationName,
    this.relationFromFields = const [],
    this.relationToFields = const [],
  });

  static Field fromJson(Map json) {
    return Field(
      name: json['name'],
      kind: json['kind'],
      isList: json['isList'],
      isRequired: json['isRequired'],
      isUnique: json['isUnique'],
      isId: json['isId'],
      isReadOnly: json['isReadOnly'],
      hasDefaultValue: json['hasDefaultValue'],
      type: json['type'],
      isGenerated: json['isGenerated'],
      isUpdatedAt: json['isUpdatedAt'],
      fieldDefault: json.containsKey('default') ? FieldDefault.fromJson(json['default']) : null,
      relationFromFields: json.containsKey('relationFromFields') ? (json['relationFromFields'] as List).map<String>((e) => e).toList() : [],
      relationToFields: json.containsKey('relationToFields') ? json['relationToFields'] : [],
      relationName: json['relationName'],
    );
  }
}

class FieldDefault {
  String? name;
  dynamic value;
  List<dynamic> args;

  FieldDefault({
    this.name,
    this.value,
    this.args = const [],
  });

  static FieldDefault fromJson(dynamic jsonOrvalue) {
    if (jsonOrvalue is Map) {
      return FieldDefault(
        name: jsonOrvalue['name'],
        args: jsonOrvalue['args'] ?? [],
      );
    } else {
      return FieldDefault(value: jsonOrvalue);
    }
  }
}

class Mappings {
  List<ModelMapping> modelOperations;
  OtherOperations otherOperations;

  Mappings({
    required this.modelOperations,
    required this.otherOperations,
  });

  static Mappings fromJson(Map json) {
    return Mappings(
      modelOperations: (json['modelOperations'] as List).map((e) => ModelMapping.fromJson(e)).toList(),
      otherOperations: OtherOperations.fromJson(json['otherOperations']),
    );
  }
}

class ModelMapping {
  String model;
  String plural;
  String? findUnique;
  String? findFirst;
  String? findMany;
  String? create;
  String? createMany;
  String? update;
  String? updateMany;
  String? upsert;
  String? delete;
  String? deleteMany;
  String? aggregate;
  String? groupBy;
  String? count;
  String? findRaw;
  String? aggregateRaw;
  ModelMapping({
    required this.model,
    required this.plural,
    this.findUnique,
    this.findFirst,
    this.findMany,
    this.create,
    this.createMany,
    this.update,
    this.updateMany,
    this.upsert,
    this.delete,
    this.deleteMany,
    this.aggregate,
    this.groupBy,
    this.count,
    this.findRaw,
    this.aggregateRaw,
  });

  factory ModelMapping.fromJson(Map json) {
    return ModelMapping(
      model: json['model'] ?? '',
      plural: json['plural'] ?? '',
      findUnique: json['findUnique'],
      findFirst: json['findFirst'],
      findMany: json['findMany'],
      create: json['create'],
      createMany: json['createMany'],
      update: json['update'],
      updateMany: json['updateMany'],
      upsert: json['upsert'],
      delete: json['delete'],
      deleteMany: json['deleteMany'],
      aggregate: json['aggregate'],
      groupBy: json['groupBy'],
      count: json['count'],
      findRaw: json['findRaw'],
      aggregateRaw: json['aggregateRaw'],
    );
  }
}

class OtherOperations {
  List<String> read;
  List<String> write;

  OtherOperations({
    this.read = const [],
    this.write = const [],
  });

  static OtherOperations fromJson(Map json) {
    return OtherOperations(
      read: List<String>.from(json['read']),
      write: List<String>.from(json['write']),
    );
  }
}

class Schema {
  String? rootQueryType;
  String? rootMutationType;
  InputObjectTypes inputObjectTypes;
  OutputObjectTypes outputObjectTypes;
  dynamic enumTypes;

  Schema({
    required this.inputObjectTypes,
    required this.outputObjectTypes,
    this.enumTypes,
    this.rootQueryType,
    this.rootMutationType,
  });

  static Schema fromJson(Map json) {
    return Schema(
      rootQueryType: json['rootQueryType'],
      rootMutationType: json['rootMutationType'],
      enumTypes: json['enumTypes'],
      outputObjectTypes: OutputObjectTypes.fromJson(json['outputObjectTypes']),
      inputObjectTypes: InputObjectTypes.fromJson(json['inputObjectTypes']),
    );
  }
}

class Constraints {
  int? maxNumFields;
  int? minNumFields;

  Constraints({
    this.maxNumFields,
    this.minNumFields,
  });

  static Constraints fromJson(Map json) {
    return Constraints(
      maxNumFields: json['maxNumFields'],
      minNumFields: json['minNumFields'],
    );
  }
}

class InputType {
  String name;
  Constraints? constraints;
  List<SchemaArg> fields;
  Map<String, SchemaArg>? fieldMap;
  InputType({
    required this.name,
    this.constraints,
    required this.fields,
    this.fieldMap,
  });

  static InputType fromJson(Map json) {
    return InputType(
      name: json['name'],
      constraints: json.containsKey('constraints') ? Constraints.fromJson(json['constraints']) : null,
      fields: (json['fields'] as List).map((e) => SchemaArg.fromJson(e)).toList(),
      fieldMap: json.containsKey('fieldMap') ? json['fieldMap'] : null,
    );
  }
}

class OutputObjectTypes {
  List<OutputType> prisma;
  List<OutputType> model;

  OutputObjectTypes({
    required this.prisma,
    required this.model,
  });

  static OutputObjectTypes fromJson(Map json) {
    return OutputObjectTypes(
      prisma: (json['prisma'] as List).map((e) => OutputType.fromJson(e)).toList(),
      model: (json['model'] as List).map((e) => OutputType.fromJson(e)).toList(),
    );
  }
}

class InputObjectTypes {
  List<InputType> prisma;
  List<InputType> model;

  InputObjectTypes({
    required this.prisma,
    required this.model,
  });

  static InputObjectTypes fromJson(Map json) {
    return InputObjectTypes(
      prisma: (json['prisma'] as List).map((e) => InputType.fromJson(e)).toList(),
      model: json['model'] == null ? [] : (json['model'] as List).map((e) => InputType.fromJson(e)).toList(),
    );
  }
}

class OutputType {
  String name;
  List<SchemaField> fields;
  Map<String, SchemaField>? fieldMap;
  OutputType({
    required this.name,
    required this.fields,
    this.fieldMap,
  });

  static OutputType fromJson(Map json) {
    return OutputType(
      name: json['name'],
      fieldMap: json['fieldMap'],
      fields: (json['fields'] as List).map((e) => SchemaField.fromJson(e)).toList(),
    );
  }
}

class SchemaArg {
  String name;
  String? comment;
  bool isNullable;
  bool isRequired;
  List<SchemaArgInputType> inputTypes;
  Deprecation? deprecation;
  SchemaArg({
    required this.name,
    this.comment,
    required this.isNullable,
    required this.isRequired,
    required this.inputTypes,
    this.deprecation,
  });

  static SchemaArg fromJson(Map json) {
    return SchemaArg(
      name: json['name'],
      comment: json['comment'],
      isNullable: json['isNullable'] ?? false,
      isRequired: json['isRequired'] ?? false,
      inputTypes: json.containsKey('inputTypes') ? (json['inputTypes'] as List).map((e) => SchemaArgInputType.fromJson(e)).toList() : [],
    );
  }
}

class SchemaArgInputType {
  bool isList;
  dynamic type;
  dynamic location;
  dynamic namespace;
  SchemaArgInputType({
    required this.isList,
    required this.type,
    required this.location,
    required this.namespace,
  });

  static SchemaArgInputType fromJson(Map json) {
    return SchemaArgInputType(
      isList: json['isList'],
      type: json['type'],
      location: json['location'],
      namespace: json['namespace'],
    );
  }
}

class Deprecation {
  String sinceVersion;
  String reason;
  String? plannedRemovalVersion;
  Deprecation({
    required this.sinceVersion,
    required this.reason,
    this.plannedRemovalVersion,
  });

  static Deprecation fromJson(Map json) {
    return Deprecation(
      sinceVersion: json['sinceVersion'],
      reason: json['reason'],
      plannedRemovalVersion: json['plannedRemovalVersion'],
    );
  }
}

class SchemaField {
  String name;
  bool isNullable;
  SchemaArgInputType outputType;
  List<SchemaArg> args;
  Deprecation? deprecation;
  String? documentation;
  SchemaField({
    required this.name,
    required this.isNullable,
    required this.outputType,
    required this.args,
    this.deprecation,
    this.documentation,
  });

  static SchemaField fromJson(Map json) {
    return SchemaField(
      name: json['name'],
      isNullable: json['isNullable'],
      documentation: json['documentation'],
      outputType: SchemaArgInputType.fromJson(json['outputType']),
      deprecation: json.containsKey('deprecation') ? Deprecation.fromJson(json['deprecation']) : null,
      args: (json['args'] as List).map((e) => SchemaArg.fromJson(e)).toList(),
    );
  }
}
