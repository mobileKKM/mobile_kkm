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
      one: 'Mała litera',
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
      one: 'Wielka litera',
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
      one: 'Cyfra',
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
  String get userDataFailed => 'Nie udało się wczytać danych konta, więc nastąpiło wylogowanie. Zaloguj się ponownie.';

  @override
  String get splashLoadingAccount => 'Wczytujemy konto…';

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
  String get ticketControlError => 'Nie udało się pobrać kodu. Sprawdź połączenie i spróbuj ponownie.';

  @override
  String get accountCustomerCode => 'Numer klienta';

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
    return 'Numer klienta $code';
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
  String get ticketControlGettingCode => 'Pobieramy kod…';

  @override
  String get ticketControlFare => 'Ulga';

  @override
  String get ticketControlValidUntil => 'Ważny do';

  @override
  String get ticketStatusCancelled => 'Anulowany';

  @override
  String get ticketHistoryStateCompleted => 'Zakończona';

  @override
  String get ticketHistoryStateCancelled => 'Anulowana';

  @override
  String get ticketCancelledNote => 'Płatność nie została dokończona na czas, więc zakup anulowano.';

  @override
  String get ticketActionBuyAgain => 'Kup ponownie';

  @override
  String get ticketDetailsProduct => 'Produkt';

  @override
  String ticketReturnKeepToday(String time) {
    return 'Nadal ważny do dziś, $time';
  }

  @override
  String ticketReturnStarts(String date) {
    return 'Początek $date';
  }

  @override
  String ticketReturnWhole(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zwrot całego biletu, wszystkie $count dni',
      one: 'Zwrot całego biletu, 1 dzień',
    );
    return '$_temp0';
  }

  @override
  String get ticketReturnFullPrice => 'Pełna cena. Bilet nie zacznie obowiązywać.';

  @override
  String ticketReturnConfirmBodyToday(String amount, String time) {
    return 'Zwrócimy $amount. Bilet pozostanie ważny do dziś, $time.';
  }

  @override
  String ticketReturnConfirmBodyWhole(String amount) {
    return 'Zwrócimy $amount. Bilet nie zacznie obowiązywać i zniknie z listy biletów.';
  }

  @override
  String get ticketReturnDoneWhole => 'Bilet zwrócony i usunięty z listy.';

  @override
  String get ticketControlCaptureHidden => 'Kod jest ukryty podczas nagrywania lub udostępniania ekranu.';

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

  @override
  String get debugTitle => 'Menu debugowania';

  @override
  String get debugIdentityHelp =>
      'Wysyłane z każdym żądaniem. Zapisanie od razu łączy aplikację ponownie. Sesja zostaje, ale serwer może ją odrzucić przy innym identyfikatorze urządzenia.';

  @override
  String get debugDeviceId => 'Identyfikator urządzenia';

  @override
  String debugDeviceIdInvalid(int length) {
    return 'Wymagane znaki: $length';
  }

  @override
  String get debugGenerate => 'Wygeneruj';

  @override
  String get debugDeviceName => 'Nazwa urządzenia';

  @override
  String get debugDeviceNameHint => 'Zostaw puste, aby użyć nazwy tego urządzenia';

  @override
  String get debugSave => 'Zapisz';

  @override
  String get debugScreenSecurity => 'Ochrona ekranu';

  @override
  String get debugScreenSecurityHint =>
      'Chroni kod biletu przed zrzutami ekranu i nagraniami. Włącza się ponownie po ponownym uruchomieniu aplikacji.';

  @override
  String get debugAztecKey => 'Klucz kodu biletu';

  @override
  String get debugAztecKeyBundled => 'Wbudowany w aplikację. Dotknij, aby zapytać serwer pośredniczący.';

  @override
  String debugAztecKeyRelay(int version, String fingerprint) {
    return 'Z serwera pośredniczącego: wersja $version, $fingerprint. Dotknij, aby zapytać ponownie.';
  }

  @override
  String get debugAztecKeyFailed => 'Serwer pośredniczący nie zwrócił klucza.';

  @override
  String get cardTitle => 'Karta mKKM';

  @override
  String get cardSubtitle => 'Mobilna Krakowska Karta Miejska';

  @override
  String get cardChipCreating => 'Tworzymy…';

  @override
  String get cardChipActive => 'Aktywna';

  @override
  String get cardChipDetached => 'Odłączona';

  @override
  String get cardSetupTitle => 'Utwórz kartę mKKM';

  @override
  String cardSetupWelcome(String name) {
    return 'Cześć, $name! Bilety mobilne zapisujemy na wirtualnej karcie mKKM. Twoje konto jeszcze jej nie ma.';
  }

  @override
  String get cardSetupWelcomeAnonymous =>
      'Bilety mobilne zapisujemy na wirtualnej karcie mKKM. Twoje konto jeszcze jej nie ma.';

  @override
  String get cardSetupBenefitTicketsTitle => 'Kupuj i przechowuj bilety w aplikacji';

  @override
  String get cardSetupBenefitTicketsBody => 'Bilety i subskrypcja 5+1 wymagają karty.';

  @override
  String get cardSetupBenefitPhoneTitle => 'Ważne na Twoim telefonie';

  @override
  String get cardSetupBenefitPhoneBody => 'Podczas kontroli pokażesz je w aplikacji.';

  @override
  String get cardSetupBenefitTimeTitle => 'Zajmie około minuty';

  @override
  String get cardSetupBenefitTimeBody => 'Adres zamieszkania i zdjęcie. Bezpłatnie.';

  @override
  String get cardSetupCreate => 'Utwórz kartę mKKM';

  @override
  String get cardDetachedTitle => 'Dodaj ponownie kartę mKKM';

  @override
  String get cardDetachedHint =>
      'Została odłączona od konta na stronie. Dodaj ją ponownie, aby dalej korzystać z aplikacji i biletów.';

  @override
  String get cardReattach => 'Dodaj kartę mKKM';

  @override
  String get cardReattaching => 'Dodajemy…';

  @override
  String cardSetupStep(int step, int total) {
    return 'Krok $step z $total';
  }

  @override
  String get cardSetupStepAddress => 'Adres zamieszkania';

  @override
  String get cardSetupStepPhoto => 'Zdjęcie';

  @override
  String get cardSetupAddressTitle => 'Gdzie mieszkasz?';

  @override
  String get cardSetupAddressHint => 'Potrzebny do karty. Później zmienisz go w Edytuj konto.';

  @override
  String get cardSetupContinue => 'Dalej';

  @override
  String get addressStreet => 'Ulica';

  @override
  String get addressBuilding => 'Numer budynku';

  @override
  String get addressFlat => 'Numer lokalu';

  @override
  String get addressPostcode => 'Kod pocztowy';

  @override
  String get addressTown => 'Miejscowość';

  @override
  String get addressPostcodeInvalid => 'Podaj w formacie 00-000';

  @override
  String get fieldOptional => 'Opcjonalnie';

  @override
  String get cardSetupPhotoTitle => 'Dodaj zdjęcie';

  @override
  String get cardSetupPhotoHint => 'Służy do potwierdzenia, że karta należy do Ciebie.';

  @override
  String get cardPhotoFormats => 'JPG, PNG lub WebP, do 5 MB';

  @override
  String get cardPhotoNew => 'Nowe zdjęcie';

  @override
  String get cardPhotoAdd => 'Dodaj zdjęcie';

  @override
  String get cardPhotoChange => 'Zmień zdjęcie';

  @override
  String get cardPhotoRuleIdTitle => 'Jak do dowodu';

  @override
  String get cardPhotoRuleIdBody => 'Patrz w obiektyw. Twarz zajmuje około dwóch trzecich zdjęcia.';

  @override
  String get cardPhotoRuleLightTitle => 'Równe światło, jasne tło';

  @override
  String get cardPhotoRuleLightBody => 'Bez mocnych cieni na twarzy.';

  @override
  String get cardPhotoRuleFaceTitle => 'Bez nakrycia głowy i okularów przeciwsłonecznych';

  @override
  String get cardPhotoRuleFaceBody => 'Nic nie zasłania głowy ani oczu.';

  @override
  String get cardPhotoTake => 'Zrób zdjęcie';

  @override
  String get cardPhotoChoose => 'Wybierz z galerii';

  @override
  String get cardPhotoTooLarge => 'Zdjęcie jest większe niż 5 MB. Wybierz mniejsze.';

  @override
  String get cardPhotoWrongType => 'Wybierz zdjęcie w formacie JPG, PNG lub WebP.';

  @override
  String get cardPhotoUnavailable => 'Nie udało się otworzyć zdjęcia. Spróbuj ponownie.';

  @override
  String get cardSetupSubmit => 'Utwórz kartę';

  @override
  String get cardReadyTitle => 'Karta mKKM jest gotowa';

  @override
  String get cardReadyHint => 'Kupione bilety zapiszemy na tej karcie.';

  @override
  String get goHome => 'Przejdź do Start';

  @override
  String get offlineBannerTitle => 'Brak połączenia.';

  @override
  String get offlineBanner => 'Wyświetlamy zapisane dane.';

  @override
  String offlineSavedToday(String time) {
    return 'Zapisano o $time';
  }

  @override
  String offlineSavedOn(String date, String time) {
    return 'Zapisano $date o $time';
  }

  @override
  String get serviceUnavailableBanner => 'Usługa eKP jest teraz niedostępna. Wyświetlamy zapisane dane.';

  @override
  String get ticketsLoading => 'Wczytywanie biletów';

  @override
  String get ticketAssignTitle => 'Powiązać bilet z tym telefonem?';

  @override
  String get ticketAssignBody =>
      'Bilet można powiązać z najwyżej dwoma telefonami, a ten będzie jednym z nich. Tylko powiązany telefon pokaże bilet do kontroli.';

  @override
  String get ticketAssignAction => 'Powiąż';

  @override
  String get ticketAssigning => 'Wiążemy…';

  @override
  String get ticketAssigned => 'Bilet powiązany z tym telefonem.';

  @override
  String get ticketPaymentChecking => 'Sprawdzamy…';

  @override
  String get ticketDetailsFailed => 'Nie udało się wczytać szczegółów biletu.';

  @override
  String get ticketDetailsSaved => 'Powyżej widzisz kopię biletu zapisaną na tym telefonie.';

  @override
  String get ticketDetailsOffline => 'Szczegóły wczytają się po połączeniu.';

  @override
  String get ticketControlTicket => 'Bilet';

  @override
  String get ticketControlTapHint => 'Dotknij kodu, aby go powiększyć';

  @override
  String get ticketControlTapClose => 'Dotknij, aby zamknąć';

  @override
  String ticketControlCodeLabel(String time) {
    return 'Kod biletu, ważny jeszcze $time. Dotknij dwukrotnie, aby powiększyć.';
  }

  @override
  String cityCardCodeLabel(String time) {
    return 'Kod statusu, ważny jeszcze $time. Dotknij dwukrotnie, aby powiększyć.';
  }

  @override
  String get cityCardFrom => 'Aktywna od';

  @override
  String get cityCardUntil => 'Aktywna do';

  @override
  String get cityCardShow => 'Pokaż kod statusu';

  @override
  String get cityCardNone => 'Nie posiadasz statusu Karty Krakowskiej zapisanego na karcie mKKM.';

  @override
  String get cityCardHowTo => 'Jak wyrobić Kartę Krakowską';

  @override
  String get cityCardOfflineCode => 'Kod statusu wymaga połączenia.';

  @override
  String get lineChangeYour => 'Twoja linia';

  @override
  String get lineChangeYourHint => 'Dotknij jej, a potem wybierz nową linię w jej miejsce.';

  @override
  String get lineChangeWhich => 'Którą linię chcesz zmienić?';

  @override
  String get lineChangeWhichHint => 'Dotknij linii, a potem wybierz nową w jej miejsce.';

  @override
  String get lineTram => 'Tramwaj';

  @override
  String get lineBus => 'Autobus';

  @override
  String lineReplacing(String line) {
    return 'Zamiast linii $line';
  }

  @override
  String lineReplaces(String type, String line) {
    return '$type · zamiast $line';
  }

  @override
  String get lineOnTicket => 'Na Twoim bilecie';

  @override
  String lineChangeSummaryOne(String line) {
    return 'Po zapisaniu bilet będzie ważny na linii $line.';
  }

  @override
  String lineChangeSummaryMany(String lines, String last) {
    return 'Po zapisaniu bilet będzie ważny na liniach $lines i $last.';
  }

  @override
  String get lineSave => 'Zapisz';

  @override
  String get lineChangeDone => 'Pomyślnie zmieniono linię.';

  @override
  String get lineSearchHint => 'Numer linii';

  @override
  String get lineSearchClear => 'Wyczyść';

  @override
  String lineSearchNone(String query) {
    return 'Brak linii zaczynających się od $query.';
  }

  @override
  String get lineSearchFailed => 'Nie udało się wczytać linii.';

  @override
  String get editPhotoPending => 'Nowe zdjęcie, jeszcze niezapisane';

  @override
  String get editPhotoSave => 'Zapisz zdjęcie';

  @override
  String get editPhotoSaved => 'Zdjęcie zostało zmienione.';

  @override
  String get photoSheetTitle => 'Zdjęcie profilowe';

  @override
  String get photoSheetRules =>
      'Służy do potwierdzenia, że to Ty. Użyj zdjęcia jak do dowodu: równe światło, jasne tło, bez nakrycia głowy i okularów przeciwsłonecznych.';

  @override
  String get editPersonal => 'Dane osobowe';

  @override
  String get editPhone => 'Numer telefonu';

  @override
  String get editPesel => 'PESEL';

  @override
  String get editLockedNote => 'Tych danych nie można zmienić w aplikacji.';

  @override
  String get editAddress => 'Adres zamieszkania';

  @override
  String get editAddressHint => 'Wymagany dla karty mKKM.';

  @override
  String get editSave => 'Zapisz zmiany';

  @override
  String get editSaving => 'Zapisujemy…';

  @override
  String get editSaved => 'Dane zostały zaktualizowane.';

  @override
  String get editDiscardTitle => 'Odrzucić zmiany?';

  @override
  String get editDiscardBody => 'Zmiany imienia, telefonu lub adresu nie zostały zapisane.';

  @override
  String get editKeep => 'Edytuj dalej';

  @override
  String get editDiscard => 'Odrzuć';

  @override
  String get offlineSaveKept => 'Zmiany zostają; połącz się, aby je zapisać.';

  @override
  String get passwordCurrent => 'Obecne hasło';

  @override
  String get passwordRepeatNew => 'Powtórz nowe hasło';

  @override
  String get passwordChanged => 'Hasło zostało zmienione.';

  @override
  String get passwordStaySignedIn => 'Pozostaniesz zalogowany na tym urządzeniu.';

  @override
  String get deleteTitle => 'Usunąć konto?';

  @override
  String get deleteChecking => 'Sprawdzamy karty…';

  @override
  String get deleteAccountGoesTitle => 'Konto eKP też zostanie usunięte';

  @override
  String get deleteAccountGoesBody =>
      'mobileKKM korzysta z konta eKP, więc zniknie ono również ze strony ekp.mpk.krakow.pl.';

  @override
  String get deleteTicketsLostTitle => 'Stracisz bilety i faktury';

  @override
  String get deleteTicketsLostBody => 'Nie będziesz mieć dostępu do biletów i faktur z tego konta.';

  @override
  String get deletePlasticTitle => 'Karta plastikowa wymaga konta eKP';

  @override
  String get deletePlasticBody => 'Bilet przez internet na nośnik plastikowy kupisz tylko z kontem eKP.';

  @override
  String get deleteCardsTitle => 'Najpierw odłącz karty';

  @override
  String get deleteCardsBody =>
      'Do konta wciąż są podłączone karty. Zaloguj się na ekp.mpk.krakow.pl, odłącz je i spróbuj ponownie.';

  @override
  String get deleteCardsAction => 'Otwórz stronę eKP';

  @override
  String get deletePasswordTitle => 'Podaj hasło';

  @override
  String get deletePasswordBody => 'Konto zostanie usunięte od razu.';

  @override
  String get deleteAction => 'Usuń';

  @override
  String get deleteDoneTitle => 'Konto usunięte';

  @override
  String get buyTitle => 'Kup bilet';

  @override
  String get extendTitle => 'Przedłuż bilet';

  @override
  String get buyType => 'Typ biletu';

  @override
  String get buyFare => 'Rodzaj biletu';

  @override
  String get buyZone => 'Strefa';

  @override
  String get buyZoneSub => 'Zaznacz wszystkie potrzebne strefy';

  @override
  String buyZonesNotTogether(String zones, String missing) {
    return 'Strefy $zones nie są sprzedawane razem. Dodaj Strefę $missing, aby jeździć w obu.';
  }

  @override
  String buyFareZones(String fare, String sets) {
    return 'Bilet $fare jest sprzedawany na Strefy $sets.';
  }

  @override
  String buyDiscountZones(String zones) {
    return 'Zniżka Karty Krakowskiej obejmuje tylko Strefę $zones.';
  }

  @override
  String buyZoneList(String rest, String last) {
    return '$rest i $last';
  }

  @override
  String get buyLines => 'Linie';

  @override
  String get buyAllLines => 'Wszystkie linie';

  @override
  String buyLineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linii',
      few: '$count linie',
      one: '1 linia',
    );
    return '$_temp0';
  }

  @override
  String buyLinesSub(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wybierz $count linii',
      few: 'Wybierz $count linie',
      one: 'Wybierz 1 linię',
    );
    return '$_temp0';
  }

  @override
  String buyLinesChosen(int chosen, int count) {
    return 'Wybrano $chosen z $count';
  }

  @override
  String get buyAddLine => 'Dodaj linię';

  @override
  String get buyAlsoZoneII => '+ Strefa II';

  @override
  String get buyDuration => 'Długość';

  @override
  String buyMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count miesięcy',
      few: '$count miesiące',
      one: '1 miesiąc',
    );
    return '$_temp0';
  }

  @override
  String buyDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count dni', one: '1 dzień');
    return '$_temp0';
  }

  @override
  String get buyStarts => 'Początek ważności';

  @override
  String get buyDate => 'Data';

  @override
  String buyStartsRange(String first, String last) {
    return 'Dowolny dzień od $first do $last';
  }

  @override
  String buyExtendRange(String first, String last) {
    return 'Od $first, dnia po końcu Twojego biletu, do $last';
  }

  @override
  String get buyNeedType => 'Wybierz typ biletu';

  @override
  String get buyNeedFare => 'Wybierz rodzaj biletu';

  @override
  String get buyNeedZone => 'Wybierz, gdzie jeździsz';

  @override
  String get buyNeedLines => 'Wybierz linie';

  @override
  String buyNeedMoreLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wybierz jeszcze $count linii',
      few: 'Wybierz jeszcze $count linie',
      one: 'Wybierz jeszcze 1 linię',
    );
    return '$_temp0';
  }

  @override
  String get buyNeedDuration => 'Wybierz długość biletu';

  @override
  String get buyCalculating => 'Obliczamy cenę…';

  @override
  String get buyPrice => 'Cena';

  @override
  String get buyContinue => 'Dalej';

  @override
  String get buyPrefilled => 'Wypełniono na podstawie Twojego biletu. Nowy zacznie się dzień po jego końcu.';

  @override
  String get buyOffline => 'Do zakupu biletu potrzebne jest połączenie.';

  @override
  String get buyLoadFailed => 'Nie udało się wczytać biletów w sprzedaży.';

  @override
  String get buyFieldErrors => 'Proszę poprawnie wybrać rodzaj i typ biletu.';

  @override
  String get payTitle => 'Sprawdź i zapłać';

  @override
  String get payTicketTitle => 'Opłać bilet';

  @override
  String payTicketLines(int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Linie $lines', one: 'Linia $lines');
    return '$_temp0';
  }

  @override
  String get payValidFrom => 'Ważny od';

  @override
  String get payValidUntil => 'Ważny do';

  @override
  String get payProduct => 'Produkt';

  @override
  String get payValidOn => 'Obowiązuje';

  @override
  String get payEveryDay => '7 dni w tygodniu';

  @override
  String payDaysAWeek(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dni w tygodniu',
      one: '1 dzień w tygodniu',
    );
    return '$_temp0';
  }

  @override
  String get payMethod => 'Metoda płatności';

  @override
  String get payLastUsed => 'Ostatnio używana';

  @override
  String get payTransfer => 'Przelew bankowy';

  @override
  String get payChooseBank => 'Wybierz swój bank';

  @override
  String get payChange => 'Zmień';

  @override
  String get payBankSheetTitle => 'Wybierz bank';

  @override
  String get payBankSheetSub => 'Przelew online przez tPay';

  @override
  String payButton(String price) {
    return 'Zapłać $price';
  }

  @override
  String get payOpening => 'Otwieramy płatność…';

  @override
  String get payMethodsFailed => 'Nie udało się wczytać metod płatności.';

  @override
  String get payHowAndroid =>
      'Płacisz na bezpiecznej stronie tPay w przeglądarce. Po zakończeniu mobileKKM otworzy się ponownie.';

  @override
  String get payHowIos => 'Płacisz na bezpiecznej stronie tPay w Safari. Po zakończeniu stuknij Gotowe, aby wrócić.';

  @override
  String get payLinkHint =>
      'Aby po płatności wrócić tu automatycznie, zezwól mobileKKM na otwieranie linków ekp.mpk.krakow.pl.';

  @override
  String get paySimilar =>
      'Posiadasz już podobny bilet obowiązujący częściowo w okresie na który chcesz kupić nowy bilet.';

  @override
  String get payRejected => 'Płatność nie doszła do skutku. Wybierz metodę i spróbuj ponownie.';

  @override
  String get payFinishing => 'Kończymy zakup…';

  @override
  String get payFinishingBody => 'To potrwa chwilę.';

  @override
  String get payChecking => 'Sprawdzamy płatność…';

  @override
  String get payNotYet => 'Nie widzimy jeszcze Twojej płatności';

  @override
  String get payNotYetBody =>
      'Jeśli płatność została wykonana, może dotrzeć za kilka minut. Do tego czasu bilet czeka w zakładce Bilety jako oczekujący na płatność.';

  @override
  String get payAgain => 'Zapłać ponownie';

  @override
  String get payCheckAgain => 'Sprawdź ponownie';

  @override
  String get payBackToTickets => 'Wróć do biletów';

  @override
  String get payMade => 'Zapłacono.';

  @override
  String get payReady => 'Bilet jest gotowy.';

  @override
  String get payRepeatTitle => 'Ponowienie płatności';

  @override
  String get payRepeatBody =>
      'System oczekuje na potwierdzenie poprzedniej płatności, czy na pewno chcesz ponowić płatność? Zapłać tylko jeżeli masz pewność, że poprzednia płatność nie została sfinalizowana.';

  @override
  String get payAlreadyPaid => 'Ten bilet jest już opłacony.';

  @override
  String lineChosen(int chosen, int count) {
    return 'Wybrano $chosen z $count';
  }

  @override
  String get lineDone => 'Gotowe';

  @override
  String get lineZoneI => 'Strefa I';

  @override
  String get lineAlsoZoneII => 'także Strefa II';

  @override
  String lineRemove(String line) {
    return 'Usuń linię $line';
  }
}
