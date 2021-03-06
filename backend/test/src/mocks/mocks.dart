import 'package:backend/src/modules/user/domain/entities/user_entity.dart';
import 'package:backend/src/modules/user/domain/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_core/modular_core.dart';
import 'package:shelf_modular/src/domain/services/bind_service.dart';
import 'package:shelf_modular/src/domain/services/module_service.dart';
import 'package:shelf_modular/src/domain/services/route_service.dart';

class BindServiceMock extends Mock implements BindService {}

class RouteServiceMock extends Mock implements RouteService {}

class ModuleServiceMock extends Mock implements ModuleService {}

class RouteContextMock extends Mock implements RouteContext {}

class ModularRouteMock extends Mock implements ModularRoute {}

class InjectorMock extends Mock implements Injector {}

class TrackerMock extends Mock implements Tracker {}

class UserRepositoryMock extends Mock implements UserRepository {}

class UserEntityMock extends Mock implements ProjectEntity {}
