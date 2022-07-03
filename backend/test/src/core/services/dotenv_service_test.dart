import 'package:backend/src/core/services/dotenv_service.dart';
import 'package:test/test.dart';

void main() {
  test('dotenv service start', () async {
    final dotEnv = await DotEnvService.instance('test/src/core/services/.env');

    expect(dotEnv['DATABASE_URL'], 'postgresql://postgres:postgres@localhost:5432/fteam?schema=public');
    expect(dotEnv['TEST'], 'test');
    expect(dotEnv['NUMERIC'], '1');
    expect(dotEnv['SPACE'], 'test space');
  });
}
