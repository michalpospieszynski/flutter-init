import 'package:flutter/material.dart';

/// Owns the user-selected locale. A `null` locale follows the device setting.
class LocaleController extends ChangeNotifier {
  LocaleController({Locale? initialLocale}) : _locale = initialLocale;

  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale? locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}
