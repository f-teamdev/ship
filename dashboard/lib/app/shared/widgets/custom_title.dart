import 'package:admin/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../constants.dart';

class CustomTitle extends StatefulWidget {
  final Widget child;
  final String title;
  const CustomTitle({Key? key, required this.child, required this.title}) : super(key: key);

  @override
  _CustomTitleState createState() => _CustomTitleState();
}

class _CustomTitleState extends State<CustomTitle> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Modular.get<HomeController>().headText = widget.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: widget.title,
      color: primaryColor,
      child: widget.child,
    );
  }
}
