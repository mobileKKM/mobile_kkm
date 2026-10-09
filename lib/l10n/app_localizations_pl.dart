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
  String get activateInProgress => 'Aktywujemy Twoje konto…';

  @override
  String get activateSuccessTitle => 'Konto jest aktywne';

  @override
  String get activateSuccessBody => 'Możesz się zalogować.';

  @override
  String get activateFailureTitle => 'Nie udało się aktywować konta';

  @override
  String get activateFailureBody => 'Link mógł wygasnąć lub został już użyty.';

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
  String get ticketsHistory => 'Historia';

  @override
  String get ticketsEmptyActive => 'Nie masz jeszcze biletów.';

  @override
  String get ticketsEmptyHistory => 'Brak biletów w historii.';

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
  String get ticketPin => 'Przypnij na ekranie głównym';

  @override
  String get ticketUnpin => 'Odepnij';

  @override
  String get ticketPinned => 'Przypięty';

  @override
  String get ticketStatusProcessing => 'Trwa przetwarzanie płatności';

  @override
  String get ticketStatusAssignedElsewhere => 'Powiązany z innymi urządzeniami';

  @override
  String get ticketActionControl => 'Kontrola biletów';

  @override
  String get ticketActionAssign => 'Powiąż bilet';

  @override
  String get ticketActionContinuePayment => 'Kontynuuj płatność';

  @override
  String get ticketActionCheckPayment => 'Sprawdź płatność';

  @override
  String get ticketActionReturn => 'Zwróć bilet';

  @override
  String get ticketActionBuySimilar => 'Kup podobny';

  @override
  String get ticketActionExtend => 'Przedłuż bilet';

  @override
  String get ticketAssignDone => 'Bilet powiązano z tym urządzeniem.';

  @override
  String get ticketAssignError => 'Wystąpił błąd podczas powiązywania biletu, spróbuj ponownie.';

  @override
  String get ticketPaymentConfirmed => 'Płatność została zrealizowana.';

  @override
  String get ticketPaymentPending => 'Brak zaksięgowanej płatności.';

  @override
  String get ticketCantAssign =>
      'Bilet jest już powiązany z dwiema przeglądarkami/urządzeniami. Brak możliwości powiązania obecnego urządzenia. Użyj poprzednio powiązanych przeglądarek/urządzeń lub skontaktuj się z Infolinią MPK S.A. tel. 12 19 150.';

  @override
  String get ticketDetailsTitle => 'Szczegóły biletu';

  @override
  String get ticketDetailsLoadError => 'Nie udało się wczytać biletu.';

  @override
  String get ticketSectionPurchase => 'Zakup';

  @override
  String get ticketSectionReturn => 'Zwrot';

  @override
  String get ticketFieldPurchased => 'Zakupiony';

  @override
  String get ticketFieldPaid => 'Bilet opłacony';

  @override
  String get ticketFieldPaymentType => 'Typ płatności';

  @override
  String get ticketFieldPaymentState => 'Stan płatności';

  @override
  String get ticketFieldTransactionState => 'Stan transakcji';

  @override
  String get ticketFieldPromotion => 'Promocja';

  @override
  String get ticketFieldPrice => 'Cena';

  @override
  String get ticketFieldReturnOrdered => 'Data dyspozycji zwrotu';

  @override
  String get ticketFieldReturnedDays => 'Ilość zwróconych dni';

  @override
  String get ticketFieldRefundAmount => 'Kwota zwrotu';

  @override
  String get ticketFieldRefundMethod => 'Sposób zwrotu';

  @override
  String get ticketHistoryTitle => 'Historia';

  @override
  String get ticketHistoryTransaction => 'Transakcja';

  @override
  String get ticketHistoryPayment => 'Płatność';

  @override
  String get ticketHistoryRefund => 'Zwrot';

  @override
  String get yes => 'Tak';

  @override
  String get no => 'Nie';

  @override
  String get ticketReturnTitle => 'Zwrot biletu';

  @override
  String get ticketReturnNotice =>
      'Bilet jest ważny do końca dnia poprzedzającego wybraną datę, a jeśli jego ważność już się rozpoczęła, to co najmniej do końca bieżącego dnia.';

  @override
  String get ticketReturnFrom => 'Zwrot od dnia';

  @override
  String get ticketReturnChooseDate => 'Wybierz datę';

  @override
  String get ticketReturnPickerTitle => 'Wybierz datę zwrotu';

  @override
  String ticketReturnKeep(String date) {
    return 'Nadal ważny do $date';
  }

  @override
  String ticketReturnDaysBack(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dni do zwrotu',
      one: '1 dzień do zwrotu',
    );
    return '$_temp0';
  }

  @override
  String get ticketReturnYouGet => 'Otrzymasz zwrot';

  @override
  String get ticketReturnCalculating => 'Obliczamy kwotę zwrotu…';

  @override
  String get ticketReturnConfirmTitle => 'Zwrócić bilet?';

  @override
  String ticketReturnConfirmBody(String amount, String date) {
    return 'Zwrócimy $amount. Bilet pozostanie ważny do $date.';
  }

  @override
  String ticketReturnConfirmBodyPlain(String amount) {
    return 'Zwrócimy $amount. Tej operacji nie można cofnąć.';
  }

  @override
  String get ticketReturnDone => 'Bilet został pomyślnie zwrócony.';

  @override
  String get ticketReturnError => 'Nie udało się zwrócić biletu.';

  @override
  String get ticketControlCustomerCode => 'Numer klienta (mKKM)';

  @override
  String get ticketControlError => 'Wystąpił błąd podczas pobierania klucza, spróbuj ponownie.';

  @override
  String ticketControlTimeLeft(String time) {
    return 'Kod ważny jeszcze $time';
  }

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
  String appVersion(String version, String api) {
    return 'Wersja $version · eKP API $api';
  }

  @override
  String ticketDaysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'dni do końca', one: 'dzień do końca');
    return '$_temp0';
  }

  @override
  String ticketDaysUntilStart(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dni do rozpoczęcia',
      one: 'dzień do rozpoczęcia',
    );
    return '$_temp0';
  }

  @override
  String get ticketToday => 'Dziś';

  @override
  String ticketEndsAt(String time) {
    return 'kończy się o $time';
  }

  @override
  String ticketStartsAt(String time) {
    return 'zaczyna się o $time';
  }

  @override
  String ticketUntil(String date) {
    return 'do $date';
  }

  @override
  String ticketFrom(String date) {
    return 'od $date';
  }

  @override
  String ticketControlAvailableFrom(String date) {
    return 'Dostępna od $date';
  }

  @override
  String ticketControlFrom(String date) {
    return 'Kontrola biletów od $date';
  }

  @override
  String get ticketPinDone => 'Przypięto na ekranie Start';

  @override
  String get ticketUnpinDone => 'Odpięto';

  @override
  String homeTicketsAwaitingPayment(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count biletu oczekuje na płatność',
      many: '$count biletów oczekuje na płatność',
      few: '$count bilety oczekują na płatność',
      one: '1 bilet oczekuje na płatność',
    );
    return '$_temp0';
  }

  @override
  String homeCustomerCode(String code) {
    return 'Kod klienta $code';
  }

  @override
  String offlineSavedAt(String time) {
    return 'Zapisano $time';
  }

  @override
  String get ticketsEmptyBody => 'Tutaj pojawią się kupione bilety.';

  @override
  String get ticketDetailsManage => 'Zarządzaj';

  @override
  String get ticketActionChangeLine => 'Zmień linię';

  @override
  String get ticketActionChangeLineHint => 'Wybierz inną linię dla tego biletu';

  @override
  String ticketActionExtendHint(String date) {
    return 'Ten sam bilet ponownie, od $date';
  }

  @override
  String get ticketActionReturnHint => 'Zwrot pieniędzy za niewykorzystane dni';

  @override
  String get ticketActionBuySimilarHint => 'Rozpocznij zakup z tym biletem';

  @override
  String get ticketControlGettingCode => 'Pobieramy nowy kod…';

  @override
  String get ticketControlCodeFor => 'Kod ważny jeszcze';

  @override
  String get ticketControlFare => 'Ulga';

  @override
  String get ticketControlZone => 'Strefa';

  @override
  String get ticketControlValidUntil => 'Ważny do';

  @override
  String get ticketControlCaptureHidden => 'Kod jest ukryty podczas nagrywania ekranu.';

  @override
  String get loginSubmitting => 'Logowanie…';

  @override
  String get forgotSubmitting => 'Wysyłamy…';

  @override
  String get registerSubmitting => 'Zakładamy konto…';

  @override
  String get resetBody => 'Wybierz nowe hasło do swojego konta.';

  @override
  String get under16Title => 'Dokończ na stronie';

  @override
  String get under16Body =>
      'Osoby poniżej 16 roku życia mogą założyć konto tylko na stronie EKP. Otworzy się z uzupełnionymi danymi.';

  @override
  String get under16Action => 'Otwórz stronę';

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
