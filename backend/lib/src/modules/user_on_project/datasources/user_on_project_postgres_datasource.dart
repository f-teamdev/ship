import 'package:backend/src/modules/user_on_project/repositories/user_on_project_datasource.dart';

import '../../../core/services/postgres_connect.dart';

class UserOnProjectPostgresDatasource implements UserOnProjectDatasource {
  final IPostgresConnect pg;

  UserOnProjectPostgresDatasource(this.pg);

  @override
  Future<List> getUsersByProjectId(int projectId) async {
    final connection = await pg.connection;

    final results = await connection.mappedResultsQuery(
      '''
        SELECT u.id, u.email, u.active, u."role", u."name", u."imageUrl"
	      FROM public."UserOnProject" as up
	      INNER JOIN public."User" as u
          ON u.id = up."idUser" 
	      WHERE up."idProject" = $projectId;
      ''',
    );
    final userList = results.where((element) => element.containsKey('User')).map((e) => e['User']!).toList();
    return userList;
  }

  @override
  Future<List> getProjectsByUserId(int userId) async {
    final connection = await pg.connection;

    final results = await connection.mappedResultsQuery(
      '''
             SELECT p.id, p."imageUrl", p."active", p.description, p.title
	      FROM public."UserOnProject" as up
	      INNER JOIN public."Project" as p
          ON p.id = up."idProject"
	      WHERE up."idUser" = $userId;
      ''',
    );

    final userList = results.where((element) => element.containsKey('Project')).map((e) => e['Project']!).toList();
    return userList;
  }
}
