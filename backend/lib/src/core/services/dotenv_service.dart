import 'dart:io';

class DotEnvService {
  final Map<String, String> _map;
  DotEnvService._(this._map);

  static DotEnvService? _instance;

  static Future<DotEnvService> instance([String path = '.env']) async {
    if (_instance == null) {
      final fileEnv = File(path);
      final existFile = await fileEnv.exists();
      if (!existFile) {
        throw Exception('File not found (${fileEnv.path})');
      }

      final envText = await fileEnv.readAsString();
      final localMap = <String, String>{};
      for (var line in envText.split('\n')) {
        line = line.trim();
        final key = line.split('=').first;

        line = line.replaceFirst('$key=', '').replaceAll('"', '').replaceAll("'", '');
        localMap[key.trim()] = line.trim();
      }

      _instance = DotEnvService._(localMap);
    }

    return _instance!;
  }

  String? operator [](String key) => _map[key];
}
