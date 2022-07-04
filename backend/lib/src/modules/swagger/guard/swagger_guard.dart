import 'dart:convert';

import 'package:backend/backend.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

class SwaggerGuard extends ModularMiddleware {
  bool get activateSwagger {
    final dotEnvService = Modular.get<DotEnvService>();
    return dotEnvService.containKey('SWAGGER') ? dotEnvService['SWAGGER'] == 'true' : false;
  }

  @override
  Handler call(Handler handler, [ModularRoute? route]) {
    return (request) {
      if (!activateSwagger) {
        return Response.forbidden(jsonEncode({'error': 'swagger was desabled'}));
      }
      return handler(request);
    };
  }
}
