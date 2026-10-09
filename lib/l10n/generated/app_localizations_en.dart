// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'AppName';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languagePolish => 'Polish';

  @override
  String get heroBadge => 'Starter template';

  @override
  String get heroTitle => 'Build your next idea, faster.';

  @override
  String get heroSubtitle =>
      'A clean, modern foundation for your Flutter apps. Localization, theming and authentication are ready, so you can focus on what makes your product unique.';

  @override
  String get authTitle => 'Get started';

  @override
  String get authSubtitle => 'Sign in or create an account to continue.';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithMicrosoft => 'Continue with Microsoft';

  @override
  String get createAccountWithEmail => 'Create an account with email';

  @override
  String get authDivider => 'or';

  @override
  String get authNotConfigured =>
      'Authentication is not connected yet. It will be available soon.';

  @override
  String get featuresTitle => 'Everything you need to start';

  @override
  String get featureLocalizationTitle => 'Multilingual';

  @override
  String get featureLocalizationDescription =>
      'English and Polish out of the box, with an easy way to add more languages.';

  @override
  String get featureThemeTitle => 'Modern design';

  @override
  String get featureThemeDescription =>
      'A minimal Material 3 theme with automatic light and dark modes.';

  @override
  String get featureAuthTitle => 'Auth-ready';

  @override
  String get featureAuthDescription =>
      'Google, Microsoft and email sign-in behind a single, swappable service.';

  @override
  String get featureStructureTitle => 'Clean structure';

  @override
  String get featureStructureDescription =>
      'Feature-based folders that stay organized as your project grows.';

  @override
  String footerCopyright(int year, String appName) {
    final intl.NumberFormat yearNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String yearString = yearNumberFormat.format(year);

    return '© $yearString $appName. All rights reserved.';
  }

  @override
  String get footerPrivacy => 'Privacy Policy';

  @override
  String get footerTerms => 'Terms of Service';

  @override
  String get footerContact => 'Contact';
}
