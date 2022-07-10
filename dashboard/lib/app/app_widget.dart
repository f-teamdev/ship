import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_fonts/google_fonts.dart';

import 'modules/auth/presentation/states/auth_state.dart';
import 'modules/auth/presentation/stores/auth_store.dart';
import 'shared/constants.dart';

class AppWidget extends StatefulWidget {
  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final Disposer disposer;

  @override
  void initState() {
    super.initState();
    final authStore = Modular.get<AuthStore>();

    disposer = authStore.observer(
      onState: (state) {
        if (state is Logged) {
          Modular.to.navigate('/home/');
        } else if (state is Unlogged) {
          Modular.to.navigate('/auth/');
        }
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 2));
      await authStore.checkAuth();
    });
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

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
