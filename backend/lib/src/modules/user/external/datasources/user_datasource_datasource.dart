import 'package:backend/src/modules/user/domain/entities/user_entity.dart';

import '../../../../core/services/postgres_connect.dart';
import '../../infra/datasources/user_datasource.dart';

class UserDatasourceImpl implements UserDatasource {
  final IPostgresConnect pg;

  UserDatasourceImpl(this.pg);

  @override
  Future createUser(UserEntity user) async {
    final connection = await pg.connection;
    final results = await connection.mappedResultsQuery(
      'INSERT INTO public."User"(email, name, role, "imageUrl") VALUES (@email, @name, @role, @imageUrl);',
      substitutionValues: {
        'email': user.email,
        'name': user.name,
        'role': user.role.name,
        'imageUrl': user.imageUrl,
      },
    );
    final userList = results.where((element) => element.containsKey('User')).map((e) => e['User']!);

    return userList.first;
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
}
