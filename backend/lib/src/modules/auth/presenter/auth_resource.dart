import 'dart:async';
import 'dart:convert';

import 'package:backend/src/modules/auth/presenter/extensions/tokenization_extension.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../domain/usecases/login.dart';
import '../domain/usecases/refresh_token.dart';
import 'guards/auth_guard.dart';

class AuthResource implements Resource {
  @override
  List<Route> get routes => [
        Route.get('/login', login),
        Route.get('/refresh_token/:token', refreshToken),
        Route.get('/check_token', checkToken, middlewares: [AuthGuard()]),
      ];

  FutureOr<Response> login(Request request, Injector injector) async {
    final credentials = request.headers['Authorization']?.split(' ').last;

    if (credentials == null || credentials.isEmpty) {
      return Response.forbidden(jsonEncode({'error': 'Authorization not found'}));
    }

    final result = await injector.get<Login>().call(credentials: credentials);
    return result.fold((l) => Response.forbidden(jsonEncode({'error': l.message})), (r) => Response.ok(r.toJson()));
  }

  FutureOr<Response> refreshToken(Request request, ModularArguments args, Injector injector) async {
    final result = await injector.get<RefreshToken>().call(refreshToken: args.params['token']);
    return result.fold((l) => Response.forbidden(jsonEncode({'error': l.message})), (r) => Response.ok(r.toJson()));
  }

  FutureOr<Response> checkToken() {
    return Response.ok(jsonEncode({'status': 'ok!'}));
  }
}
