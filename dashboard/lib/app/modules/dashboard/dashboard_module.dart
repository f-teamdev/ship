import 'package:flutter_modular/flutter_modular.dart';

import 'dashboard_page.dart';

class DashboardModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const DashboardPage()),
      ];
}
