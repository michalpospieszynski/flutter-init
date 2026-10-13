// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appName => 'Aurora';

  @override
  String get languageLabel => 'Język';

  @override
  String get languageEnglish => 'Angielski';

  @override
  String get languagePolish => 'Polski';

  @override
  String get themeLabel => 'Motyw';

  @override
  String get themeSystem => 'Systemowy';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get heroBadge => 'Wersja demo';

  @override
  String get heroTitle => 'Jedno bezpieczne logowanie. Każde urządzenie.';

  @override
  String get heroSubtitle =>
      'Loguj się przez Google, Microsoft lub e-mail w przeglądarce, na Androidzie i iOS. Dopracowana, zlokalizowana baza, którą dopasujesz do marki swojego produktu.';

  @override
  String get authTitle => 'Witaj';

  @override
  String get authSubtitle => 'Zaloguj się lub utwórz konto, aby kontynuować.';

  @override
  String get continueWithGoogle => 'Kontynuuj z Google';

  @override
  String get continueWithMicrosoft => 'Kontynuuj z Microsoft';

  @override
  String get authDivider => 'lub użyj e-maila';

  @override
  String get authNotConfigured =>
      'Uwierzytelnianie nie jest jeszcze podłączone. Wkrótce będzie dostępne.';

  @override
  String get authFailed => 'Coś poszło nie tak. Spróbuj ponownie.';

  @override
  String get authEmailLabel => 'E-mail';

  @override
  String get authPasswordLabel => 'Hasło';

  @override
  String get authFieldRequired => 'To pole jest wymagane.';

  @override
  String get authInvalidEmail => 'Podaj prawidłowy adres e-mail.';

  @override
  String get authPasswordTooShort => 'Użyj co najmniej 6 znaków.';

  @override
  String get authShowPassword => 'Pokaż hasło';

  @override
  String get authHidePassword => 'Ukryj hasło';

  @override
  String get authForgotPassword => 'Nie pamiętasz hasła?';

  @override
  String authResetSent(String email) {
    return 'Jeśli istnieje konto dla $email, wysłaliśmy link do zresetowania hasła.';
  }

  @override
  String get authSignInWithEmail => 'Zaloguj się';

  @override
  String get authCreateAccount => 'Utwórz konto';

  @override
  String get authSwitchToCreate => 'Nie masz konta? Utwórz je';

  @override
  String get authSwitchToSignIn => 'Masz już konto? Zaloguj się';

  @override
  String get authErrorInvalidCredentials => 'Nieprawidłowy e-mail lub hasło.';

  @override
  String get authErrorEmailInUse =>
      'Konto z tym adresem e-mail już istnieje. Spróbuj się zalogować.';

  @override
  String get authErrorWeakPassword =>
      'To hasło jest zbyt słabe. Użyj co najmniej 6 znaków.';

  @override
  String get authErrorInvalidEmail => 'Podaj prawidłowy adres e-mail.';

  @override
  String get authErrorTooManyRequests =>
      'Zbyt wiele prób. Odczekaj chwilę i spróbuj ponownie.';

  @override
  String get authErrorNetwork =>
      'Błąd sieci. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get authErrorPopupBlocked =>
      'Przeglądarka zablokowała okno logowania. Zezwól na wyskakujące okna dla tej strony i spróbuj ponownie.';

  @override
  String get authErrorUserDisabled => 'To konto zostało wyłączone.';

  @override
  String get authErrorNotEnabled =>
      'Ta metoda logowania nie jest jeszcze włączona.';

  @override
  String get authAccountLinkRequired =>
      'Ten adres e-mail jest już zarejestrowany innym sposobem logowania. Zaloguj się najpierw tym sposobem, a następnie powiąż tę metodę w swoim profilu.';

  @override
  String authLinkAccount(String provider) {
    return 'Powiąż konto $provider';
  }

  @override
  String authLinkTitle(String provider) {
    return 'Powiąż konto $provider';
  }

  @override
  String authLinkBody(String provider) {
    return 'Próbowano zalogować się przez $provider. Powiąż tę metodę z tym kontem, aby następnym razem móc używać obu.';
  }

  @override
  String authLinked(String provider) {
    return 'Konto $provider zostało powiązane.';
  }

  @override
  String get authVerifyTitle => 'Zweryfikuj swój e-mail';

  @override
  String authVerifyBody(String email) {
    return 'Wysłaliśmy link weryfikacyjny na adres $email. Otwórz go, a następnie potwierdź tutaj.';
  }

  @override
  String get authVerifyResend => 'Wyślij ponownie';

  @override
  String get authVerifyConfirm => 'Zweryfikowano';

  @override
  String get authVerifySent => 'Wysłano e-mail weryfikacyjny.';

  @override
  String get authVerifyStillPending =>
      'Twój e-mail nie jest jeszcze zweryfikowany.';

  @override
  String get authSignOut => 'Wyloguj się';

  @override
  String get navHome => 'Start';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Ustawienia';

  @override
  String homeGreeting(String name) {
    return 'Witaj ponownie, $name';
  }

  @override
  String get homeSubtitle =>
      'Jesteś zalogowany. Oto, dokąd możesz przejść dalej.';

  @override
  String get homeCardProfileTitle => 'Twój profil';

  @override
  String get homeCardProfileDescription =>
      'Sprawdź swoje konto i używane metody logowania.';

  @override
  String get homeCardSettingsTitle => 'Ustawienia';

  @override
  String get homeCardSettingsDescription =>
      'Wybierz język oraz jasny lub ciemny wygląd.';

  @override
  String get homeCardSecurityTitle => 'Metody logowania';

  @override
  String get homeCardSecurityDescription =>
      'Powiąż Google, Microsoft i e-mail z jednym kontem.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileProviders => 'Metody logowania';

  @override
  String get profileEmailVerified => 'E-mail zweryfikowany';

  @override
  String get profileEmailNotVerified => 'E-mail niezweryfikowany';

  @override
  String get providerGoogle => 'Google';

  @override
  String get providerMicrosoft => 'Microsoft';

  @override
  String get providerPassword => 'E-mail i hasło';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get settingsAppearance => 'Wygląd';

  @override
  String get settingsLanguage => 'Język';

  @override
  String get settingsAccount => 'Konto';

  @override
  String get notFoundTitle => 'Nie znaleziono strony';

  @override
  String get notFoundBody => 'Strona, której szukasz, nie istnieje.';

  @override
  String get notFoundAction => 'Przejdź na start';

  @override
  String get featuresTitle => 'Stworzone dla prawdziwych produktów';

  @override
  String get featureLocalizationTitle => 'Wielojęzyczność';

  @override
  String get featureLocalizationDescription =>
      'Angielski i polski od razu, z prostym sposobem na dodanie kolejnych języków.';

  @override
  String get featureThemeTitle => 'Nowoczesny wygląd';

  @override
  String get featureThemeDescription =>
      'Dopracowany projekt Material 3 z motywem jasnym, ciemnym i systemowym.';

  @override
  String get featureAuthTitle => 'Bezpieczne logowanie';

  @override
  String get featureAuthDescription =>
      'Logowanie przez Google, Microsoft i e-mail z łączeniem kont i weryfikacją e-maila.';

  @override
  String get featureStructureTitle => 'Jedna baza kodu';

  @override
  String get featureStructureDescription =>
      'Web, Android i iOS z jednego, przejrzyście zorganizowanego projektu Flutter.';

  @override
  String footerCopyright(String year, String author) {
    return '© $year $author. Wszelkie prawa zastrzeżone.';
  }

  @override
  String get footerContact => 'Kontakt';

  @override
  String get legalPrivacy => 'Polityka prywatności';

  @override
  String get legalTerms => 'Regulamin';

  @override
  String get legalLoadError => 'Nie udało się wczytać dokumentu.';

  @override
  String get settingsLegal => 'Informacje prawne';

  @override
  String get authLegalNotice => 'Kontynuując, akceptujesz';
}
