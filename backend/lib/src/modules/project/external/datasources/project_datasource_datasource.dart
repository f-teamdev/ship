import 'package:backend/src/core/services/postgres_connect.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasources/project_datasource.dart';

class ProjectDatasourceImpl implements ProjectDatasource {
  final IPostgresConnect pg;

  ProjectDatasourceImpl(this.pg);

  @override
  Future createProject(Map<String, dynamic> projectMap) async {
    final connection = await pg.connection;

    final results = await connection.mappedResultsQuery(
      'INSERT INTO public."Project"(title, description, "imageUrl") VALUES (@title, @description, @imageUrl) RETURNING id, description, title, "imageUrl", active;',
      substitutionValues: projectMap,
    );
    final projectList = results.where((element) => element.containsKey('Project')).map((e) => e['Project']!);
    final projectReturning = projectList.first;
    return projectReturning;
  }

  @override
  Future updateProject(Map<String, dynamic> projectMap) async {
    final connection = await pg.connection;

    final columns = projectMap.keys.where((e) => e != 'id').map((e) => '$e=@$e').toList();
    final results = await connection.mappedResultsQuery(
      'UPDATE public."Project"SET ${columns.join(',')} WHERE id=@id RETURNING id, description, title, "imageUrl", active;',
      substitutionValues: projectMap,
    );

    final projectList = results.where((element) => element.containsKey('Project')).map((e) => e['Project']!);
    final projectReturning = projectList.first;
    return projectReturning;
  }

  @override
  Future getProjectById(int id) async {
    final connection = await pg.connection;

    final results = await connection.mappedResultsQuery(
      'SELECT id, description, title, active, "imageUrl" FROM public."Project" WHERE id=@id;',
      substitutionValues: {'id': id},
    );
    final projectList = results.where((element) => element.containsKey('Project')).map((e) => e['Project']!);

    if (projectList.isEmpty) {
      throw ProjectNotFound('ProjectId $id not found');
    }

    final projectReturning = projectList.first;
    return projectReturning;
  }

  @override
  Future<List> getProjects() async {
    final connection = await pg.connection;

    final results = await connection.mappedResultsQuery(
      'SELECT id, description, title, active, "imageUrl" FROM public."Project";',
    );
    final projectList = results.where((element) => element.containsKey('Project')).map((e) => e['Project']!).toList();
    return projectList;
  }
}
