import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../../domain/usecases/check_token.dart';

// class AuthGuard extends RouteGuard {
//   @override
//   FutureOr<bool> canActivate(Request request, Route route) async {
//     final accessToken = request.headers['authorization']?.split(' ').last;
//     if (accessToken == null || accessToken.isEmpty) {
//       return false;
//     }
//     final result = await Modular.get<CheckToken>().call(accessToken: accessToken);
//     return result.fold((l) => false, (r) => true);
//   }
// }

class AuthGuard extends ModularMiddleware {
  final List<String> allowedRoles;

  AuthGuard({this.allowedRoles = const []});

  @override
  Handler call(Handler handler, [ModularRoute? route]) {
    return (request) async {
      final accessToken = request.headers['authorization']?.split(' ').last;
      if (accessToken == null || accessToken.isEmpty) {
        return Response.forbidden(jsonEncode({'error': 'Authorization header is Empty'}));
      }

      final checkToken = await Modular.get<CheckToken>()(accessToken: accessToken);
      return checkToken.fold(
        (l) => Response.forbidden(jsonEncode({'error': l.toString()})),
        (claims) {
          final role = claims['role'];
          if (allowedRoles.isEmpty || allowedRoles.contains(role)) {
            return handler(request);
          }

          return Response.forbidden(jsonEncode({'error': 'Role $role not allowed.'}));
        },
      );
    };
  }
}
