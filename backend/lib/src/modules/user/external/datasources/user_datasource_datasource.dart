import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/errors/errors.dart';

import '../../../../core/services/postgres_connect.dart';
import '../../infra/datasources/user_datasource.dart';

class UserDatasourceImpl implements UserDatasource {
  final IPostgresConnect pg;

  UserDatasourceImpl(this.pg);

  @override
  Future createUser(Map<String, dynamic> userMap) async {
    final connection = await pg.connection;

    final results = await connection.mappedResultsQuery(
      'INSERT INTO public."User"(email, name, role, "imageUrl", password) VALUES (@email, @name, @role, @imageUrl, @password) RETURNING id, email, name, role, "imageUrl", active;',
      substitutionValues: userMap,
    );
    final userList = results.where((element) => element.containsKey('User')).map((e) => e['User']!);
    final userReturning = userList.first;
    return userReturning;
  }

  @override
  Future updateUser(UserEntity userMap) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future updatePassword({required int id, required String newPassword}) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future getUserById(int id) async {
    final connection = await pg.connection;

    final results = await connection.mappedResultsQuery(
      'SELECT id, email, name, role, active, "imageUrl" FROM public."User" WHERE id=@id;',
      substitutionValues: {'id': id},
    );
    final userList = results.where((element) => element.containsKey('User')).map((e) => e['User']!);

    if (userList.isEmpty) {
      throw UserNotFound('UserId $id not found');
    }

    final userReturning = userList.first;
    return userReturning;
  }

  @override
  Future<List> getUsers() async {
    final connection = await pg.connection;

    final results = await connection.mappedResultsQuery(
      'SELECT id, email, name, role, active, "imageUrl" FROM public."User";',
    );
    final userList = results.where((element) => element.containsKey('User')).map((e) => e['User']!).toList();
    return userList;
  }
}
