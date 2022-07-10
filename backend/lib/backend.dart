import 'dart:io';

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
      jsonEncoder(),
    ],
  );
}

shelf.Middleware jsonEncoder() {
  return (innerHanddler) {
    return (request) async {
      var response = await innerHanddler(request);
      final isFile = request.url.pathSegments.contains('file') && request.method.toUpperCase() == 'GET';
      if (!isFile) {
        response = response.change(headers: {
          ...response.headers,
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }

      return response;
    };
  };
}
