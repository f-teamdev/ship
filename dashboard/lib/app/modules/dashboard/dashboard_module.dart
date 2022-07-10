import 'package:admin/app/modules/dashboard/dashboard_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => DashboardPage()),
      ];
}
