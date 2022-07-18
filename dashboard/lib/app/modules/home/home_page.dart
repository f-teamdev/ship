import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../responsive.dart';
import '../../shared/constants.dart';
import 'components/header.dart';
import 'components/side_menu.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Modular.get<HomeController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Column(
                children: const [
                  Padding(padding: EdgeInsets.all(defaultPadding), child: Header()),
                  Expanded(child: ClipRRect(child: RouterOutlet())),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
