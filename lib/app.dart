import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/locale_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/domain/auth_service.dart';
import 'features/home/presentation/home_page.dart';
import 'l10n/generated/app_localizations.dart';

class App extends StatefulWidget {
  const App({super.key, required this.authService});

  final AuthService authService;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final LocaleController _localeController = LocaleController();

  @override
  void dispose() {
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _localeController,
      builder: (context, _) => MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context).appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        locale: _localeController.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: HomePage(
          authService: widget.authService,
          localeController: _localeController,
        ),
      ),
    );
  }
}
