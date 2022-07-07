import 'dart:async';
import 'dart:convert';

import 'package:backend/src/modules/user/infra/adapters/user_adapter.dart';
import 'package:backend/src/modules/user_on_project/repositories/user_on_project_repository_interface.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../../project/infra/adapters/project_adapter.dart';

class UserOnProjectResource extends Resource {
  @override
  List<Route> get routes => [
        Route.get('/usersByProjectId/:projectId', _getUsersByProjectId),
        Route.get('/projectsByUserId/:userId', _getProjectsByUserId),
      ];

  FutureOr<Response> _getUsersByProjectId(ModularArguments arguments, Injector injector) async {
    final projectId = int.parse(arguments.params['projectId']);
    final repository = injector.get<UserOnProjectRepository>();

    var result = await repository.getUsersByProjectId(projectId);
    return result
        .map((users) => users.map(UserAdapter.toJson).toList())
        .map(jsonEncode)
        .mapLeft(
          (error) => jsonEncode({'error': error.message}),
        )
        .fold(
          (error) => Response.internalServerError(body: error),
          Response.ok,
        );
  }

  FutureOr<Response> _getProjectsByUserId(ModularArguments arguments, Injector injector) async {
    final userId = int.parse(arguments.params['userId']);
    final repository = injector.get<UserOnProjectRepository>();

    var result = await repository.getProjectsByUserId(userId);
    return result
        .map((projects) => projects.map(ProjectAdapter.toJson).toList())
        .map(jsonEncode)
        .mapLeft(
          (error) => jsonEncode({'error': error.message}),
        )
        .fold(
          (error) => Response.internalServerError(body: error),
          Response.ok,
        );
  }
}
