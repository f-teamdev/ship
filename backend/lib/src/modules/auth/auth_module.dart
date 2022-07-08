import 'package:shelf_modular/shelf_modular.dart';

import 'domain/usecases/check_token.dart';
import 'domain/usecases/login.dart';
import 'domain/usecases/refresh_token.dart';
import 'domain/usecases/update_password.dart';
import 'external/postgres/datasources/postgres_auth_datasource.dart';
import 'infra/repositories/auth_repository.dart';
import 'presenter/auth_resource.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //external
        Bind.factory((i) => AuthDatasourceImpl(pg: i()), export: true),
        //infra
        Bind.factory((i) => AuthRepositoryImpl(i(), i(), i(), i()), export: true),
        //domain
        Bind.factory((i) => UpdatePasswordImpl(i()), export: true),
        Bind.factory((i) => LoginImpl(i())),
        Bind.factory((i) => RefreshTokenImpl(i()), export: true),
        Bind.factory((i) => CheckTokenImpl(i()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.resource('/', resource: AuthResource()),
      ];
}
