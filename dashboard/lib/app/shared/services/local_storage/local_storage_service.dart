import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> put(String key, String value) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString(key, value);
  }

  Future<String> get(String key) async {
    final shared = await SharedPreferences.getInstance();
    return shared.getString(key) ?? '';
  }

  Future<void> remove(String key) async {
    final shared = await SharedPreferences.getInstance();
    await shared.remove(key);
  }
}
