import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../auth/presentation/stores/auth_store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authStore = Modular.get<AuthStore>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material();
  }
}
