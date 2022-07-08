import 'package:backend/src/modules/auth/external/errors/errors.dart';
import 'package:backend/src/modules/auth/infra/datasources/auth_datasource.dart';

import '../../../../../core/services/postgres_connect.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final IPostgresConnect pg;

  AuthDatasourceImpl({required this.pg});

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
  Future fromId({required int id}) async {
    final connection = await pg.connection;
    final results = await connection.mappedResultsQuery(
      'SELECT id, password, role FROM public."User" WHERE id=@id AND active=true',
      substitutionValues: {'id': id},
    );
    final userList = results.where((element) => element.containsKey('User')).map((e) => e['User']!);

    if (userList.isEmpty) {
      throw NotAuthorized('Usuário não cadastrado');
    }

    return userList.first;
  }

  @override
  Future updatePassword({required int id, required String newPassword}) async {
    final connection = await pg.connection;

    final results = await connection.mappedResultsQuery(
      'UPDATE public."User"SET password=@password WHERE id=@id RETURNING id;',
      substitutionValues: {
        'id': id,
        'password': newPassword,
      },
    );

    final userList = results.where((element) => element.containsKey('User')).map((e) => e['User']!);

    if (userList.isEmpty) {
      throw PasswordNotUpdated('password not found');
    }
  }
}
