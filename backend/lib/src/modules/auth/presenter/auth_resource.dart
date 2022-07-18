import 'dart:async';
import 'dart:convert';

import 'package:backend/src/modules/auth/domain/usecases/update_password.dart';
import 'package:backend/src/modules/auth/presenter/extensions/tokenization_extension.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../domain/errors/errors.dart';
import '../domain/usecases/check_token.dart';
import '../domain/usecases/login.dart';
import '../domain/usecases/refresh_token.dart';
import 'guards/auth_guard.dart';

class AuthResource implements Resource {
  @override
  List<Route> get routes => [
        Route.get('/login', login),
        Route.get('/refresh_token', refreshToken),
        Route.get('/check_token', checkToken, middlewares: [AuthGuard()]),
        Route.put('/update_password', _updatePassword, middlewares: [AuthGuard()]),
      ];

  FutureOr<Response> login(Request request, Injector injector) async {
    final credentials = request.headers['authorization']?.split(' ').last;

    if (credentials == null || credentials.isEmpty) {
      return Response.forbidden(jsonEncode({'error': 'Authorization not found'}));
    }

    final result = await injector.get<Login>().call(credentials: credentials);
    return result.fold((l) => Response.forbidden(jsonEncode({'error': l.message})), (r) => Response.ok(r.toJson()));
  }

  FutureOr<Response> refreshToken(Request request, Injector injector) async {
    final refreshToken = request.headers['authorization']?.split(' ').last;

    if (refreshToken == null || refreshToken.isEmpty) {
      return Response.forbidden(jsonEncode({'error': 'RefreshToken not found'}));
    }
    final result = await injector.get<RefreshToken>().call(refreshToken: refreshToken);
    return result.fold((l) => Response.forbidden(jsonEncode({'error': l.message})), (r) => Response.ok(r.toJson()));
  }

  FutureOr<Response> _updatePassword(Request request, ModularArguments args, Injector injector) async {
    final accessToken = request.headers['authorization']!.split(' ').last;
    final data = args.data as Map;

    final updatePassword = injector.get<UpdatePassword>();
    final checkToken = injector.get<CheckToken>();

    final tokenResult = await checkToken(accessToken: accessToken);
    final result = await tokenResult
        .map((clams) => clams['id'])
        .bind<UpdatePasswordParams>((id) {
          if (data.containsKey('password') && data.containsKey('newPassword')) {
            return right(UpdatePasswordParams(id: id, newPassword: data['newPassword'], password: data['password']));
          }
          return left(PasswordValidate('Incorrect params'));
        })
        .bindFuture(updatePassword)
        .run();

    return result.fold(
      (l) => Response(500, body: jsonEncode({'error': l.message})),
      (r) => Response.ok(jsonEncode({'message': 'ok'})),
    );
  }

  FutureOr<Response> checkToken() {
    return Response.ok(jsonEncode({'status': 'ok!'}));
  }
}
