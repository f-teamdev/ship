import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final _completer = Completer<SharedPreferences>();
  LocalData() {
    _init();
  }

  Future<void> _init() async {
    _completer.complete(SharedPreferences.getInstance());
  }

  Future<void> put(String key, String value) async {
    final shared = await _completer.future;
    shared.setString(key, value);
  }

  Future<String> get(String key) async {
    final shared = await _completer.future;
    return shared.getString(key) ?? '';
  }

  Future<void> remove(String key) async {
    final shared = await _completer.future;
    shared.remove(key);
  }
}
