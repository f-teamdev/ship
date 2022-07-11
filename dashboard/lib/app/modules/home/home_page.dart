import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ship_dashboard/app/modules/home/components/header.dart';
import 'package:ship_dashboard/app/modules/home/home_controller.dart';
import 'package:ship_dashboard/app/shared/constants.dart';
import 'package:ship_dashboard/responsive.dart';

import 'components/side_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Modular.get<HomeController>().scaffoldKey,
      drawer: SideMenu(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
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
