// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Password';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get repeatPasswordLabel => 'Repeat password';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get emailInvalid => 'Enter a valid e-mail address';

  @override
  String get passwordTooWeak => 'The password does not meet the requirements';

  @override
  String get passwordsDontMatch => 'The passwords do not match';

  @override
  String passwordRuleMinLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'At least $count characters',
      one: 'At least 1 character',
    );
    return '$_temp0';
  }

  @override
  String passwordRuleLowercase(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'At least $count lowercase letters',
      one: 'A lowercase letter',
    );
    return '$_temp0';
  }

  @override
  String passwordRuleUppercase(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'At least $count uppercase letters',
      one: 'An uppercase letter',
    );
    return '$_temp0';
  }

  @override
  String passwordRuleDigits(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'At least $count digits',
      one: 'A digit',
    );
    return '$_temp0';
  }

  @override
  String get errorNetwork => 'Could not reach the server. Check your internet connection and try again.';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorInvalidCredentials => 'Wrong e-mail or password.';

  @override
  String get retry => 'Try again';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle => 'Use your EKP passenger account';

  @override
  String get loginSubmit => 'Sign in';

  @override
  String get forgotPasswordLink => 'Forgot password?';

  @override
  String get noAccountPrompt => 'Don\'t have an account?';

  @override
  String get registerLink => 'Create account';

  @override
  String get sessionExpiredNotice => 'Your session has expired. Please sign in again.';

  @override
  String get passwordResetDoneNotice => 'Your password has been changed. You can sign in now.';

  @override
  String get registerTitle => 'Create account';

  @override
  String get sectionPersonal => 'Personal details';

  @override
  String get sectionContact => 'Contact details';

  @override
  String get sectionPassword => 'Password';

  @override
  String get repeatEmailLabel => 'Repeat e-mail';

  @override
  String get emailsDontMatch => 'The e-mail addresses do not match';

  @override
  String get consentRequired => 'Consent is required';

  @override
  String get regulationsLink => 'Regulations';

  @override
  String get dataNoticeTitle => 'Information on data processing';

  @override
  String get showMore => 'Show more';

  @override
  String get showLess => 'Show less';

  @override
  String get firstNameLabel => 'First name';

  @override
  String get lastNameLabel => 'Last name';

  @override
  String get peselLabel => 'PESEL number';

  @override
  String get peselInvalid => 'Enter a valid PESEL number';

  @override
  String get noPeselCheckbox => 'I don\'t have a PESEL number';

  @override
  String get birthDateLabel => 'Date of birth';

  @override
  String get birthDateFromPeselHelper => 'Filled in from your PESEL number';

  @override
  String get birthDateRequired => 'Select your date of birth';

  @override
  String get consentsLoadError => 'The consents could not be loaded.';

  @override
  String get registerSubmit => 'Create account';

  @override
  String get alreadyHaveAccountPrompt => 'Already have an account?';

  @override
  String get signInLink => 'Sign in';

  @override
  String get forgotTitle => 'Reset password';

  @override
  String get forgotBody =>
      'Enter the e-mail address of your account and we will send you a link to set a new password.';

  @override
  String get forgotSubmit => 'Send link';

  @override
  String get inboxTitle => 'Check your inbox';

  @override
  String inboxRegistrationBody(String email) {
    return 'We sent an activation link to $email. Open it to activate your account, then sign in.';
  }

  @override
  String inboxResetBody(String email) {
    return 'If an account exists for $email, we sent a link to set a new password.';
  }

  @override
  String get inboxBrowserHint => 'The link opens in your browser. Finish there, then come back and sign in.';

  @override
  String get inboxAppHint => 'Open the link on this device to continue in the app.';

  @override
  String get inboxEnableLinksHint =>
      'To continue in the app, allow mobileKKM to open ekp.mpk.krakow.pl links. Otherwise the link opens in your browser.';

  @override
  String get openLinkSettings => 'Open link settings';

  @override
  String get backToLogin => 'Back to sign in';

  @override
  String get resetTitle => 'Set new password';

  @override
  String get resetSubmit => 'Change password';

  @override
  String get activateInProgress => 'Activating your account…';

  @override
  String get activateSuccessTitle => 'Your account is active';

  @override
  String get activateSuccessBody => 'You can sign in now.';

  @override
  String get activateFailureTitle => 'The account couldn’t be activated';

  @override
  String get activateFailureBody => 'The link may have expired or already been used.';

  @override
  String get continueToLogin => 'Go to sign in';

  @override
  String get updateRequiredTitle => 'Update required';

  @override
  String get updateRequiredBody =>
      'This version of mobileKKM is no longer supported by the EKP service. Install the latest version to keep using the app.';

  @override
  String get updateRequiredAction => 'Get the latest version';

  @override
  String get navHome => 'Home';

  @override
  String get navTickets => 'Tickets';

  @override
  String get navMap => 'Map';

  @override
  String get navBuy => 'Buy ticket';

  @override
  String get navAccount => 'Account';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get comingSoonBody => 'This part of the app is not ready yet.';

  @override
  String get offlineNotice => 'You\'re offline. Showing saved data.';

  @override
  String get serviceUnavailableNotice => 'The service is currently unavailable.';

  @override
  String get linkOpenFailed => 'Could not open this link.';

  @override
  String homeGreeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get homeGreetingAnonymous => 'Hello!';

  @override
  String get homeNoTicketTitle => 'No active ticket';

  @override
  String get homeNoTicketBody => 'Your current ticket will show up here.';

  @override
  String get quickActionDepartures => 'Departures';

  @override
  String get mapSearchHint => 'Search for a stop';

  @override
  String get mapMyLocation => 'My location';

  @override
  String get mapCredits => 'Map data';

  @override
  String get mapFilters => 'Filters';

  @override
  String get mapLocationDenied => 'Allow access to your location to see where you are.';

  @override
  String get mapLocationServiceOff => 'Location is turned off on this device.';

  @override
  String get mapLocationSettings => 'Settings';

  @override
  String get cityCardTitle => 'Karta Krakowska';

  @override
  String get subscriptionTitle => '5+1 half-year ticket';

  @override
  String get subscriptionCtaBody => 'See the offer and sign up';

  @override
  String get ticketsActive => 'Active';

  @override
  String get ticketsHistory => 'History';

  @override
  String get ticketsEmptyActive => 'You have no tickets yet.';

  @override
  String get ticketsEmptyHistory => 'No tickets in your history.';

  @override
  String get ticketsLoadError => 'Your tickets could not be loaded.';

  @override
  String get ticketTitleMetropolitan => 'Metropolitan ticket';

  @override
  String get ticketTitleNetwork => 'Network ticket';

  @override
  String ticketTitleLines(int count, String lines) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'Lines $lines', one: 'Line $lines');
    return '$_temp0';
  }

  @override
  String get ticketTitleGeneric => 'Ticket';

  @override
  String get ticketStatusPending => 'Awaiting payment';

  @override
  String get ticketStatusReturned => 'Returned';

  @override
  String ticketStatusValidFrom(String date) {
    return 'Valid from $date';
  }

  @override
  String get ticketStatusUpcoming => 'Not valid yet';

  @override
  String get ticketStatusValid => 'Valid';

  @override
  String get ticketStatusExpired => 'Expired';

  @override
  String get ticketPin => 'Pin to Home';

  @override
  String get ticketUnpin => 'Unpin';

  @override
  String get ticketPinned => 'Pinned';

  @override
  String get ticketStatusProcessing => 'Processing payment';

  @override
  String get ticketStatusAssignedElsewhere => 'Assigned to other devices';

  @override
  String get ticketActionControl => 'Ticket control';

  @override
  String get ticketActionAssign => 'Assign to device';

  @override
  String get ticketActionContinuePayment => 'Continue payment';

  @override
  String get ticketActionCheckPayment => 'Check payment';

  @override
  String get ticketActionReturn => 'Return ticket';

  @override
  String get ticketActionBuySimilar => 'Buy similar';

  @override
  String get ticketActionExtend => 'Extend ticket';

  @override
  String get ticketAssignDone => 'Ticket assigned to this device.';

  @override
  String get ticketAssignError => 'The ticket could not be assigned. Try again.';

  @override
  String get ticketPaymentConfirmed => 'Payment confirmed.';

  @override
  String get ticketPaymentPending => 'No payment has been booked yet.';

  @override
  String get ticketCantAssign =>
      'This ticket is already assigned to two browsers or devices and cannot be assigned to this one. Use one of those, or call the MPK S.A. helpline: 12 19 150.';

  @override
  String get ticketDetailsTitle => 'Ticket details';

  @override
  String get ticketDetailsLoadError => 'The ticket could not be loaded.';

  @override
  String get ticketSectionPurchase => 'Purchase';

  @override
  String get ticketSectionReturn => 'Return';

  @override
  String get ticketFieldPurchased => 'Purchased';

  @override
  String get ticketFieldPaid => 'Paid';

  @override
  String get ticketFieldPaymentType => 'Payment type';

  @override
  String get ticketFieldPaymentState => 'Payment state';

  @override
  String get ticketFieldTransactionState => 'Transaction state';

  @override
  String get ticketFieldPromotion => 'Promotion';

  @override
  String get ticketFieldPrice => 'Price';

  @override
  String get ticketFieldReturnOrdered => 'Return ordered';

  @override
  String get ticketFieldReturnedDays => 'Days returned';

  @override
  String get ticketFieldRefundAmount => 'Refund amount';

  @override
  String get ticketFieldRefundMethod => 'Refund method';

  @override
  String get ticketHistoryTitle => 'History';

  @override
  String get ticketHistoryTransaction => 'Transaction';

  @override
  String get ticketHistoryPayment => 'Payment';

  @override
  String get ticketHistoryRefund => 'Refund';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ticketReturnTitle => 'Return ticket';

  @override
  String get ticketReturnNotice =>
      'The ticket stays valid until the end of the day before the date you choose, and if it has already started, at least until the end of today.';

  @override
  String get ticketReturnFrom => 'Return from';

  @override
  String get ticketReturnChooseDate => 'Choose a date';

  @override
  String get ticketReturnPickerTitle => 'Select return date';

  @override
  String ticketReturnKeep(String date) {
    return 'Still valid until $date';
  }

  @override
  String ticketReturnDaysBack(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days returned',
      one: '1 day returned',
    );
    return '$_temp0';
  }

  @override
  String get ticketReturnYouGet => 'You get back';

  @override
  String get ticketReturnCalculating => 'Working out your refund…';

  @override
  String get ticketReturnConfirmTitle => 'Return this ticket?';

  @override
  String ticketReturnConfirmBody(String amount, String date) {
    return '$amount will be refunded. The ticket stays valid until $date.';
  }

  @override
  String ticketReturnConfirmBodyPlain(String amount) {
    return '$amount will be refunded. This cannot be undone.';
  }

  @override
  String get ticketReturnDone => 'The ticket was returned.';

  @override
  String get ticketReturnError => 'The ticket could not be returned.';

  @override
  String get ticketControlCustomerCode => 'Customer number (mKKM)';

  @override
  String get ticketControlError => 'The ticket code could not be loaded. Try again.';

  @override
  String ticketControlTimeLeft(String time) {
    return 'Code valid for $time';
  }

  @override
  String get accountCustomerCode => 'Customer code';

  @override
  String get accountSectionProfile => 'My account';

  @override
  String get cityCardActive => 'Active';

  @override
  String get cityCardInactive => 'Inactive';

  @override
  String get accountRegulationsHint => 'Terms, purchases, 5+1';

  @override
  String get accountContactMpkHint => 'Tickets, payments, Karta Krakowska';

  @override
  String get accountContactDeveloperHint => 'Bugs and suggestions about the app';

  @override
  String get accountSectionHelp => 'Help';

  @override
  String get accountSectionSecurity => 'Security';

  @override
  String get accountEdit => 'Edit account';

  @override
  String get accountRegulations => 'Regulations';

  @override
  String get regulationsAccount => 'EKP account regulations';

  @override
  String get regulationsPurchase => 'Online ticket sales regulations';

  @override
  String get regulationsSubscription => 'Half-year ticket regulations';

  @override
  String get regulationsLoadError => 'The regulations could not be loaded.';

  @override
  String get accountContactMpk => 'Contact MPK Kraków';

  @override
  String get accountContactDeveloper => 'Contact app developer';

  @override
  String get contactCall => 'Call the helpline';

  @override
  String get contactEmail => 'Send an e-mail';

  @override
  String get contactReportIssue => 'Report an issue on GitHub';

  @override
  String get accountChangePassword => 'Change password';

  @override
  String get accountDelete => 'Delete account';

  @override
  String appVersion(String version, String api) {
    return 'Version $version · eKP API $api';
  }

  @override
  String ticketDaysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'days left', one: 'day left');
    return '$_temp0';
  }

  @override
  String ticketDaysUntilStart(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'days until start', one: 'day until start');
    return '$_temp0';
  }

  @override
  String get ticketToday => 'Today';

  @override
  String ticketEndsAt(String time) {
    return 'ends at $time';
  }

  @override
  String ticketStartsAt(String time) {
    return 'starts at $time';
  }

  @override
  String ticketUntil(String date) {
    return 'until $date';
  }

  @override
  String ticketFrom(String date) {
    return 'from $date';
  }

  @override
  String ticketControlAvailableFrom(String date) {
    return 'Available from $date';
  }

  @override
  String ticketControlFrom(String date) {
    return 'Ticket control from $date';
  }

  @override
  String get ticketPinDone => 'Pinned to Home';

  @override
  String get ticketUnpinDone => 'Unpinned';

  @override
  String homeTicketsAwaitingPayment(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tickets awaiting payment',
      one: '1 ticket awaiting payment',
    );
    return '$_temp0';
  }

  @override
  String homeCustomerCode(String code) {
    return 'Customer code $code';
  }

  @override
  String offlineSavedAt(String time) {
    return 'Saved $time';
  }

  @override
  String get ticketsEmptyBody => 'Tickets you buy show up here.';

  @override
  String get ticketDetailsManage => 'Manage';

  @override
  String get ticketActionChangeLine => 'Change line';

  @override
  String get ticketActionChangeLineHint => 'Pick a different line for this ticket';

  @override
  String ticketActionExtendHint(String date) {
    return 'The same ticket again, from $date';
  }

  @override
  String get ticketActionReturnHint => 'Money back for the days you don’t use';

  @override
  String get ticketActionBuySimilarHint => 'Start a purchase with this ticket filled in';

  @override
  String get ticketControlGettingCode => 'Getting a new code…';

  @override
  String get ticketControlCodeFor => 'Code valid for';

  @override
  String get ticketControlFare => 'Fare';

  @override
  String get ticketControlZone => 'Zone';

  @override
  String get ticketControlValidUntil => 'Valid until';

  @override
  String get ticketControlCaptureHidden => 'The code is hidden while the screen is being recorded.';

  @override
  String get loginSubmitting => 'Signing in…';

  @override
  String get forgotSubmitting => 'Sending…';

  @override
  String get registerSubmitting => 'Creating account…';

  @override
  String get resetBody => 'Choose a new password for your account.';

  @override
  String get under16Title => 'Finish on the website';

  @override
  String get under16Body =>
      'People under 16 can only register on the EKP website. It opens with your details filled in.';

  @override
  String get under16Action => 'Open website';

  @override
  String get logoutConfirmTitle => 'Sign out?';

  @override
  String get logoutConfirmBody => 'Tickets assigned to this device will be available again after you sign back in.';

  @override
  String get logoutConfirmAction => 'Sign out';

  @override
  String get cancel => 'Cancel';

  @override
  String get logout => 'Sign out';
}
