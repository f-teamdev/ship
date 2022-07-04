import 'dart:async';

import 'package:shelf/shelf.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

class SwaggerHandler {
  final swagger = SwaggerUI(
    'swagger/swagger.yaml',
    title: 'Ship API',
    deepLink: true,
  );

  FutureOr<Response> call(Request request) {
    return swagger(request);
  }
}
