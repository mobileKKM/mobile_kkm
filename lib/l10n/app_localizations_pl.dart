// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Hasło';

  @override
  String get newPasswordLabel => 'Nowe hasło';

  @override
  String get repeatPasswordLabel => 'Powtórz hasło';

  @override
  String get showPassword => 'Pokaż hasło';

  @override
  String get hidePassword => 'Ukryj hasło';

  @override
  String get fieldRequired => 'To pole jest wymagane';

  @override
  String get emailInvalid => 'Podaj poprawny adres e-mail';

  @override
  String get passwordTooWeak => 'Hasło nie spełnia wymagań';

  @override
  String get passwordsDontMatch => 'Hasła nie są takie same';

  @override
  String passwordRuleMinLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Co najmniej $count znaku',
      many: 'Co najmniej $count znaków',
      few: 'Co najmniej $count znaki',
      one: 'Co najmniej 1 znak',
    );
    return '$_temp0';
  }

  @override
  String passwordRuleLowercase(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Co najmniej $count małej litery',
      many: 'Co najmniej $count małych liter',
      few: 'Co najmniej $count małe litery',
      one: 'Co najmniej 1 mała litera',
    );
    return '$_temp0';
  }

  @override
  String passwordRuleUppercase(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Co najmniej $count wielkiej litery',
      many: 'Co najmniej $count wielkich liter',
      few: 'Co najmniej $count wielkie litery',
      one: 'Co najmniej 1 wielka litera',
    );
    return '$_temp0';
  }

  @override
  String passwordRuleDigits(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Co najmniej $count cyfry',
      many: 'Co najmniej $count cyfr',
      few: 'Co najmniej $count cyfry',
      one: 'Co najmniej 1 cyfra',
    );
    return '$_temp0';
  }

  @override
  String get errorNetwork => 'Nie udało się połączyć z serwerem. Sprawdź połączenie z internetem i spróbuj ponownie.';

  @override
  String get errorGeneric => 'Coś poszło nie tak. Spróbuj ponownie.';

  @override
  String get errorInvalidCredentials => 'Nieprawidłowy e-mail lub hasło.';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get loginTitle => 'Logowanie';

  @override
  String get loginSubtitle => 'Użyj swojego konta pasażera EKP';

  @override
  String get loginSubmit => 'Zaloguj się';

  @override
  String get forgotPasswordLink => 'Nie pamiętasz hasła?';

  @override
  String get noAccountPrompt => 'Nie masz konta?';

  @override
  String get registerLink => 'Załóż konto';

  @override
  String get sessionExpiredNotice => 'Sesja wygasła. Zaloguj się ponownie.';

  @override
  String get passwordResetDoneNotice => 'Hasło zostało zmienione. Możesz się zalogować.';

  @override
  String get registerTitle => 'Załóż konto';

  @override
  String get sectionPersonal => 'Dane osobowe';

  @override
  String get sectionContact => 'Dane kontaktowe';

  @override
  String get sectionPassword => 'Hasło';

  @override
  String get repeatEmailLabel => 'Powtórz e-mail';

  @override
  String get emailsDontMatch => 'Adresy e-mail nie są takie same';

  @override
  String get consentRequired => 'Wymagane jest wyrażenie zgody';

  @override
  String get regulationsLink => 'Regulamin';

  @override
  String get dataNoticeTitle => 'Przetwarzanie danych osobowych';

  @override
  String get showMore => 'Pokaż więcej';

  @override
  String get showLess => 'Pokaż mniej';

  @override
  String get firstNameLabel => 'Imię';

  @override
  String get lastNameLabel => 'Nazwisko';

  @override
  String get peselLabel => 'Numer PESEL';

  @override
  String get peselInvalid => 'Podaj poprawny numer PESEL';

  @override
  String get noPeselCheckbox => 'Nie posiadam numeru PESEL';

  @override
  String get birthDateLabel => 'Data urodzenia';

  @override
  String get birthDateFromPeselHelper => 'Uzupełniana na podstawie numeru PESEL';

  @override
  String get birthDateRequired => 'Wybierz datę urodzenia';

  @override
  String get consentsLoadError => 'Nie udało się wczytać zgód.';

  @override
  String get registerSubmit => 'Załóż konto';

  @override
  String get alreadyHaveAccountPrompt => 'Masz już konto?';

  @override
  String get signInLink => 'Zaloguj się';

  @override
  String get forgotTitle => 'Resetowanie hasła';

  @override
  String get forgotBody => 'Podaj adres e-mail swojego konta, a wyślemy Ci link do ustawienia nowego hasła.';

  @override
  String get forgotSubmit => 'Wyślij link';

  @override
  String get inboxTitle => 'Sprawdź skrzynkę';

  @override
  String inboxRegistrationBody(String email) {
    return 'Wysłaliśmy link aktywacyjny na adres $email. Otwórz go, aby aktywować konto, a następnie zaloguj się.';
  }

  @override
  String inboxResetBody(String email) {
    return 'Jeśli istnieje konto dla adresu $email, wysłaliśmy link do ustawienia nowego hasła.';
  }

  @override
  String get inboxBrowserHint => 'Link otworzy się w przeglądarce. Dokończ tam, a potem wróć i zaloguj się.';

  @override
  String get inboxAppHint => 'Otwórz link na tym urządzeniu, aby kontynuować w aplikacji.';

  @override
  String get inboxEnableLinksHint =>
      'Aby kontynuować w aplikacji, zezwól mobileKKM na otwieranie linków ekp.mpk.krakow.pl. W przeciwnym razie link otworzy się w przeglądarce.';

  @override
  String get openLinkSettings => 'Otwórz ustawienia linków';

  @override
  String get backToLogin => 'Wróć do logowania';

  @override
  String get resetTitle => 'Ustaw nowe hasło';

  @override
  String get resetSubmit => 'Zmień hasło';

  @override
  String get activateTitle => 'Aktywacja konta';

  @override
  String get activateInProgress => 'Aktywujemy Twoje konto…';

  @override
  String get activateSuccess => 'Konto jest aktywne. Możesz się zalogować.';

  @override
  String get activateFailure => 'Nie udało się aktywować konta. Link mógł wygasnąć lub został już użyty.';

  @override
  String get continueToLogin => 'Przejdź do logowania';

  @override
  String get homePlaceholder => 'Zalogowano. Bilety pojawią się wkrótce.';

  @override
  String get logout => 'Wyloguj się';
}
