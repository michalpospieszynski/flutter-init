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
  /// **'Aurora'**
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

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @heroBadge.
  ///
  /// In en, this message translates to:
  /// **'Live demo'**
  String get heroBadge;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'One secure sign-in. Every device.'**
  String get heroTitle;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google, Microsoft or email on web, Android and iOS. A polished, localized and brandable foundation for your next product.'**
  String get heroSubtitle;

  /// No description provided for @authTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
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

  /// No description provided for @authDivider.
  ///
  /// In en, this message translates to:
  /// **'or use your email'**
  String get authDivider;

  /// No description provided for @authNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Authentication is not connected yet. It will be available soon.'**
  String get authNotConfigured;

  /// No description provided for @authFailed.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authFailed;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get authFieldRequired;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authInvalidEmail;

  /// No description provided for @authPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 6 characters.'**
  String get authPasswordTooShort;

  /// No description provided for @authShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get authShowPassword;

  /// No description provided for @authHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get authHidePassword;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authResetSent.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for {email}, a password reset link is on its way.'**
  String authResetSent(String email);

  /// No description provided for @authSignInWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignInWithEmail;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateAccount;

  /// No description provided for @authSwitchToCreate.
  ///
  /// In en, this message translates to:
  /// **'No account yet? Create one'**
  String get authSwitchToCreate;

  /// No description provided for @authSwitchToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get authSwitchToSignIn;

  /// No description provided for @authErrorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get authErrorInvalidCredentials;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists. Try signing in instead.'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'That password is too weak. Use at least 6 characters.'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait a moment and try again.'**
  String get authErrorTooManyRequests;

  /// No description provided for @authErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Check your connection and try again.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorPopupBlocked.
  ///
  /// In en, this message translates to:
  /// **'Your browser blocked the sign-in popup. Allow popups for this site and try again.'**
  String get authErrorPopupBlocked;

  /// No description provided for @authErrorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authErrorUserDisabled;

  /// No description provided for @authErrorNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'This sign-in method is not enabled yet.'**
  String get authErrorNotEnabled;

  /// No description provided for @authAccountLinkRequired.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered with another sign-in method. Sign in with that method first, then link this one from your profile.'**
  String get authAccountLinkRequired;

  /// No description provided for @authLinkAccount.
  ///
  /// In en, this message translates to:
  /// **'Link {provider} account'**
  String authLinkAccount(String provider);

  /// No description provided for @authLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Link your {provider} account'**
  String authLinkTitle(String provider);

  /// No description provided for @authLinkBody.
  ///
  /// In en, this message translates to:
  /// **'You tried to sign in with {provider}. Link it to this account to use either method next time.'**
  String authLinkBody(String provider);

  /// No description provided for @authLinked.
  ///
  /// In en, this message translates to:
  /// **'{provider} account linked.'**
  String authLinked(String provider);

  /// No description provided for @authVerifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get authVerifyTitle;

  /// No description provided for @authVerifyBody.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification link to {email}. Open it, then confirm here.'**
  String authVerifyBody(String email);

  /// No description provided for @authVerifyResend.
  ///
  /// In en, this message translates to:
  /// **'Resend email'**
  String get authVerifyResend;

  /// No description provided for @authVerifyConfirm.
  ///
  /// In en, this message translates to:
  /// **'I\'ve verified'**
  String get authVerifyConfirm;

  /// No description provided for @authVerifySent.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent.'**
  String get authVerifySent;

  /// No description provided for @authVerifyStillPending.
  ///
  /// In en, this message translates to:
  /// **'Your email is not verified yet.'**
  String get authVerifyStillPending;

  /// No description provided for @authSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get authSignOut;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}'**
  String homeGreeting(String name);

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You are signed in. Here is where to go next.'**
  String get homeSubtitle;

  /// No description provided for @homeCardProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get homeCardProfileTitle;

  /// No description provided for @homeCardProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'Review your account and the sign-in methods you use.'**
  String get homeCardProfileDescription;

  /// No description provided for @homeCardSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homeCardSettingsTitle;

  /// No description provided for @homeCardSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose your language and light or dark appearance.'**
  String get homeCardSettingsDescription;

  /// No description provided for @homeCardSecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign-in methods'**
  String get homeCardSecurityTitle;

  /// No description provided for @homeCardSecurityDescription.
  ///
  /// In en, this message translates to:
  /// **'Link Google, Microsoft and email to one account.'**
  String get homeCardSecurityDescription;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileProviders.
  ///
  /// In en, this message translates to:
  /// **'Sign-in methods'**
  String get profileProviders;

  /// No description provided for @profileEmailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email verified'**
  String get profileEmailVerified;

  /// No description provided for @profileEmailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Email not verified'**
  String get profileEmailNotVerified;

  /// No description provided for @providerGoogle.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get providerGoogle;

  /// No description provided for @providerMicrosoft.
  ///
  /// In en, this message translates to:
  /// **'Microsoft'**
  String get providerMicrosoft;

  /// No description provided for @providerPassword.
  ///
  /// In en, this message translates to:
  /// **'Email and password'**
  String get providerPassword;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @notFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get notFoundTitle;

  /// No description provided for @notFoundBody.
  ///
  /// In en, this message translates to:
  /// **'The page you are looking for does not exist.'**
  String get notFoundBody;

  /// No description provided for @notFoundAction.
  ///
  /// In en, this message translates to:
  /// **'Go to start'**
  String get notFoundAction;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'Built for real products'**
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
  /// **'A polished Material 3 design with light, dark and system themes.'**
  String get featureThemeDescription;

  /// No description provided for @featureAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Secure sign-in'**
  String get featureAuthTitle;

  /// No description provided for @featureAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Google, Microsoft and email sign-in with account linking and email verification.'**
  String get featureAuthDescription;

  /// No description provided for @featureStructureTitle.
  ///
  /// In en, this message translates to:
  /// **'One codebase'**
  String get featureStructureTitle;

  /// No description provided for @featureStructureDescription.
  ///
  /// In en, this message translates to:
  /// **'Web, Android and iOS from a single, cleanly structured Flutter project.'**
  String get featureStructureDescription;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© {year} {author}. All rights reserved.'**
  String footerCopyright(String year, String author);

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
