import 'package:backend/backend.dart';
import 'package:backend/src/core/services/postgres_connect.dart';
import 'package:mocktail/mocktail.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

class DotEnvServiceMock extends Mock implements DotEnvService {}

void main() {
  test('postgres connect', () async {
    final postgres = PostgresConnect(DotEnvServiceMock());

    final connection = postgres.generateConnectionByDatabaseUrl('postgresql://postgres:postgres@localhost:5432/fteam?schema=public');
    expect(connection, isA<PostgreSQLConnection>());
  });
}
