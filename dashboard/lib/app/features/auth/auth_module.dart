import 'package:flutter_modular/flutter_modular.dart';

import 'auth_controller.dart';
import 'auth_page.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => AuthController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => AuthPage()),
      ];
}
