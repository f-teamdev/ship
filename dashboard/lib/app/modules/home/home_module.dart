import 'package:admin/app/modules/dashboard/dashboard_module.dart';
import 'package:admin/app/modules/transaction/transaction_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => HomeController()),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => HomePage(), children: [
          ModuleRoute('/dashboard', module: DashboardModule()),
          ModuleRoute('/transaction', module: TransactionModule()),
        ]),
      ];
}
