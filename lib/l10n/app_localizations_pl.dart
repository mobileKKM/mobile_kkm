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
  String get updateRequiredTitle => 'Wymagana aktualizacja';

  @override
  String get updateRequiredBody =>
      'Ta wersja mobileKKM nie jest już obsługiwana przez system EKP. Zainstaluj najnowszą wersję, aby dalej korzystać z aplikacji.';

  @override
  String get updateRequiredAction => 'Pobierz najnowszą wersję';

  @override
  String get navHome => 'Start';

  @override
  String get navTickets => 'Bilety';

  @override
  String get navMap => 'Mapa';

  @override
  String get navBuy => 'Kup bilet';

  @override
  String get navAccount => 'Konto';

  @override
  String get comingSoon => 'Już wkrótce';

  @override
  String get comingSoonBody => 'Ta część aplikacji nie jest jeszcze gotowa.';

  @override
  String get offlineNotice => 'Brak połączenia. Wyświetlamy zapisane dane.';

  @override
  String get serviceUnavailableNotice => 'Usługa jest obecnie niedostępna.';

  @override
  String get linkOpenFailed => 'Nie udało się otworzyć linku.';

  @override
  String homeGreeting(String name) {
    return 'Cześć, $name!';
  }

  @override
  String get homeGreetingAnonymous => 'Cześć!';

  @override
  String get homeNoTicketTitle => 'Brak aktywnego biletu';

  @override
  String get homeNoTicketBody => 'Tutaj pojawi się Twój aktualny bilet.';

  @override
  String get quickActionDepartures => 'Odjazdy';

  @override
  String get mapSearchHint => 'Szukaj przystanku';

  @override
  String get mapMyLocation => 'Moja lokalizacja';

  @override
  String get mapCredits => 'Dane mapy';

  @override
  String get mapFilters => 'Filtry';

  @override
  String get mapLocationDenied => 'Zezwól na dostęp do lokalizacji, aby zobaczyć, gdzie jesteś.';

  @override
  String get mapLocationServiceOff => 'Lokalizacja jest wyłączona na tym urządzeniu.';

  @override
  String get mapLocationSettings => 'Ustawienia';

  @override
  String get cityCardTitle => 'Karta Krakowska';

  @override
  String get subscriptionTitle => 'Bilet półroczny 5+1';

  @override
  String get subscriptionCtaBody => 'Sprawdź ofertę i dołącz';

  @override
  String get ticketsActive => 'Aktywne';

  @override
  String get ticketsPast => 'Minione';

  @override
  String get ticketsEmptyActive => 'Nie masz jeszcze biletów.';

  @override
  String get ticketsEmptyPast => 'Brak minionych biletów.';

  @override
  String get ticketsLoadError => 'Nie udało się wczytać biletów.';

  @override
  String get ticketTitleMetropolitan => 'Bilet metropolitalny';

  @override
  String get ticketTitleNetwork => 'Bilet sieciowy';

  @override
  String ticketTitleLines(int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Linie $lines', one: 'Linia $lines');
    return '$_temp0';
  }

  @override
  String get ticketTitleGeneric => 'Bilet';

  @override
  String get ticketStatusPending => 'Oczekuje na płatność';

  @override
  String get ticketStatusReturned => 'Zwrócony';

  @override
  String ticketStatusValidFrom(String date) {
    return 'Ważny od $date';
  }

  @override
  String get ticketStatusUpcoming => 'Jeszcze nieważny';

  @override
  String get ticketStatusValid => 'Ważny';

  @override
  String get ticketStatusExpired => 'Wygasł';

  @override
  String get ticketOptions => 'Opcje biletu';

  @override
  String get ticketPin => 'Przypnij na ekranie głównym';

  @override
  String get ticketUnpin => 'Odepnij';

  @override
  String get ticketPinned => 'Przypięty';

  @override
  String get accountCustomerCode => 'Kod klienta';

  @override
  String get accountSectionProfile => 'Moje konto';

  @override
  String get cityCardActive => 'Aktywna';

  @override
  String get cityCardInactive => 'Nieaktywna';

  @override
  String get accountRegulationsHint => 'Regulamin, zakupy, 5+1';

  @override
  String get accountContactMpkHint => 'Bilety, płatności, Karta Krakowska';

  @override
  String get accountContactDeveloperHint => 'Błędy i sugestie dotyczące aplikacji';

  @override
  String get accountSectionHelp => 'Pomoc';

  @override
  String get accountSectionSecurity => 'Bezpieczeństwo';

  @override
  String get accountEdit => 'Edytuj konto';

  @override
  String get accountRegulations => 'Regulaminy';

  @override
  String get regulationsAccount => 'Regulamin Elektronicznego Konta Pasażera';

  @override
  String get regulationsPurchase => 'Regulamin internetowej sprzedaży biletów';

  @override
  String get regulationsSubscription => 'Regulamin Biletu Półrocznego';

  @override
  String get regulationsLoadError => 'Nie udało się wczytać regulaminów.';

  @override
  String get accountContactMpk => 'Kontakt z MPK Kraków';

  @override
  String get accountContactDeveloper => 'Kontakt z twórcą aplikacji';

  @override
  String get contactCall => 'Zadzwoń na infolinię';

  @override
  String get contactEmail => 'Napisz e-mail';

  @override
  String get contactReportIssue => 'Zgłoś problem na GitHubie';

  @override
  String get accountChangePassword => 'Zmień hasło';

  @override
  String get accountDelete => 'Usuń konto';

  @override
  String appVersion(String version) {
    return 'mobileKKM $version';
  }

  @override
  String get logoutConfirmTitle => 'Wylogować się?';

  @override
  String get logoutConfirmBody => 'Bilety przypisane do tego urządzenia pozostaną dostępne po ponownym zalogowaniu.';

  @override
  String get logoutConfirmAction => 'Wyloguj';

  @override
  String get cancel => 'Anuluj';

  @override
  String get logout => 'Wyloguj się';
}
