import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Owns the user-selected [ThemeMode]; persisted when [prefs] is provided.
class ThemeController extends ChangeNotifier {
  ThemeController({
    SharedPreferences? store,
    ThemeMode initialMode = ThemeMode.system,
  }) : _prefs = store,
       _mode = initialMode;

  static const _key = 'theme_mode';

  final SharedPreferences? _prefs;
  ThemeMode _mode;

  ThemeMode get mode => _mode;

  static Future<ThemeController> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    final mode = ThemeMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => ThemeMode.system,
    );
    return ThemeController(store: prefs, initialMode: mode);
  }

  void setMode(ThemeMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
    _prefs?.setString(_key, mode.name);
  }
}
