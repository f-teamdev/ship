import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_modular/shelf_modular.dart';

import 'backend.dart';
import 'src/app_module.dart';

export 'src/core/services/dotenv_service.dart';

Future<shelf.Handler> serverInicialization() async {
  final dotEnv = await DotEnvService.instance();

  return Modular(
    module: AppModule(dotEnv),
    middlewares: [
      shelf.logRequests(),
    ],
  );
}
