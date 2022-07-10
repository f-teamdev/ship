import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'shared/constants.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/auth/');
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ship FTeam',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white,
        ),
        canvasColor: secondaryColor,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
