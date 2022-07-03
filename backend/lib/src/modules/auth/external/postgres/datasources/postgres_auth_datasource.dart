import 'package:backend/src/modules/auth/external/errors/errors.dart';
import 'package:backend/src/modules/auth/infra/datasources/auth_datasource.dart';

import '../../../../../core/redis/redis_service.dart';
import '../../../../../core/services/postgres_connect.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final IRedisService redis;
  final IPostgresConnect pg;

  AuthDatasourceImpl({required this.redis, required this.pg});

  @override
  Future fromCredentials({required String email}) async {
    final connection = await pg.connection;
    final results = await connection.mappedResultsQuery(
      'SELECT id, password, role FROM public."User" WHERE email=@email AND active=true',
      substitutionValues: {'email': email},
    );
    final userList = results.where((element) => element.containsKey('User')).map((e) => e['User']!);

    if (userList.isEmpty) {
      throw NotAuthorized('Usuário não cadastrado');
    }

    return userList.first;
  }

  @override
  Future<Map<String, dynamic>> removeToken({required String token}) async {
    final userIdMap = await redis.getMap(token);
    if (userIdMap.isEmpty) {
      throw NotAuthorized('Revoked token');
    }

    await redis.delete(token);
    return userIdMap;
  }

  @override
  Future<void> saveRefreshToken({
    required String key,
    required Map<String, dynamic> value,
    required Duration expiresIn,
  }) async {
    await redis.setMap(
      key,
      value,
      expiresIn,
    );
  }
}
