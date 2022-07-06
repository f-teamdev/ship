import 'package:shelf_modular/shelf_modular.dart';

import 'external/datasources/user_datasource_datasource.dart';
import 'infra/datasources/user_datasource.dart';
import 'infra/repositories/project_repository.dart';
import 'presenter/user_resource.dart';

class UserModule extends Module {
  @override
  final List<Bind> binds = [
    // external
    Bind.factory<UserDatasource>((i) => UserDatasourceImpl(i())),
    // infra
    Bind.factory<UserRepository>((i) => UserRepositoryImpl(i(), i())),
    // domain
    Bind.factory<CreateUser>((i) => CreateUserImpl(i())),
    Bind.factory<UpdateUser>((i) => UpdateUserImpl(i())),
    Bind.factory<GetUserById>((i) => GetUserByidImpl(i())),
    Bind.factory<GetUsers>((i) => GetUsersImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    Route.resource('/', resource: UserResource()),
  ];
}
