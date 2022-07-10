import 'package:flutter_modular/flutter_modular.dart';

import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
