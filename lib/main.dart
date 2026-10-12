import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/theme/theme_controller.dart';
import 'features/auth/data/firebase_auth_service.dart';
import 'features/auth/data/noop_auth_service.dart';
import 'features/auth/domain/auth_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _installErrorHandlers();

  // Independent startup work runs in parallel to shorten time to first frame.
  final (authService, themeController, config) = await (
    _initAuth(),
    ThemeController.load(),
    AppConfig.load(),
  ).wait;

  runApp(
    App(
      authService: authService,
      themeController: themeController,
      config: config,
    ),
  );
}

/// Falls back to a no-op service so the UI still works when Firebase is
/// misconfigured or unavailable.
Future<AuthService> _initAuth() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseAuthService();
  } on Object catch (error, stack) {
    _reportError(error, stack);
    return const NoopAuthService();
  }
}

/// Single place to plug in crash reporting (Crashlytics, Sentry, ...).
void _reportError(Object error, StackTrace stack) {
  debugPrint('Unhandled error: $error\n$stack');
}

void _installErrorHandlers() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    _reportError(details.exception, details.stack ?? StackTrace.current);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    _reportError(error, stack);
    return true;
  };
}
