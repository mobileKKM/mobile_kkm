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
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: 'At least $count digits', one: 'A digit');
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
  String get userDataFailed => 'Your account details couldn’t be loaded, so you were signed out. Please sign in again.';

  @override
  String get splashLoadingAccount => 'Loading your account…';

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
  String get ticketControlError => 'The code could not be loaded. Check your connection and try again.';

  @override
  String get accountCustomerCode => 'Customer number';

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
    return 'Customer number $code';
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
  String get ticketControlGettingCode => 'Getting your code…';

  @override
  String get ticketControlFare => 'Fare';

  @override
  String get ticketControlValidUntil => 'Valid until';

  @override
  String get ticketStatusCancelled => 'Cancelled';

  @override
  String get ticketHistoryStateCompleted => 'Completed';

  @override
  String get ticketHistoryStateCancelled => 'Cancelled';

  @override
  String get ticketCancelledNote => 'The payment wasn’t finished in time, so this purchase was cancelled.';

  @override
  String get ticketActionBuyAgain => 'Buy again';

  @override
  String get ticketDetailsProduct => 'Product';

  @override
  String ticketReturnKeepToday(String time) {
    return 'Still valid until today, $time';
  }

  @override
  String ticketReturnStarts(String date) {
    return 'Starts $date';
  }

  @override
  String ticketReturnWhole(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'The whole ticket is returned, all $count days',
      one: 'The whole ticket is returned, 1 day',
    );
    return '$_temp0';
  }

  @override
  String get ticketReturnFullPrice => 'The full price. The ticket won’t start.';

  @override
  String ticketReturnConfirmBodyToday(String amount, String time) {
    return '$amount will be refunded. The ticket stays valid until today, $time.';
  }

  @override
  String ticketReturnConfirmBodyWhole(String amount) {
    return '$amount will be refunded. The ticket won’t start and will be removed from your tickets.';
  }

  @override
  String get ticketReturnDoneWhole => 'Ticket returned and removed from your tickets.';

  @override
  String get ticketControlCaptureHidden => 'The code is hidden while the screen is recorded or shared.';

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

  @override
  String get debugTitle => 'Debug menu';

  @override
  String get debugIdentityHelp =>
      'Sent with every request. Saving reconnects the app at once. The session is kept, but the server may reject it under another device ID.';

  @override
  String get debugDeviceId => 'Device ID';

  @override
  String debugDeviceIdInvalid(int length) {
    return 'Must be $length characters';
  }

  @override
  String get debugGenerate => 'Generate';

  @override
  String get debugDeviceName => 'Device name';

  @override
  String get debugDeviceNameHint => 'Leave empty for this device\'s own name';

  @override
  String get debugSave => 'Save';

  @override
  String get debugDemoMode => 'Demo mode';

  @override
  String get debugDemoModeHint =>
      'Shows a made-up name, numbers, photo and codes in place of yours, for screenshots and recordings. Off when the app is started again.';

  @override
  String get debugScreenSecurity => 'Screen security';

  @override
  String get debugScreenSecurityHint =>
      'Keeps the ticket code out of screenshots and recordings. Back on when the app is started again.';

  @override
  String get debugAztecKey => 'Ticket code key';

  @override
  String get debugAztecKeyBundled => 'The one built into the app. Tap to ask the relay.';

  @override
  String debugAztecKeyRelay(int version, String fingerprint) {
    return 'From the relay: version $version, $fingerprint. Tap to ask again.';
  }

  @override
  String get debugAztecKeyFailed => 'The relay did not answer with a key.';

  @override
  String get cardTitle => 'mKKM card';

  @override
  String get cardSubtitle => 'Mobile Kraków City Card';

  @override
  String get cardChipCreating => 'Creating…';

  @override
  String get cardChipActive => 'Active';

  @override
  String get cardChipDetached => 'Detached';

  @override
  String get cardSetupTitle => 'Set up your mKKM card';

  @override
  String cardSetupWelcome(String name) {
    return 'Hi $name! Mobile tickets are stored on a virtual card, the mKKM. Your account doesn\'t have one yet.';
  }

  @override
  String get cardSetupWelcomeAnonymous =>
      'Mobile tickets are stored on a virtual card, the mKKM. Your account doesn\'t have one yet.';

  @override
  String get cardSetupBenefitTicketsTitle => 'Buy and keep tickets in the app';

  @override
  String get cardSetupBenefitTicketsBody => 'Tickets and the 5+1 subscription both need the card.';

  @override
  String get cardSetupBenefitPhoneTitle => 'Valid on your phone';

  @override
  String get cardSetupBenefitPhoneBody => 'Show them from the app when an inspector asks.';

  @override
  String get cardSetupBenefitTimeTitle => 'Takes about a minute';

  @override
  String get cardSetupBenefitTimeBody => 'Your home address and a photo. It\'s free.';

  @override
  String get cardSetupCreate => 'Create mKKM card';

  @override
  String get cardDetachedTitle => 'Add your mKKM card again';

  @override
  String get cardDetachedHint =>
      'It was detached from your account on the website. Add it again to keep using the app and your tickets.';

  @override
  String get cardReattach => 'Add mKKM card';

  @override
  String get cardReattaching => 'Adding…';

  @override
  String cardSetupStep(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get cardSetupStepAddress => 'Home address';

  @override
  String get cardSetupStepPhoto => 'Photo';

  @override
  String get cardSetupAddressTitle => 'Where do you live?';

  @override
  String get cardSetupAddressHint => 'Needed for the card. You can change it later in Edit account.';

  @override
  String get cardSetupContinue => 'Continue';

  @override
  String get addressStreet => 'Street';

  @override
  String get addressBuilding => 'Building';

  @override
  String get addressFlat => 'Flat';

  @override
  String get addressPostcode => 'Postcode';

  @override
  String get addressTown => 'Town';

  @override
  String get addressPostcodeInvalid => 'Use the form 00-000';

  @override
  String get fieldOptional => 'Optional';

  @override
  String get cardSetupPhotoTitle => 'Add your photo';

  @override
  String get cardSetupPhotoHint => 'It\'s used to check that the card is yours.';

  @override
  String get cardPhotoFormats => 'JPG, PNG or WebP, up to 5 MB';

  @override
  String get cardPhotoNew => 'New photo';

  @override
  String get cardPhotoAdd => 'Add photo';

  @override
  String get cardPhotoChange => 'Change photo';

  @override
  String get cardPhotoRuleIdTitle => 'Like an ID photo';

  @override
  String get cardPhotoRuleIdBody => 'Face the camera. Your face fills about two thirds of the picture.';

  @override
  String get cardPhotoRuleLightTitle => 'Evenly lit, light background';

  @override
  String get cardPhotoRuleLightBody => 'No strong shadows across your face.';

  @override
  String get cardPhotoRuleFaceTitle => 'No hat or sunglasses';

  @override
  String get cardPhotoRuleFaceBody => 'Nothing covering your head or eyes.';

  @override
  String get cardPhotoTake => 'Take a photo';

  @override
  String get cardPhotoChoose => 'Choose from gallery';

  @override
  String get cardPhotoTooLarge => 'The photo is larger than 5 MB. Choose a smaller one.';

  @override
  String get cardPhotoWrongType => 'Use a JPG, PNG or WebP photo.';

  @override
  String get cardPhotoUnavailable => 'The photo could not be opened. Try again.';

  @override
  String get cardSetupSubmit => 'Create card';

  @override
  String get cardReadyTitle => 'Your mKKM card is ready';

  @override
  String get cardReadyHint => 'Tickets you buy are stored on it.';

  @override
  String get goHome => 'Go to Home';

  @override
  String get offlineBannerTitle => 'You’re offline.';

  @override
  String get offlineBanner => 'Showing saved data.';

  @override
  String offlineSavedToday(String time) {
    return 'Saved at $time';
  }

  @override
  String offlineSavedOn(String date, String time) {
    return 'Saved on $date at $time';
  }

  @override
  String get serviceUnavailableBanner => 'The eKP service is unavailable right now. Showing saved data.';

  @override
  String get ticketsLoading => 'Loading tickets';

  @override
  String get ticketAssignTitle => 'Assign to this phone?';

  @override
  String get ticketAssignBody =>
      'A ticket can be assigned to at most two phones, and this phone will be one of them. Only an assigned phone can show the ticket for control.';

  @override
  String get ticketAssignAction => 'Assign';

  @override
  String get ticketAssigning => 'Assigning…';

  @override
  String get ticketAssigned => 'Assigned to this phone.';

  @override
  String get ticketPaymentChecking => 'Checking…';

  @override
  String get ticketDetailsFailed => 'The ticket details could not be loaded.';

  @override
  String get ticketDetailsSaved => 'The ticket above is the copy saved on this phone.';

  @override
  String get ticketDetailsOffline => 'Details load when you’re back online.';

  @override
  String get ticketControlTicket => 'Ticket';

  @override
  String get ticketControlTapHint => 'Tap the code to enlarge it';

  @override
  String get ticketControlTapClose => 'Tap anywhere to close';

  @override
  String ticketControlCodeLabel(String time) {
    return 'Ticket code, valid for $time. Double tap to enlarge.';
  }

  @override
  String cityCardCodeLabel(String time) {
    return 'Status code, valid for $time. Double tap to enlarge.';
  }

  @override
  String get cityCardFrom => 'Active from';

  @override
  String get cityCardUntil => 'Active until';

  @override
  String get cityCardShow => 'Show status code';

  @override
  String get cityCardNone => 'You don’t have Karta Krakowska status on your mKKM card.';

  @override
  String get cityCardHowTo => 'How to get Karta Krakowska';

  @override
  String get cityCardOfflineCode => 'The status code needs a connection.';

  @override
  String get lineChangeYour => 'Your line';

  @override
  String get lineChangeYourHint => 'Tap it, then pick the line to replace it.';

  @override
  String get lineChangeWhich => 'Which line do you want to change?';

  @override
  String get lineChangeWhichHint => 'Tap a line, then pick the one to replace it.';

  @override
  String get lineTram => 'Tram';

  @override
  String get lineBus => 'Bus';

  @override
  String lineReplacing(String line) {
    return 'Replacing line $line';
  }

  @override
  String lineReplaces(String type, String line) {
    return '$type · replaces $line';
  }

  @override
  String get lineOnTicket => 'On your ticket';

  @override
  String lineChangeSummaryOne(String line) {
    return 'After saving, this ticket is valid on line $line.';
  }

  @override
  String lineChangeSummaryMany(String lines, String last) {
    return 'After saving, this ticket is valid on lines $lines and $last.';
  }

  @override
  String get lineSave => 'Save';

  @override
  String get lineChangeDone => 'Line changed.';

  @override
  String get lineSearchHint => 'Line number';

  @override
  String get lineSearchClear => 'Clear';

  @override
  String lineSearchNone(String query) {
    return 'No line starts with $query.';
  }

  @override
  String get lineSearchFailed => 'The lines could not be loaded.';

  @override
  String get editPhotoPending => 'New photo, not saved yet';

  @override
  String get editPhotoSave => 'Save photo';

  @override
  String get editPhotoSaved => 'Your photo was changed.';

  @override
  String get photoSheetTitle => 'Profile photo';

  @override
  String get photoSheetRules =>
      'It is used to check that it’s you. Use an ID-style photo: evenly lit, light background, no hat or sunglasses.';

  @override
  String get editPersonal => 'Personal details';

  @override
  String get editPhone => 'Phone number';

  @override
  String get editPesel => 'PESEL';

  @override
  String get editLockedNote => 'These can’t be changed in the app.';

  @override
  String get editAddress => 'Home address';

  @override
  String get editAddressHint => 'Needed for your mKKM card.';

  @override
  String get editSave => 'Save changes';

  @override
  String get editSaving => 'Saving…';

  @override
  String get editSaved => 'Your details were updated.';

  @override
  String get editDiscardTitle => 'Discard changes?';

  @override
  String get editDiscardBody => 'Your changes to your name, phone or address haven’t been saved.';

  @override
  String get editKeep => 'Keep editing';

  @override
  String get editDiscard => 'Discard';

  @override
  String get offlineSaveKept => 'Your changes are kept; connect to save them.';

  @override
  String get passwordCurrent => 'Current password';

  @override
  String get passwordRepeatNew => 'Repeat new password';

  @override
  String get passwordChanged => 'Password changed.';

  @override
  String get passwordStaySignedIn => 'You stay signed in on this device.';

  @override
  String get deleteTitle => 'Delete your account?';

  @override
  String get deleteChecking => 'Checking your cards…';

  @override
  String get deleteAccountGoesTitle => 'Your eKP account goes too';

  @override
  String get deleteAccountGoesBody => 'mobileKKM uses your eKP account, so it is also deleted on ekp.mpk.krakow.pl.';

  @override
  String get deleteTicketsLostTitle => 'Tickets and invoices are lost';

  @override
  String get deleteTicketsLostBody => 'You won’t be able to see or use the tickets and invoices on this account.';

  @override
  String get deletePlasticTitle => 'Plastic cards need an eKP account';

  @override
  String get deletePlasticBody => 'Buying tickets online for a plastic card only works with an eKP account.';

  @override
  String get deleteCardsTitle => 'Detach your cards first';

  @override
  String get deleteCardsBody =>
      'Your account still has cards attached. Sign in on ekp.mpk.krakow.pl, detach them, then try again.';

  @override
  String get deleteCardsAction => 'Open eKP website';

  @override
  String get deletePasswordTitle => 'Enter your password';

  @override
  String get deletePasswordBody => 'Your account is deleted straight away.';

  @override
  String get deleteAction => 'Delete';

  @override
  String get deleteDoneTitle => 'Account deleted';
}
