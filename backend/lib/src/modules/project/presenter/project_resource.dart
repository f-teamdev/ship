import 'dart:async';
import 'dart:convert';

import 'package:backend/src/modules/project/infra/adapters/project_adapter.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_modular/shelf_modular.dart';

import '../../auth/presenter/guards/auth_guard.dart';
import '../domain/errors/errors.dart';
import '../domain/usecases/create_project.dart';
import '../domain/usecases/get_project_by_id.dart';
import '../domain/usecases/get_projects.dart';
import '../domain/usecases/update_projects.dart';
import '../infra/adapters/project_adapter.dart';

class ProjectResource extends Resource {
  @override
  List<Route> get routes => [
        Route.post('/project', _create, middlewares: [
          AuthGuard(allowedRoles: ['admin', 'manager'])
        ]),
        Route.get('/project', _getAllProject, middlewares: [AuthGuard()]),
        Route.get('/project/:id', _getProject, middlewares: [AuthGuard()]),
        Route.put('/project', _update, middlewares: [
          AuthGuard(allowedRoles: ['admin', 'manager'])
        ]),
      ];

  FutureOr<Response> _create(ModularArguments arguments, Injector injector) async {
    final project = ProjectAdapter.fromJson(arguments.data);

    final createProject = injector.get<CreateProject>();
    final result = await createProject.call(project);

    return result.fold(
      (l) => Response(500, body: {'error': l.toString()}),
      (project) => Response.ok(jsonEncode(ProjectAdapter.toJson(project))),
    );
  }

  FutureOr<Response> _update(Request request, ModularArguments arguments, Injector injector) async {
    final updateProject = injector.get<UpdateProject>();
    final data = arguments.data as Map;

    if (data.isEmpty) {
      return Response.badRequest(body: jsonEncode({'error': 'Zero Payload'}));
    }

    final updateProjectParams = UpdateProjectParams.fromJson(data);

    final result = await updateProject(updateProjectParams);

    return result.fold(
      (l) => Response(l is ProjectNotFound ? 404 : 500, body: {'error': l.message}),
      (project) => Response.ok(
        jsonEncode(ProjectAdapter.toJson(project)),
      ),
    );
  }

  FutureOr<Response> _getProject(ModularArguments arguments, Injector injector) async {
    final id = int.parse(arguments.params['id']);
    final getProjectByid = injector.get<GetProjectById>();
    final result = await getProjectByid.call(id);

    return result.fold(
      (l) {
        if (l is ProjectNotFound) {
          return Response(404, body: {'error': l.message});
        }
        return Response(500, body: {'error': l.toString()});
      },
      (project) => Response.ok(jsonEncode(ProjectAdapter.toJson(project))),
    );
  }

  FutureOr<Response> _getAllProject(ModularArguments arguments, Injector injector) async {
    final getProjects = injector.get<GetProjects>();
    final result = await getProjects.call();
    return result.fold(
      (l) => Response(500, body: {'error': l.toString()}),
      (projects) {
        final mapList = projects.map(ProjectAdapter.toJson).toList();
        return Response.ok(jsonEncode(mapList));
      },
    );
  }
}
