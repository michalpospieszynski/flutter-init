// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Aurora';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languagePolish => 'Polish';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get heroBadge => 'Live demo';

  @override
  String get heroTitle => 'One secure sign-in. Every device.';

  @override
  String get heroSubtitle =>
      'Sign in with Google, Microsoft or email on web, Android and iOS. A polished, localized and brandable foundation for your next product.';

  @override
  String get authTitle => 'Welcome';

  @override
  String get authSubtitle => 'Sign in or create an account to continue.';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithMicrosoft => 'Continue with Microsoft';

  @override
  String get authDivider => 'or use your email';

  @override
  String get authNotConfigured =>
      'Authentication is not connected yet. It will be available soon.';

  @override
  String get authFailed => 'Something went wrong. Please try again.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authFieldRequired => 'This field is required.';

  @override
  String get authInvalidEmail => 'Enter a valid email address.';

  @override
  String get authPasswordTooShort => 'Use at least 6 characters.';

  @override
  String get authShowPassword => 'Show password';

  @override
  String get authHidePassword => 'Hide password';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String authResetSent(String email) {
    return 'If an account exists for $email, a password reset link is on its way.';
  }

  @override
  String get authSignInWithEmail => 'Sign in';

  @override
  String get authCreateAccount => 'Create account';

  @override
  String get authSwitchToCreate => 'No account yet? Create one';

  @override
  String get authSwitchToSignIn => 'Already have an account? Sign in';

  @override
  String get authErrorInvalidCredentials => 'Incorrect email or password.';

  @override
  String get authErrorEmailInUse =>
      'An account with this email already exists. Try signing in instead.';

  @override
  String get authErrorWeakPassword =>
      'That password is too weak. Use at least 6 characters.';

  @override
  String get authErrorInvalidEmail => 'Enter a valid email address.';

  @override
  String get authErrorTooManyRequests =>
      'Too many attempts. Please wait a moment and try again.';

  @override
  String get authErrorNetwork =>
      'Network error. Check your connection and try again.';

  @override
  String get authErrorPopupBlocked =>
      'Your browser blocked the sign-in popup. Allow popups for this site and try again.';

  @override
  String get authErrorUserDisabled => 'This account has been disabled.';

  @override
  String get authErrorNotEnabled => 'This sign-in method is not enabled yet.';

  @override
  String get authAccountLinkRequired =>
      'This email is already registered with another sign-in method. Sign in with that method first, then link this one from your profile.';

  @override
  String authLinkAccount(String provider) {
    return 'Link $provider account';
  }

  @override
  String authLinkTitle(String provider) {
    return 'Link your $provider account';
  }

  @override
  String authLinkBody(String provider) {
    return 'You tried to sign in with $provider. Link it to this account to use either method next time.';
  }

  @override
  String authLinked(String provider) {
    return '$provider account linked.';
  }

  @override
  String get authVerifyTitle => 'Verify your email';

  @override
  String authVerifyBody(String email) {
    return 'We sent a verification link to $email. Open it, then confirm here.';
  }

  @override
  String get authVerifyResend => 'Resend email';

  @override
  String get authVerifyConfirm => 'I\'ve verified';

  @override
  String get authVerifySent => 'Verification email sent.';

  @override
  String get authVerifyStillPending => 'Your email is not verified yet.';

  @override
  String get authSignOut => 'Sign out';

  @override
  String get navHome => 'Home';

  @override
  String get navProfile => 'Profile';

  @override
  String get navSettings => 'Settings';

  @override
  String homeGreeting(String name) {
    return 'Welcome back, $name';
  }

  @override
  String get homeSubtitle => 'You are signed in. Here is where to go next.';

  @override
  String get homeCardProfileTitle => 'Your profile';

  @override
  String get homeCardProfileDescription =>
      'Review your account and the sign-in methods you use.';

  @override
  String get homeCardSettingsTitle => 'Settings';

  @override
  String get homeCardSettingsDescription =>
      'Choose your language and light or dark appearance.';

  @override
  String get homeCardSecurityTitle => 'Sign-in methods';

  @override
  String get homeCardSecurityDescription =>
      'Link Google, Microsoft and email to one account.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileProviders => 'Sign-in methods';

  @override
  String get profileEmailVerified => 'Email verified';

  @override
  String get profileEmailNotVerified => 'Email not verified';

  @override
  String get providerGoogle => 'Google';

  @override
  String get providerMicrosoft => 'Microsoft';

  @override
  String get providerPassword => 'Email and password';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAccount => 'Account';

  @override
  String get notFoundTitle => 'Page not found';

  @override
  String get notFoundBody => 'The page you are looking for does not exist.';

  @override
  String get notFoundAction => 'Go to start';

  @override
  String get featuresTitle => 'Built for real products';

  @override
  String get featureLocalizationTitle => 'Multilingual';

  @override
  String get featureLocalizationDescription =>
      'English and Polish out of the box, with an easy way to add more languages.';

  @override
  String get featureThemeTitle => 'Modern design';

  @override
  String get featureThemeDescription =>
      'A polished Material 3 design with light, dark and system themes.';

  @override
  String get featureAuthTitle => 'Secure sign-in';

  @override
  String get featureAuthDescription =>
      'Google, Microsoft and email sign-in with account linking and email verification.';

  @override
  String get featureStructureTitle => 'One codebase';

  @override
  String get featureStructureDescription =>
      'Web, Android and iOS from a single, cleanly structured Flutter project.';

  @override
  String footerCopyright(String year, String author) {
    return '© $year $author. All rights reserved.';
  }

  @override
  String get footerContact => 'Contact';

  @override
  String get legalPrivacy => 'Privacy Policy';

  @override
  String get legalTerms => 'Terms of Service';

  @override
  String get legalLoadError => 'This document could not be loaded.';

  @override
  String get settingsLegal => 'Legal';

  @override
  String get authLegalNotice => 'Continuing means you accept our';
}
