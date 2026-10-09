import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

  /// Application name shown in the app bar and window title.
  ///
  /// In en, this message translates to:
  /// **'AppName'**
  String get appName;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languagePolish.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get languagePolish;

  /// No description provided for @heroBadge.
  ///
  /// In en, this message translates to:
  /// **'Starter template'**
  String get heroBadge;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Build your next idea, faster.'**
  String get heroTitle;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A clean, modern foundation for your Flutter apps. Localization, theming and authentication are ready, so you can focus on what makes your product unique.'**
  String get heroSubtitle;

  /// No description provided for @authTitle.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get authTitle;

  /// No description provided for @authSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in or create an account to continue.'**
  String get authSubtitle;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithMicrosoft.
  ///
  /// In en, this message translates to:
  /// **'Continue with Microsoft'**
  String get continueWithMicrosoft;

  /// No description provided for @createAccountWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Create an account with email'**
  String get createAccountWithEmail;

  /// No description provided for @authDivider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get authDivider;

  /// No description provided for @authNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Authentication is not connected yet. It will be available soon.'**
  String get authNotConfigured;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'Everything you need to start'**
  String get featuresTitle;

  /// No description provided for @featureLocalizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Multilingual'**
  String get featureLocalizationTitle;

  /// No description provided for @featureLocalizationDescription.
  ///
  /// In en, this message translates to:
  /// **'English and Polish out of the box, with an easy way to add more languages.'**
  String get featureLocalizationDescription;

  /// No description provided for @featureThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Modern design'**
  String get featureThemeTitle;

  /// No description provided for @featureThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'A minimal Material 3 theme with automatic light and dark modes.'**
  String get featureThemeDescription;

  /// No description provided for @featureAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Auth-ready'**
  String get featureAuthTitle;

  /// No description provided for @featureAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Google, Microsoft and email sign-in behind a single, swappable service.'**
  String get featureAuthDescription;

  /// No description provided for @featureStructureTitle.
  ///
  /// In en, this message translates to:
  /// **'Clean structure'**
  String get featureStructureTitle;

  /// No description provided for @featureStructureDescription.
  ///
  /// In en, this message translates to:
  /// **'Feature-based folders that stay organized as your project grows.'**
  String get featureStructureDescription;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© {year} {appName}. All rights reserved.'**
  String footerCopyright(int year, String appName);

  /// No description provided for @footerPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get footerPrivacy;

  /// No description provided for @footerTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get footerTerms;

  /// No description provided for @footerContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get footerContact;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
