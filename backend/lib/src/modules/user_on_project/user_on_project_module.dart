import 'package:backend/src/modules/user_on_project/repositories/user_on_project_datasource.dart';
import 'package:shelf_modular/shelf_modular.dart';

import 'datasources/user_on_project_postgres_datasource.dart';
import 'repositories/user_on_project_repository.dart';
import 'repositories/user_on_project_repository_interface.dart';
import 'resource/user_on_project_resource.dart';

class UserOnProjectModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<UserOnProjectDatasource>((i) => UserOnProjectPostgresDatasource(i())),
    Bind.factory<UserOnProjectRepository>((i) => UserOnProjectRepositoryImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    Route.resource('/userOnProject', resource: UserOnProjectResource()),
  ];
}
