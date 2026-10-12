import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'core/app_scope.dart';
import 'core/config/app_config.dart';
import 'core/localization/locale_controller.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/auth/domain/auth_service.dart';
import 'features/auth/domain/auth_session.dart';
import 'l10n/generated/app_localizations.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.authService,
    this.themeController,
    this.localeController,
    this.config = AppConfig.empty,
  });

  final AuthService authService;
  final ThemeController? themeController;
  final LocaleController? localeController;
  final AppConfig config;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthSession _session = AuthSession(widget.authService);
  late final GoRouter _router = createRouter(_session);
  late final ThemeController _themeController =
      widget.themeController ?? ThemeController();
  late final LocaleController _localeController =
      widget.localeController ?? LocaleController();

  @override
  void dispose() {
    _router.dispose();
    _session.dispose();
    if (widget.themeController == null) _themeController.dispose();
    if (widget.localeController == null) _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([_localeController, _themeController]),
      builder: (context, _) => MaterialApp.router(
        onGenerateTitle: (context) =>
            widget.config.nameOr(AppLocalizations.of(context).appName),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: _themeController.mode,
        locale: _localeController.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: _router,
        builder: (context, child) => AppScope(
          authService: widget.authService,
          session: _session,
          localeController: _localeController,
          themeController: _themeController,
          config: widget.config,
          child: _ReadyGate(session: _session, child: child!),
        ),
      ),
    );
  }
}

/// Shows a loader until the first auth state arrives. Only this small
/// subtree listens to the session, the routed [child] is reused as-is.
class _ReadyGate extends StatelessWidget {
  const _ReadyGate({required this.session, required this.child});

  final AuthSession session;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      child: child,
      builder: (context, child) =>
          session.isReady ? child! : const _StartupLoader(),
    );
  }
}

class _StartupLoader extends StatelessWidget {
  const _StartupLoader();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox.square(
          dimension: 32,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
