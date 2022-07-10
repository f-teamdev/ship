import 'package:flutter_modular/flutter_modular.dart';

import 'transaction_page.dart';

class TransactionModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => TransactionPage()),
      ];
}
