import 'dart:async';

import 'package:backend/backend.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf_modular/shelf_modular.dart';

abstract class IPostgresConnect implements Disposable {
  Future<PostgreSQLConnection> get connection;
}

class PostgresConnect implements IPostgresConnect {
  final _completer = Completer<PostgreSQLConnection>();

  final DotEnvService _dotEnvService;

  PostgresConnect(this._dotEnvService);

  Future<PostgreSQLConnection> _openConection() async {
    final databaseUrl = _dotEnvService['DATABASE_URL']!;

    final connection = generateConnectionByDatabaseUrl(databaseUrl);
    await connection.open();
    return connection;
  }

  @visibleForTesting
  PostgreSQLConnection generateConnectionByDatabaseUrl(String databaseUrl) {
    final uri = Uri.parse(databaseUrl);
    final host = uri.host;
    final port = uri.port;
    final username = uri.userInfo.split(':').first;
    final password = uri.userInfo.split(':').last;
    final database = uri.pathSegments.first;
    print('Postgres: $host, port: $port');
    return PostgreSQLConnection(host, port, database, username: username, password: password, isUnixSocket: false);
  }

  @override
  void dispose() async {
    final pg = await _completer.future;
    await pg.close();
    print('Postgres Closed!');
  }

  @override
  Future<PostgreSQLConnection> get connection {
    if (!_completer.isCompleted) {
      _completer.complete(_openConection());
    }

    return _completer.future;
  }
}
