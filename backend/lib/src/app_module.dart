import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../backend.dart';
import 'core/redis/redis_service.dart';
import 'core/services/bcrypt_service.dart';
import 'core/services/postgres_connect.dart';
import 'core/token/jose_token_manager.dart';
import 'core/token/token_manager.dart';
import 'modules/auth/auth_module.dart';
import 'modules/file/resources/uplodad_resource.dart';
import 'modules/project/project_module.dart';
import 'modules/swagger/guard/swagger_guard.dart';
import 'modules/swagger/swagger_handler.dart';
import 'modules/user/user_module.dart';

class AppModule extends Module {
  final DotEnvService _dotEnvService;

  AppModule(this._dotEnvService);

  @override
  List<Module> get imports => [
        AuthModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.instance<DotEnvService>(_dotEnvService),
        Bind.singleton((i) => RedisService(i())),
        Bind.factory<TokenManager>((i) => JoseTokenManager()),
        Bind.factory((i) => BCryptService()),
        Bind.singleton((i) => PostgresConnect(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get('/documentation', SwaggerHandler(), middlewares: [SwaggerGuard()]),
        Route.get('/', (Request request) => Response.ok('FTeam Backend v0.0.1')),
        Route.resource('/file', resource: UploadResource()),
        Route.module('/auth', module: AuthModule()),
        Route.module('/', module: UserModule()),
        Route.module('/', module: ProjectModule()),
      ];
}
