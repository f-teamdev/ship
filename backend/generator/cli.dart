void main(List<String> args) async {
  // var dmmf = await File('dmmf.json').readAsString();
  // final json = jsonDecode(dmmf);

  // final result = {"jsonrpc": "2.0", "method": "generate", "params": json, "id": 1};
  // await File('mock.json').writeAsString(jsonEncode(result));

  // print(stdin.readLineSync());

  await PostSchema().findMany();
}

class PostSchema {
  Future<List<String>> findMany() async {
    final queryBuffer = StringBuffer();
    final fields = <Map<String, List>>[
      {'id': []},
      {'title': []},
      {'published': []},
      {'authorId': []},
      {
        'author': <Map<String, List>>[
          {'id': []},
          {'name': []},
          {'createdAt': []},
        ]
      },
    ];
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
    queryBuffer.writeln(' result: findManyPost');
    queryBuffer.writeln('{');
    for (var field in fields) {
      _addField(field);
    }
    queryBuffer.writeln('}');
    queryBuffer.writeln('}');

    print(queryBuffer);
    return [];
  }
}
