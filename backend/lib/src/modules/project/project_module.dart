import 'package:backend/src/modules/project/presenter/project_resource.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'domain/repositories/project_repository.dart';
import 'domain/usecases/create_project.dart';
import 'domain/usecases/get_project_by_id.dart';
import 'domain/usecases/get_projects.dart';
import 'domain/usecases/update_projects.dart';
import 'external/datasources/project_datasource_datasource.dart';
import 'infra/datasources/project_datasource.dart';
import 'infra/repositories/project_repository.dart';

class ProjectModule extends Module {
  @override
  final List<Bind> binds = [
    // external
    Bind.factory<ProjectDatasource>((i) => ProjectDatasourceImpl(i())),
    // infra
    Bind.factory<ProjectRepository>((i) => ProjectRepositoryImpl(i(), i())),
    // domain
    Bind.factory<CreateProject>((i) => CreateProjectImpl(i())),
    Bind.factory<UpdateProject>((i) => UpdateProjectImpl(i())),
    Bind.factory<GetProjectById>((i) => GetProjectByidImpl(i())),
    Bind.factory<GetProjects>((i) => GetProjectsImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    Route.resource('/', resource: ProjectResource()),
  ];
}
