// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appName => 'AppName';

  @override
  String get languageLabel => 'Język';

  @override
  String get languageEnglish => 'Angielski';

  @override
  String get languagePolish => 'Polski';

  @override
  String get heroBadge => 'Szablon startowy';

  @override
  String get heroTitle => 'Zbuduj swój następny pomysł szybciej.';

  @override
  String get heroSubtitle =>
      'Czysta, nowoczesna baza dla Twoich aplikacji we Flutterze. Lokalizacja, motywy i uwierzytelnianie są gotowe, więc możesz skupić się na tym, co wyróżnia Twój produkt.';

  @override
  String get authTitle => 'Zacznij już teraz';

  @override
  String get authSubtitle => 'Zaloguj się lub utwórz konto, aby kontynuować.';

  @override
  String get continueWithGoogle => 'Kontynuuj z Google';

  @override
  String get continueWithMicrosoft => 'Kontynuuj z Microsoft';

  @override
  String get createAccountWithEmail => 'Utwórz konto za pomocą e-maila';

  @override
  String get authDivider => 'lub';

  @override
  String get authNotConfigured =>
      'Uwierzytelnianie nie jest jeszcze podłączone. Wkrótce będzie dostępne.';

  @override
  String get featuresTitle => 'Wszystko, czego potrzebujesz na start';

  @override
  String get featureLocalizationTitle => 'Wielojęzyczność';

  @override
  String get featureLocalizationDescription =>
      'Angielski i polski od razu, z prostym sposobem na dodanie kolejnych języków.';

  @override
  String get featureThemeTitle => 'Nowoczesny wygląd';

  @override
  String get featureThemeDescription =>
      'Minimalistyczny motyw Material 3 z automatycznym trybem jasnym i ciemnym.';

  @override
  String get featureAuthTitle => 'Gotowe na logowanie';

  @override
  String get featureAuthDescription =>
      'Logowanie przez Google, Microsoft i e-mail za jedną, wymienialną usługą.';

  @override
  String get featureStructureTitle => 'Przejrzysta struktura';

  @override
  String get featureStructureDescription =>
      'Foldery podzielone na funkcje, które pozostają uporządkowane wraz ze wzrostem projektu.';

  @override
  String footerCopyright(int year, String appName) {
    final intl.NumberFormat yearNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String yearString = yearNumberFormat.format(year);

    return '© $yearString $appName. Wszelkie prawa zastrzeżone.';
  }

  @override
  String get footerPrivacy => 'Polityka prywatności';

  @override
  String get footerTerms => 'Regulamin';

  @override
  String get footerContact => 'Kontakt';
}
