import 'package:flutter/widgets.dart';

import '../features/auth/domain/auth_service.dart';
import '../features/auth/domain/auth_session.dart';
import 'config/app_config.dart';
import 'localization/locale_controller.dart';
import 'theme/theme_controller.dart';

/// Gives screens access to app-wide services without prop drilling.
class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.authService,
    required this.session,
    required this.localeController,
    required this.themeController,
    required this.config,
    required super.child,
  });

  final AuthService authService;
  final AuthSession session;
  final LocaleController localeController;
  final ThemeController themeController;
  final AppConfig config;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in the widget tree');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => false;
}
