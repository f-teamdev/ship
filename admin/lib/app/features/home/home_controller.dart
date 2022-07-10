import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class HomeController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final _headText = RxNotifier<String>('ERP');
  String get headText => _headText.value;
  set headText(String value) => _headText.value = value;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
