import 'package:flutter_modular/flutter_modular.dart';
import 'package:ship_dashboard/app/modules/dashboard/dashboard_page.dart';

class DashboardModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => DashboardPage()),
      ];
}
