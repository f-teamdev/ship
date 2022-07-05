import 'dart:async';
import 'dart:convert';

import 'package:backend/src/modules/user/domain/usecases/create_user.dart';
import 'package:backend/src/modules/user/domain/usecases/get_user_by_id.dart';
import 'package:backend/src/modules/user/infra/adapters/user_adapter.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../../auth/presenter/guards/auth_guard.dart';
import '../domain/errors/errors.dart';
import '../domain/usecases/get_users.dart';

class UserResource extends Resource {
  @override
  List<Route> get routes => [
        Route.post('/user', _create, middlewares: [
          AuthGuard(['admin', 'manager'])
        ]),
        Route.get('/user', _getAllUser, middlewares: [AuthGuard()]),
        Route.get('/user/:id', _getUser, middlewares: [AuthGuard()]),
      ];

  FutureOr<Response> _create(ModularArguments arguments, Injector injector) async {
    final user = UserAdapter.fromJson(arguments.data
      ..remove('role')
      ..remove('active'));

    final createUser = injector.get<CreateUser>();
    final result = await createUser.call(user);

    return result.fold(
      (l) => Response(500, body: {'error': l.toString()}),
      (user) => Response.ok(jsonEncode(UserAdapter.toJson(user))),
    );
  }

  FutureOr<Response> _getUser(ModularArguments arguments, Injector injector) async {
    final id = int.parse(arguments.params['id']);
    final getUserByid = injector.get<GetUserById>();
    final result = await getUserByid.call(id);

    return result.fold(
      (l) {
        if (l is UserNotFound) {
          return Response(404, body: {'error': l.message});
        }
        return Response(500, body: {'error': l.toString()});
      },
      (user) => Response.ok(jsonEncode(UserAdapter.toJson(user))),
    );
  }

  FutureOr<Response> _getAllUser(ModularArguments arguments, Injector injector) async {
    final getUsers = injector.get<GetUsers>();
    final result = await getUsers.call();
    return result.fold(
      (l) => Response(500, body: {'error': l.toString()}),
      (users) {
        final mapList = users.map(UserAdapter.toJson).toList();
        return Response.ok(jsonEncode(mapList));
      },
    );
  }
}
