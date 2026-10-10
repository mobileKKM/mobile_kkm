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
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('pl')];

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordLabel;

  /// No description provided for @repeatPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeatPasswordLabel;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid e-mail address'**
  String get emailInvalid;

  /// No description provided for @passwordTooWeak.
  ///
  /// In en, this message translates to:
  /// **'The password does not meet the requirements'**
  String get passwordTooWeak;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match'**
  String get passwordsDontMatch;

  /// No description provided for @passwordRuleMinLength.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{At least 1 character} other{At least {count} characters}}'**
  String passwordRuleMinLength(int count);

  /// No description provided for @passwordRuleLowercase.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{A lowercase letter} other{At least {count} lowercase letters}}'**
  String passwordRuleLowercase(int count);

  /// No description provided for @passwordRuleUppercase.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{An uppercase letter} other{At least {count} uppercase letters}}'**
  String passwordRuleUppercase(int count);

  /// No description provided for @passwordRuleDigits.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{A digit} other{At least {count} digits}}'**
  String passwordRuleDigits(int count);

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Check your internet connection and try again.'**
  String get errorNetwork;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Wrong e-mail or password.'**
  String get errorInvalidCredentials;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use your EKP passenger account'**
  String get loginSubtitle;

  /// No description provided for @loginSubmit.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginSubmit;

  /// No description provided for @forgotPasswordLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordLink;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountPrompt;

  /// No description provided for @registerLink.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerLink;

  /// No description provided for @sessionExpiredNotice.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please sign in again.'**
  String get sessionExpiredNotice;

  /// No description provided for @passwordResetDoneNotice.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed. You can sign in now.'**
  String get passwordResetDoneNotice;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerTitle;

  /// No description provided for @sectionPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get sectionPersonal;

  /// No description provided for @sectionContact.
  ///
  /// In en, this message translates to:
  /// **'Contact details'**
  String get sectionContact;

  /// No description provided for @sectionPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get sectionPassword;

  /// No description provided for @repeatEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeat e-mail'**
  String get repeatEmailLabel;

  /// No description provided for @emailsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'The e-mail addresses do not match'**
  String get emailsDontMatch;

  /// No description provided for @consentRequired.
  ///
  /// In en, this message translates to:
  /// **'Consent is required'**
  String get consentRequired;

  /// No description provided for @regulationsLink.
  ///
  /// In en, this message translates to:
  /// **'Regulations'**
  String get regulationsLink;

  /// No description provided for @dataNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Information on data processing'**
  String get dataNoticeTitle;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLess;

  /// No description provided for @firstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstNameLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastNameLabel;

  /// No description provided for @peselLabel.
  ///
  /// In en, this message translates to:
  /// **'PESEL number'**
  String get peselLabel;

  /// No description provided for @peselInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid PESEL number'**
  String get peselInvalid;

  /// No description provided for @noPeselCheckbox.
  ///
  /// In en, this message translates to:
  /// **'I don\'t have a PESEL number'**
  String get noPeselCheckbox;

  /// No description provided for @birthDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get birthDateLabel;

  /// No description provided for @birthDateFromPeselHelper.
  ///
  /// In en, this message translates to:
  /// **'Filled in from your PESEL number'**
  String get birthDateFromPeselHelper;

  /// No description provided for @birthDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Select your date of birth'**
  String get birthDateRequired;

  /// No description provided for @consentsLoadError.
  ///
  /// In en, this message translates to:
  /// **'The consents could not be loaded.'**
  String get consentsLoadError;

  /// No description provided for @registerSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerSubmit;

  /// No description provided for @alreadyHaveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccountPrompt;

  /// No description provided for @signInLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInLink;

  /// No description provided for @forgotTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get forgotTitle;

  /// No description provided for @forgotBody.
  ///
  /// In en, this message translates to:
  /// **'Enter the e-mail address of your account and we will send you a link to set a new password.'**
  String get forgotBody;

  /// No description provided for @forgotSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get forgotSubmit;

  /// No description provided for @inboxTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox'**
  String get inboxTitle;

  /// No description provided for @inboxRegistrationBody.
  ///
  /// In en, this message translates to:
  /// **'We sent an activation link to {email}. Open it to activate your account, then sign in.'**
  String inboxRegistrationBody(String email);

  /// No description provided for @inboxResetBody.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for {email}, we sent a link to set a new password.'**
  String inboxResetBody(String email);

  /// No description provided for @inboxBrowserHint.
  ///
  /// In en, this message translates to:
  /// **'The link opens in your browser. Finish there, then come back and sign in.'**
  String get inboxBrowserHint;

  /// No description provided for @inboxAppHint.
  ///
  /// In en, this message translates to:
  /// **'Open the link on this device to continue in the app.'**
  String get inboxAppHint;

  /// No description provided for @inboxEnableLinksHint.
  ///
  /// In en, this message translates to:
  /// **'To continue in the app, allow mobileKKM to open ekp.mpk.krakow.pl links. Otherwise the link opens in your browser.'**
  String get inboxEnableLinksHint;

  /// No description provided for @openLinkSettings.
  ///
  /// In en, this message translates to:
  /// **'Open link settings'**
  String get openLinkSettings;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToLogin;

  /// No description provided for @resetTitle.
  ///
  /// In en, this message translates to:
  /// **'Set new password'**
  String get resetTitle;

  /// No description provided for @resetSubmit.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get resetSubmit;

  /// No description provided for @activateInProgress.
  ///
  /// In en, this message translates to:
  /// **'Activating your account…'**
  String get activateInProgress;

  /// No description provided for @activateSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Your account is active'**
  String get activateSuccessTitle;

  /// No description provided for @activateSuccessBody.
  ///
  /// In en, this message translates to:
  /// **'You can sign in now.'**
  String get activateSuccessBody;

  /// No description provided for @activateFailureTitle.
  ///
  /// In en, this message translates to:
  /// **'The account couldn’t be activated'**
  String get activateFailureTitle;

  /// No description provided for @activateFailureBody.
  ///
  /// In en, this message translates to:
  /// **'The link may have expired or already been used.'**
  String get activateFailureBody;

  /// No description provided for @continueToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to sign in'**
  String get continueToLogin;

  /// No description provided for @updateRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Update required'**
  String get updateRequiredTitle;

  /// No description provided for @updateRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'This version of mobileKKM is no longer supported by the EKP service. Install the latest version to keep using the app.'**
  String get updateRequiredBody;

  /// No description provided for @updateRequiredAction.
  ///
  /// In en, this message translates to:
  /// **'Get the latest version'**
  String get updateRequiredAction;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTickets.
  ///
  /// In en, this message translates to:
  /// **'Tickets'**
  String get navTickets;

  /// No description provided for @navMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navMap;

  /// No description provided for @navBuy.
  ///
  /// In en, this message translates to:
  /// **'Buy ticket'**
  String get navBuy;

  /// No description provided for @navAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get navAccount;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @comingSoonBody.
  ///
  /// In en, this message translates to:
  /// **'This part of the app is not ready yet.'**
  String get comingSoonBody;

  /// No description provided for @offlineNotice.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Showing saved data.'**
  String get offlineNotice;

  /// No description provided for @serviceUnavailableNotice.
  ///
  /// In en, this message translates to:
  /// **'The service is currently unavailable.'**
  String get serviceUnavailableNotice;

  /// No description provided for @linkOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open this link.'**
  String get linkOpenFailed;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String homeGreeting(String name);

  /// No description provided for @homeGreetingAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Hello!'**
  String get homeGreetingAnonymous;

  /// No description provided for @homeNoTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'No active ticket'**
  String get homeNoTicketTitle;

  /// No description provided for @homeNoTicketBody.
  ///
  /// In en, this message translates to:
  /// **'Your current ticket will show up here.'**
  String get homeNoTicketBody;

  /// No description provided for @quickActionDepartures.
  ///
  /// In en, this message translates to:
  /// **'Departures'**
  String get quickActionDepartures;

  /// No description provided for @mapSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a stop'**
  String get mapSearchHint;

  /// No description provided for @mapMyLocation.
  ///
  /// In en, this message translates to:
  /// **'My location'**
  String get mapMyLocation;

  /// No description provided for @mapCredits.
  ///
  /// In en, this message translates to:
  /// **'Map data'**
  String get mapCredits;

  /// No description provided for @mapFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get mapFilters;

  /// No description provided for @mapLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Allow access to your location to see where you are.'**
  String get mapLocationDenied;

  /// No description provided for @mapLocationServiceOff.
  ///
  /// In en, this message translates to:
  /// **'Location is turned off on this device.'**
  String get mapLocationServiceOff;

  /// No description provided for @mapLocationSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get mapLocationSettings;

  /// No description provided for @cityCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Karta Krakowska'**
  String get cityCardTitle;

  /// No description provided for @subscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'5+1 half-year ticket'**
  String get subscriptionTitle;

  /// No description provided for @subscriptionCtaBody.
  ///
  /// In en, this message translates to:
  /// **'See the offer and sign up'**
  String get subscriptionCtaBody;

  /// No description provided for @ticketsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get ticketsActive;

  /// No description provided for @ticketsHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get ticketsHistory;

  /// No description provided for @ticketsEmptyActive.
  ///
  /// In en, this message translates to:
  /// **'You have no tickets yet.'**
  String get ticketsEmptyActive;

  /// No description provided for @ticketsEmptyHistory.
  ///
  /// In en, this message translates to:
  /// **'No tickets in your history.'**
  String get ticketsEmptyHistory;

  /// No description provided for @ticketsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Your tickets could not be loaded.'**
  String get ticketsLoadError;

  /// No description provided for @ticketTitleMetropolitan.
  ///
  /// In en, this message translates to:
  /// **'Metropolitan ticket'**
  String get ticketTitleMetropolitan;

  /// No description provided for @ticketTitleNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network ticket'**
  String get ticketTitleNetwork;

  /// No description provided for @ticketTitleLines.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Line {lines}} other{Lines {lines}}}'**
  String ticketTitleLines(int count, String lines);

  /// No description provided for @ticketTitleGeneric.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get ticketTitleGeneric;

  /// No description provided for @ticketStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Awaiting payment'**
  String get ticketStatusPending;

  /// No description provided for @ticketStatusReturned.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get ticketStatusReturned;

  /// No description provided for @ticketStatusValidFrom.
  ///
  /// In en, this message translates to:
  /// **'Valid from {date}'**
  String ticketStatusValidFrom(String date);

  /// No description provided for @ticketStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Not valid yet'**
  String get ticketStatusUpcoming;

  /// No description provided for @ticketStatusValid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get ticketStatusValid;

  /// No description provided for @ticketStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get ticketStatusExpired;

  /// No description provided for @ticketPin.
  ///
  /// In en, this message translates to:
  /// **'Pin to Home'**
  String get ticketPin;

  /// No description provided for @ticketUnpin.
  ///
  /// In en, this message translates to:
  /// **'Unpin'**
  String get ticketUnpin;

  /// No description provided for @ticketPinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get ticketPinned;

  /// No description provided for @ticketStatusProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing payment'**
  String get ticketStatusProcessing;

  /// No description provided for @ticketStatusAssignedElsewhere.
  ///
  /// In en, this message translates to:
  /// **'Assigned to other devices'**
  String get ticketStatusAssignedElsewhere;

  /// No description provided for @ticketActionControl.
  ///
  /// In en, this message translates to:
  /// **'Ticket control'**
  String get ticketActionControl;

  /// No description provided for @ticketActionAssign.
  ///
  /// In en, this message translates to:
  /// **'Assign to device'**
  String get ticketActionAssign;

  /// No description provided for @ticketActionContinuePayment.
  ///
  /// In en, this message translates to:
  /// **'Continue payment'**
  String get ticketActionContinuePayment;

  /// No description provided for @ticketActionCheckPayment.
  ///
  /// In en, this message translates to:
  /// **'Check payment'**
  String get ticketActionCheckPayment;

  /// No description provided for @ticketActionReturn.
  ///
  /// In en, this message translates to:
  /// **'Return ticket'**
  String get ticketActionReturn;

  /// No description provided for @ticketActionBuySimilar.
  ///
  /// In en, this message translates to:
  /// **'Buy similar'**
  String get ticketActionBuySimilar;

  /// No description provided for @ticketActionExtend.
  ///
  /// In en, this message translates to:
  /// **'Extend ticket'**
  String get ticketActionExtend;

  /// No description provided for @ticketAssignDone.
  ///
  /// In en, this message translates to:
  /// **'Ticket assigned to this device.'**
  String get ticketAssignDone;

  /// No description provided for @ticketAssignError.
  ///
  /// In en, this message translates to:
  /// **'The ticket could not be assigned. Try again.'**
  String get ticketAssignError;

  /// No description provided for @ticketPaymentConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Payment confirmed.'**
  String get ticketPaymentConfirmed;

  /// No description provided for @ticketPaymentPending.
  ///
  /// In en, this message translates to:
  /// **'No payment has been booked yet.'**
  String get ticketPaymentPending;

  /// No description provided for @ticketCantAssign.
  ///
  /// In en, this message translates to:
  /// **'This ticket is already assigned to two browsers or devices and cannot be assigned to this one. Use one of those, or call the MPK S.A. helpline: 12 19 150.'**
  String get ticketCantAssign;

  /// No description provided for @ticketDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Ticket details'**
  String get ticketDetailsTitle;

  /// No description provided for @ticketDetailsLoadError.
  ///
  /// In en, this message translates to:
  /// **'The ticket could not be loaded.'**
  String get ticketDetailsLoadError;

  /// No description provided for @ticketSectionPurchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get ticketSectionPurchase;

  /// No description provided for @ticketSectionReturn.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get ticketSectionReturn;

  /// No description provided for @ticketFieldPurchased.
  ///
  /// In en, this message translates to:
  /// **'Purchased'**
  String get ticketFieldPurchased;

  /// No description provided for @ticketFieldPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get ticketFieldPaid;

  /// No description provided for @ticketFieldPaymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment type'**
  String get ticketFieldPaymentType;

  /// No description provided for @ticketFieldPaymentState.
  ///
  /// In en, this message translates to:
  /// **'Payment state'**
  String get ticketFieldPaymentState;

  /// No description provided for @ticketFieldTransactionState.
  ///
  /// In en, this message translates to:
  /// **'Transaction state'**
  String get ticketFieldTransactionState;

  /// No description provided for @ticketFieldPromotion.
  ///
  /// In en, this message translates to:
  /// **'Promotion'**
  String get ticketFieldPromotion;

  /// No description provided for @ticketFieldPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get ticketFieldPrice;

  /// No description provided for @ticketFieldReturnOrdered.
  ///
  /// In en, this message translates to:
  /// **'Return ordered'**
  String get ticketFieldReturnOrdered;

  /// No description provided for @ticketFieldReturnedDays.
  ///
  /// In en, this message translates to:
  /// **'Days returned'**
  String get ticketFieldReturnedDays;

  /// No description provided for @ticketFieldRefundAmount.
  ///
  /// In en, this message translates to:
  /// **'Refund amount'**
  String get ticketFieldRefundAmount;

  /// No description provided for @ticketFieldRefundMethod.
  ///
  /// In en, this message translates to:
  /// **'Refund method'**
  String get ticketFieldRefundMethod;

  /// No description provided for @ticketHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get ticketHistoryTitle;

  /// No description provided for @ticketHistoryTransaction.
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get ticketHistoryTransaction;

  /// No description provided for @ticketHistoryPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get ticketHistoryPayment;

  /// No description provided for @ticketHistoryRefund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get ticketHistoryRefund;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ticketReturnTitle.
  ///
  /// In en, this message translates to:
  /// **'Return ticket'**
  String get ticketReturnTitle;

  /// No description provided for @ticketReturnNotice.
  ///
  /// In en, this message translates to:
  /// **'The ticket stays valid until the end of the day before the date you choose, and if it has already started, at least until the end of today.'**
  String get ticketReturnNotice;

  /// No description provided for @ticketReturnFrom.
  ///
  /// In en, this message translates to:
  /// **'Return from'**
  String get ticketReturnFrom;

  /// No description provided for @ticketReturnChooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose a date'**
  String get ticketReturnChooseDate;

  /// No description provided for @ticketReturnPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select return date'**
  String get ticketReturnPickerTitle;

  /// No description provided for @ticketReturnKeep.
  ///
  /// In en, this message translates to:
  /// **'Still valid until {date}'**
  String ticketReturnKeep(String date);

  /// No description provided for @ticketReturnDaysBack.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day returned} other{{count} days returned}}'**
  String ticketReturnDaysBack(int count);

  /// No description provided for @ticketReturnYouGet.
  ///
  /// In en, this message translates to:
  /// **'You get back'**
  String get ticketReturnYouGet;

  /// No description provided for @ticketReturnCalculating.
  ///
  /// In en, this message translates to:
  /// **'Working out your refund…'**
  String get ticketReturnCalculating;

  /// No description provided for @ticketReturnConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Return this ticket?'**
  String get ticketReturnConfirmTitle;

  /// No description provided for @ticketReturnConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'{amount} will be refunded. The ticket stays valid until {date}.'**
  String ticketReturnConfirmBody(String amount, String date);

  /// No description provided for @ticketReturnConfirmBodyPlain.
  ///
  /// In en, this message translates to:
  /// **'{amount} will be refunded. This cannot be undone.'**
  String ticketReturnConfirmBodyPlain(String amount);

  /// No description provided for @ticketReturnDone.
  ///
  /// In en, this message translates to:
  /// **'The ticket was returned.'**
  String get ticketReturnDone;

  /// No description provided for @ticketReturnError.
  ///
  /// In en, this message translates to:
  /// **'The ticket could not be returned.'**
  String get ticketReturnError;

  /// No description provided for @ticketControlCustomerCode.
  ///
  /// In en, this message translates to:
  /// **'Customer number (mKKM)'**
  String get ticketControlCustomerCode;

  /// No description provided for @ticketControlError.
  ///
  /// In en, this message translates to:
  /// **'The code could not be loaded. Check your connection and try again.'**
  String get ticketControlError;

  /// No description provided for @ticketControlTimeLeft.
  ///
  /// In en, this message translates to:
  /// **'Code valid for {time}'**
  String ticketControlTimeLeft(String time);

  /// No description provided for @accountCustomerCode.
  ///
  /// In en, this message translates to:
  /// **'Customer code'**
  String get accountCustomerCode;

  /// No description provided for @accountSectionProfile.
  ///
  /// In en, this message translates to:
  /// **'My account'**
  String get accountSectionProfile;

  /// No description provided for @cityCardActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get cityCardActive;

  /// No description provided for @cityCardInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get cityCardInactive;

  /// No description provided for @accountRegulationsHint.
  ///
  /// In en, this message translates to:
  /// **'Terms, purchases, 5+1'**
  String get accountRegulationsHint;

  /// No description provided for @accountContactMpkHint.
  ///
  /// In en, this message translates to:
  /// **'Tickets, payments, Karta Krakowska'**
  String get accountContactMpkHint;

  /// No description provided for @accountContactDeveloperHint.
  ///
  /// In en, this message translates to:
  /// **'Bugs and suggestions about the app'**
  String get accountContactDeveloperHint;

  /// No description provided for @accountSectionHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get accountSectionHelp;

  /// No description provided for @accountSectionSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get accountSectionSecurity;

  /// No description provided for @accountEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get accountEdit;

  /// No description provided for @accountRegulations.
  ///
  /// In en, this message translates to:
  /// **'Regulations'**
  String get accountRegulations;

  /// No description provided for @regulationsAccount.
  ///
  /// In en, this message translates to:
  /// **'EKP account regulations'**
  String get regulationsAccount;

  /// No description provided for @regulationsPurchase.
  ///
  /// In en, this message translates to:
  /// **'Online ticket sales regulations'**
  String get regulationsPurchase;

  /// No description provided for @regulationsSubscription.
  ///
  /// In en, this message translates to:
  /// **'Half-year ticket regulations'**
  String get regulationsSubscription;

  /// No description provided for @regulationsLoadError.
  ///
  /// In en, this message translates to:
  /// **'The regulations could not be loaded.'**
  String get regulationsLoadError;

  /// No description provided for @accountContactMpk.
  ///
  /// In en, this message translates to:
  /// **'Contact MPK Kraków'**
  String get accountContactMpk;

  /// No description provided for @accountContactDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Contact app developer'**
  String get accountContactDeveloper;

  /// No description provided for @contactCall.
  ///
  /// In en, this message translates to:
  /// **'Call the helpline'**
  String get contactCall;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Send an e-mail'**
  String get contactEmail;

  /// No description provided for @contactReportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report an issue on GitHub'**
  String get contactReportIssue;

  /// No description provided for @accountChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get accountChangePassword;

  /// No description provided for @accountDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get accountDelete;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version} · eKP API {api}'**
  String appVersion(String version, String api);

  /// No description provided for @ticketDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{day left} other{days left}}'**
  String ticketDaysLeft(int count);

  /// No description provided for @ticketDaysUntilStart.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{day until start} other{days until start}}'**
  String ticketDaysUntilStart(int count);

  /// No description provided for @ticketToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get ticketToday;

  /// No description provided for @ticketEndsAt.
  ///
  /// In en, this message translates to:
  /// **'ends at {time}'**
  String ticketEndsAt(String time);

  /// No description provided for @ticketStartsAt.
  ///
  /// In en, this message translates to:
  /// **'starts at {time}'**
  String ticketStartsAt(String time);

  /// No description provided for @ticketUntil.
  ///
  /// In en, this message translates to:
  /// **'until {date}'**
  String ticketUntil(String date);

  /// No description provided for @ticketFrom.
  ///
  /// In en, this message translates to:
  /// **'from {date}'**
  String ticketFrom(String date);

  /// No description provided for @ticketControlAvailableFrom.
  ///
  /// In en, this message translates to:
  /// **'Available from {date}'**
  String ticketControlAvailableFrom(String date);

  /// No description provided for @ticketControlFrom.
  ///
  /// In en, this message translates to:
  /// **'Ticket control from {date}'**
  String ticketControlFrom(String date);

  /// No description provided for @ticketPinDone.
  ///
  /// In en, this message translates to:
  /// **'Pinned to Home'**
  String get ticketPinDone;

  /// No description provided for @ticketUnpinDone.
  ///
  /// In en, this message translates to:
  /// **'Unpinned'**
  String get ticketUnpinDone;

  /// No description provided for @homeTicketsAwaitingPayment.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 ticket awaiting payment} other{{count} tickets awaiting payment}}'**
  String homeTicketsAwaitingPayment(int count);

  /// No description provided for @homeCustomerCode.
  ///
  /// In en, this message translates to:
  /// **'Customer code {code}'**
  String homeCustomerCode(String code);

  /// No description provided for @offlineSavedAt.
  ///
  /// In en, this message translates to:
  /// **'Saved {time}'**
  String offlineSavedAt(String time);

  /// No description provided for @ticketsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Tickets you buy show up here.'**
  String get ticketsEmptyBody;

  /// No description provided for @ticketDetailsManage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get ticketDetailsManage;

  /// No description provided for @ticketActionChangeLine.
  ///
  /// In en, this message translates to:
  /// **'Change line'**
  String get ticketActionChangeLine;

  /// No description provided for @ticketActionChangeLineHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a different line for this ticket'**
  String get ticketActionChangeLineHint;

  /// No description provided for @ticketActionExtendHint.
  ///
  /// In en, this message translates to:
  /// **'The same ticket again, from {date}'**
  String ticketActionExtendHint(String date);

  /// No description provided for @ticketActionReturnHint.
  ///
  /// In en, this message translates to:
  /// **'Money back for the days you don’t use'**
  String get ticketActionReturnHint;

  /// No description provided for @ticketActionBuySimilarHint.
  ///
  /// In en, this message translates to:
  /// **'Start a purchase with this ticket filled in'**
  String get ticketActionBuySimilarHint;

  /// No description provided for @ticketControlGettingCode.
  ///
  /// In en, this message translates to:
  /// **'Getting your code…'**
  String get ticketControlGettingCode;

  /// No description provided for @ticketControlFare.
  ///
  /// In en, this message translates to:
  /// **'Fare'**
  String get ticketControlFare;

  /// No description provided for @ticketControlZone.
  ///
  /// In en, this message translates to:
  /// **'Zones'**
  String get ticketControlZone;

  /// No description provided for @ticketControlValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String ticketControlValidUntil(String date);

  /// No description provided for @ticketControlPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get ticketControlPeriod;

  /// No description provided for @ticketStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get ticketStatusCancelled;

  /// No description provided for @ticketHistoryStateCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get ticketHistoryStateCompleted;

  /// No description provided for @ticketHistoryStateCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get ticketHistoryStateCancelled;

  /// No description provided for @ticketCancelledNote.
  ///
  /// In en, this message translates to:
  /// **'The payment wasn’t finished in time, so this purchase was cancelled.'**
  String get ticketCancelledNote;

  /// No description provided for @ticketActionBuyAgain.
  ///
  /// In en, this message translates to:
  /// **'Buy again'**
  String get ticketActionBuyAgain;

  /// No description provided for @ticketDetailsProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get ticketDetailsProduct;

  /// No description provided for @ticketReturnKeepToday.
  ///
  /// In en, this message translates to:
  /// **'Still valid until today, {time}'**
  String ticketReturnKeepToday(String time);

  /// No description provided for @ticketReturnStarts.
  ///
  /// In en, this message translates to:
  /// **'Starts {date}'**
  String ticketReturnStarts(String date);

  /// No description provided for @ticketReturnWhole.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{The whole ticket is returned, 1 day} other{The whole ticket is returned, all {count} days}}'**
  String ticketReturnWhole(int count);

  /// No description provided for @ticketReturnFullPrice.
  ///
  /// In en, this message translates to:
  /// **'The full price. The ticket won’t start.'**
  String get ticketReturnFullPrice;

  /// No description provided for @ticketReturnConfirmBodyToday.
  ///
  /// In en, this message translates to:
  /// **'{amount} will be refunded. The ticket stays valid until today, {time}.'**
  String ticketReturnConfirmBodyToday(String amount, String time);

  /// No description provided for @ticketReturnConfirmBodyWhole.
  ///
  /// In en, this message translates to:
  /// **'{amount} will be refunded. The ticket won’t start and will be removed from your tickets.'**
  String ticketReturnConfirmBodyWhole(String amount);

  /// No description provided for @ticketReturnDoneWhole.
  ///
  /// In en, this message translates to:
  /// **'Ticket returned and removed from your tickets.'**
  String get ticketReturnDoneWhole;

  /// No description provided for @ticketControlCaptureHidden.
  ///
  /// In en, this message translates to:
  /// **'The code is hidden while the screen is being recorded.'**
  String get ticketControlCaptureHidden;

  /// No description provided for @loginSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Signing in…'**
  String get loginSubmitting;

  /// No description provided for @forgotSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get forgotSubmitting;

  /// No description provided for @registerSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Creating account…'**
  String get registerSubmitting;

  /// No description provided for @resetBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a new password for your account.'**
  String get resetBody;

  /// No description provided for @under16Title.
  ///
  /// In en, this message translates to:
  /// **'Finish on the website'**
  String get under16Title;

  /// No description provided for @under16Body.
  ///
  /// In en, this message translates to:
  /// **'People under 16 can only register on the EKP website. It opens with your details filled in.'**
  String get under16Body;

  /// No description provided for @under16Action.
  ///
  /// In en, this message translates to:
  /// **'Open website'**
  String get under16Action;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Tickets assigned to this device will be available again after you sign back in.'**
  String get logoutConfirmBody;

  /// No description provided for @logoutConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logoutConfirmAction;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logout;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

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
