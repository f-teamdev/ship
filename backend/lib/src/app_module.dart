import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../backend.dart';
import 'core/redis/redis_service.dart';
import 'core/services/postgres_connect.dart';
import 'core/token/token_manager.dart';
import 'modules/auth/auth_module.dart';
import 'modules/file/resources/uplodad_resource.dart';

class AppModule extends Module {
  final DotEnvService _dotEnvService;

  AppModule(this._dotEnvService);

  @override
  List<Bind> get binds => [
        Bind.instance<DotEnvService>(_dotEnvService),
        Bind.singleton((i) => RedisService()),
        Bind.factory((i) => TokenManager()),
        Bind.singleton((i) => PostgresConnect(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        Route.get('/', (Request request) => Response.ok('FTeam Backend v0.0.1')),
        Route.module('/auth', module: AuthModule()),
        Route.resource('/file', resource: UploadResource()),
      ];
}
