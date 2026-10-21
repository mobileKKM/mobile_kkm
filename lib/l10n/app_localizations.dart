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
  /// **'The passwords don’t match.'**
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
  /// **'Don’t have an account?'**
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

  /// No description provided for @userDataFailed.
  ///
  /// In en, this message translates to:
  /// **'Your account details couldn’t be loaded, so you were signed out. Please sign in again.'**
  String get userDataFailed;

  /// No description provided for @splashLoadingAccount.
  ///
  /// In en, this message translates to:
  /// **'Loading your account…'**
  String get splashLoadingAccount;

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
  /// **'I don’t have a PESEL number'**
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
  /// **'Payment processing'**
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

  /// No description provided for @ticketAssignError.
  ///
  /// In en, this message translates to:
  /// **'The ticket could not be assigned. Try again.'**
  String get ticketAssignError;

  /// No description provided for @ticketPaymentConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Payment confirmed. Your ticket is ready.'**
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

  /// No description provided for @accountCustomerCode.
  ///
  /// In en, this message translates to:
  /// **'Customer number'**
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
  /// **'Customer number {code}'**
  String homeCustomerCode(String code);

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

  /// No description provided for @ticketControlValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get ticketControlValidUntil;

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
  /// **'The code is hidden while the screen is recorded or shared.'**
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

  /// No description provided for @debugTitle.
  ///
  /// In en, this message translates to:
  /// **'Debug menu'**
  String get debugTitle;

  /// No description provided for @debugIdentityHelp.
  ///
  /// In en, this message translates to:
  /// **'Sent with every request. Saving reconnects the app at once. The session is kept, but the server may reject it under another device ID.'**
  String get debugIdentityHelp;

  /// No description provided for @debugDeviceId.
  ///
  /// In en, this message translates to:
  /// **'Device ID'**
  String get debugDeviceId;

  /// No description provided for @debugDeviceIdInvalid.
  ///
  /// In en, this message translates to:
  /// **'Must be {length} characters'**
  String debugDeviceIdInvalid(int length);

  /// No description provided for @debugGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get debugGenerate;

  /// No description provided for @debugDeviceName.
  ///
  /// In en, this message translates to:
  /// **'Device name'**
  String get debugDeviceName;

  /// No description provided for @debugDeviceNameHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for this device’s own name'**
  String get debugDeviceNameHint;

  /// No description provided for @debugSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get debugSave;

  /// No description provided for @debugScreenSecurity.
  ///
  /// In en, this message translates to:
  /// **'Screen security'**
  String get debugScreenSecurity;

  /// No description provided for @debugScreenSecurityHint.
  ///
  /// In en, this message translates to:
  /// **'Keeps the ticket code out of screenshots and recordings. Back on when the app is started again.'**
  String get debugScreenSecurityHint;

  /// No description provided for @debugAztecKey.
  ///
  /// In en, this message translates to:
  /// **'Ticket code key'**
  String get debugAztecKey;

  /// No description provided for @debugAztecKeyBundled.
  ///
  /// In en, this message translates to:
  /// **'The one built into the app. Tap to ask the relay.'**
  String get debugAztecKeyBundled;

  /// No description provided for @debugAztecKeyRelay.
  ///
  /// In en, this message translates to:
  /// **'From the relay: version {version}, {fingerprint}. Tap to ask again.'**
  String debugAztecKeyRelay(int version, String fingerprint);

  /// No description provided for @debugAztecKeyFailed.
  ///
  /// In en, this message translates to:
  /// **'The relay did not answer with a key.'**
  String get debugAztecKeyFailed;

  /// No description provided for @cardTitle.
  ///
  /// In en, this message translates to:
  /// **'mKKM card'**
  String get cardTitle;

  /// No description provided for @cardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile Kraków City Card'**
  String get cardSubtitle;

  /// No description provided for @cardChipCreating.
  ///
  /// In en, this message translates to:
  /// **'Creating…'**
  String get cardChipCreating;

  /// No description provided for @cardChipActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get cardChipActive;

  /// No description provided for @cardChipDetached.
  ///
  /// In en, this message translates to:
  /// **'Detached'**
  String get cardChipDetached;

  /// No description provided for @cardSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your mKKM card'**
  String get cardSetupTitle;

  /// No description provided for @cardSetupWelcome.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}! Mobile tickets are stored on a virtual card, the mKKM. Your account doesn’t have one yet.'**
  String cardSetupWelcome(String name);

  /// No description provided for @cardSetupWelcomeAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Mobile tickets are stored on a virtual card, the mKKM. Your account doesn’t have one yet.'**
  String get cardSetupWelcomeAnonymous;

  /// No description provided for @cardSetupBenefitTicketsTitle.
  ///
  /// In en, this message translates to:
  /// **'Buy and keep tickets in the app'**
  String get cardSetupBenefitTicketsTitle;

  /// No description provided for @cardSetupBenefitTicketsBody.
  ///
  /// In en, this message translates to:
  /// **'Tickets and the 5+1 subscription both need the card.'**
  String get cardSetupBenefitTicketsBody;

  /// No description provided for @cardSetupBenefitPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Valid on your phone'**
  String get cardSetupBenefitPhoneTitle;

  /// No description provided for @cardSetupBenefitPhoneBody.
  ///
  /// In en, this message translates to:
  /// **'Show them from the app when an inspector asks.'**
  String get cardSetupBenefitPhoneBody;

  /// No description provided for @cardSetupBenefitTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Takes about a minute'**
  String get cardSetupBenefitTimeTitle;

  /// No description provided for @cardSetupBenefitTimeBody.
  ///
  /// In en, this message translates to:
  /// **'Your home address and a photo. It’s free.'**
  String get cardSetupBenefitTimeBody;

  /// No description provided for @cardSetupCreate.
  ///
  /// In en, this message translates to:
  /// **'Create mKKM card'**
  String get cardSetupCreate;

  /// No description provided for @cardDetachedTitle.
  ///
  /// In en, this message translates to:
  /// **'Add your mKKM card again'**
  String get cardDetachedTitle;

  /// No description provided for @cardDetachedHint.
  ///
  /// In en, this message translates to:
  /// **'It was detached from your account on the website. Add it again to keep using the app and your tickets.'**
  String get cardDetachedHint;

  /// No description provided for @cardReattach.
  ///
  /// In en, this message translates to:
  /// **'Add mKKM card'**
  String get cardReattach;

  /// No description provided for @cardReattaching.
  ///
  /// In en, this message translates to:
  /// **'Adding…'**
  String get cardReattaching;

  /// No description provided for @cardSetupStep.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String cardSetupStep(int step, int total);

  /// No description provided for @cardSetupStepAddress.
  ///
  /// In en, this message translates to:
  /// **'Home address'**
  String get cardSetupStepAddress;

  /// No description provided for @cardSetupStepPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get cardSetupStepPhoto;

  /// No description provided for @cardSetupAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Where do you live?'**
  String get cardSetupAddressTitle;

  /// No description provided for @cardSetupAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Needed for the card. You can change it later in Edit account.'**
  String get cardSetupAddressHint;

  /// No description provided for @cardSetupContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get cardSetupContinue;

  /// No description provided for @addressStreet.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get addressStreet;

  /// No description provided for @addressBuilding.
  ///
  /// In en, this message translates to:
  /// **'Building'**
  String get addressBuilding;

  /// No description provided for @addressFlat.
  ///
  /// In en, this message translates to:
  /// **'Flat'**
  String get addressFlat;

  /// No description provided for @addressPostcode.
  ///
  /// In en, this message translates to:
  /// **'Postcode'**
  String get addressPostcode;

  /// No description provided for @addressTown.
  ///
  /// In en, this message translates to:
  /// **'Town'**
  String get addressTown;

  /// No description provided for @addressPostcodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Use the form 00-000'**
  String get addressPostcodeInvalid;

  /// No description provided for @fieldOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get fieldOptional;

  /// No description provided for @cardSetupPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Add your photo'**
  String get cardSetupPhotoTitle;

  /// No description provided for @cardSetupPhotoHint.
  ///
  /// In en, this message translates to:
  /// **'It’s used to check that the card is yours.'**
  String get cardSetupPhotoHint;

  /// No description provided for @cardPhotoFormats.
  ///
  /// In en, this message translates to:
  /// **'JPG, PNG or WebP, up to 5 MB'**
  String get cardPhotoFormats;

  /// No description provided for @cardPhotoNew.
  ///
  /// In en, this message translates to:
  /// **'New photo'**
  String get cardPhotoNew;

  /// No description provided for @cardPhotoAdd.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get cardPhotoAdd;

  /// No description provided for @cardPhotoChange.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get cardPhotoChange;

  /// No description provided for @cardPhotoRuleIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Like an ID photo'**
  String get cardPhotoRuleIdTitle;

  /// No description provided for @cardPhotoRuleIdBody.
  ///
  /// In en, this message translates to:
  /// **'Face the camera. Your face fills about two thirds of the picture.'**
  String get cardPhotoRuleIdBody;

  /// No description provided for @cardPhotoRuleLightTitle.
  ///
  /// In en, this message translates to:
  /// **'Evenly lit, light background'**
  String get cardPhotoRuleLightTitle;

  /// No description provided for @cardPhotoRuleLightBody.
  ///
  /// In en, this message translates to:
  /// **'No strong shadows across your face.'**
  String get cardPhotoRuleLightBody;

  /// No description provided for @cardPhotoRuleFaceTitle.
  ///
  /// In en, this message translates to:
  /// **'No hat or sunglasses'**
  String get cardPhotoRuleFaceTitle;

  /// No description provided for @cardPhotoRuleFaceBody.
  ///
  /// In en, this message translates to:
  /// **'Nothing covering your head or eyes.'**
  String get cardPhotoRuleFaceBody;

  /// No description provided for @cardPhotoTake.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get cardPhotoTake;

  /// No description provided for @cardPhotoChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get cardPhotoChoose;

  /// No description provided for @cardPhotoTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The photo is larger than 5 MB. Choose a smaller one.'**
  String get cardPhotoTooLarge;

  /// No description provided for @cardPhotoWrongType.
  ///
  /// In en, this message translates to:
  /// **'Use a JPG, PNG or WebP photo.'**
  String get cardPhotoWrongType;

  /// No description provided for @cardPhotoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The photo could not be opened. Try again.'**
  String get cardPhotoUnavailable;

  /// No description provided for @cardSetupSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create card'**
  String get cardSetupSubmit;

  /// No description provided for @cardReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your mKKM card is ready'**
  String get cardReadyTitle;

  /// No description provided for @cardReadyHint.
  ///
  /// In en, this message translates to:
  /// **'Tickets you buy are stored on it.'**
  String get cardReadyHint;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goHome;

  /// No description provided for @offlineBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'You’re offline.'**
  String get offlineBannerTitle;

  /// No description provided for @offlineBanner.
  ///
  /// In en, this message translates to:
  /// **'Showing saved data.'**
  String get offlineBanner;

  /// No description provided for @offlineSavedToday.
  ///
  /// In en, this message translates to:
  /// **'Saved at {time}'**
  String offlineSavedToday(String time);

  /// No description provided for @offlineSavedOn.
  ///
  /// In en, this message translates to:
  /// **'Saved on {date} at {time}'**
  String offlineSavedOn(String date, String time);

  /// No description provided for @serviceUnavailableBanner.
  ///
  /// In en, this message translates to:
  /// **'The eKP service is unavailable right now. Showing saved data.'**
  String get serviceUnavailableBanner;

  /// No description provided for @ticketsLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading tickets'**
  String get ticketsLoading;

  /// No description provided for @ticketAssignTitle.
  ///
  /// In en, this message translates to:
  /// **'Assign to this phone?'**
  String get ticketAssignTitle;

  /// No description provided for @ticketAssignBody.
  ///
  /// In en, this message translates to:
  /// **'A ticket can be assigned to at most two phones, and this phone will be one of them. Only an assigned phone can show the ticket for control.'**
  String get ticketAssignBody;

  /// No description provided for @ticketAssignAction.
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get ticketAssignAction;

  /// No description provided for @ticketAssigning.
  ///
  /// In en, this message translates to:
  /// **'Assigning…'**
  String get ticketAssigning;

  /// No description provided for @ticketAssigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned to this phone.'**
  String get ticketAssigned;

  /// No description provided for @ticketPaymentChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get ticketPaymentChecking;

  /// No description provided for @ticketDetailsFailed.
  ///
  /// In en, this message translates to:
  /// **'The ticket details could not be loaded.'**
  String get ticketDetailsFailed;

  /// No description provided for @ticketDetailsSaved.
  ///
  /// In en, this message translates to:
  /// **'The ticket above is the copy saved on this phone.'**
  String get ticketDetailsSaved;

  /// No description provided for @ticketDetailsOffline.
  ///
  /// In en, this message translates to:
  /// **'Details load when you’re back online.'**
  String get ticketDetailsOffline;

  /// No description provided for @ticketControlTicket.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get ticketControlTicket;

  /// No description provided for @ticketControlTapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the code to enlarge it'**
  String get ticketControlTapHint;

  /// No description provided for @ticketControlTapClose.
  ///
  /// In en, this message translates to:
  /// **'Tap anywhere to close'**
  String get ticketControlTapClose;

  /// No description provided for @ticketControlCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Ticket code, valid for {time}. Double tap to enlarge.'**
  String ticketControlCodeLabel(String time);

  /// No description provided for @cityCardCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Status code, valid for {time}. Double tap to enlarge.'**
  String cityCardCodeLabel(String time);

  /// No description provided for @cityCardFrom.
  ///
  /// In en, this message translates to:
  /// **'Active from'**
  String get cityCardFrom;

  /// No description provided for @cityCardUntil.
  ///
  /// In en, this message translates to:
  /// **'Active until'**
  String get cityCardUntil;

  /// No description provided for @cityCardShow.
  ///
  /// In en, this message translates to:
  /// **'Show status code'**
  String get cityCardShow;

  /// No description provided for @cityCardNone.
  ///
  /// In en, this message translates to:
  /// **'You don’t have Karta Krakowska status on your mKKM card.'**
  String get cityCardNone;

  /// No description provided for @cityCardHowTo.
  ///
  /// In en, this message translates to:
  /// **'How to get Karta Krakowska'**
  String get cityCardHowTo;

  /// No description provided for @cityCardOfflineCode.
  ///
  /// In en, this message translates to:
  /// **'The status code needs a connection.'**
  String get cityCardOfflineCode;

  /// No description provided for @lineChangeYour.
  ///
  /// In en, this message translates to:
  /// **'Your line'**
  String get lineChangeYour;

  /// No description provided for @lineChangeYourHint.
  ///
  /// In en, this message translates to:
  /// **'Tap it, then pick the line to replace it.'**
  String get lineChangeYourHint;

  /// No description provided for @lineChangeWhich.
  ///
  /// In en, this message translates to:
  /// **'Which line do you want to change?'**
  String get lineChangeWhich;

  /// No description provided for @lineChangeWhichHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a line, then pick the one to replace it.'**
  String get lineChangeWhichHint;

  /// No description provided for @lineTram.
  ///
  /// In en, this message translates to:
  /// **'Tram'**
  String get lineTram;

  /// No description provided for @lineBus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get lineBus;

  /// No description provided for @lineReplacing.
  ///
  /// In en, this message translates to:
  /// **'Replacing line {line}'**
  String lineReplacing(String line);

  /// No description provided for @lineReplaces.
  ///
  /// In en, this message translates to:
  /// **'{type} · replaces {line}'**
  String lineReplaces(String type, String line);

  /// No description provided for @lineOnTicket.
  ///
  /// In en, this message translates to:
  /// **'On your ticket'**
  String get lineOnTicket;

  /// No description provided for @lineChangeSummaryOne.
  ///
  /// In en, this message translates to:
  /// **'After saving, this ticket is valid on line {line}.'**
  String lineChangeSummaryOne(String line);

  /// No description provided for @lineChangeSummaryMany.
  ///
  /// In en, this message translates to:
  /// **'After saving, this ticket is valid on lines {lines} and {last}.'**
  String lineChangeSummaryMany(String lines, String last);

  /// No description provided for @lineSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get lineSave;

  /// No description provided for @lineChangeDone.
  ///
  /// In en, this message translates to:
  /// **'Line changed.'**
  String get lineChangeDone;

  /// No description provided for @lineSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Line number'**
  String get lineSearchHint;

  /// No description provided for @lineSearchClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get lineSearchClear;

  /// No description provided for @lineSearchNone.
  ///
  /// In en, this message translates to:
  /// **'No line starts with {query}.'**
  String lineSearchNone(String query);

  /// No description provided for @lineSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'The lines could not be loaded.'**
  String get lineSearchFailed;

  /// No description provided for @editPhotoPending.
  ///
  /// In en, this message translates to:
  /// **'New photo, not saved yet'**
  String get editPhotoPending;

  /// No description provided for @editPhotoSave.
  ///
  /// In en, this message translates to:
  /// **'Save photo'**
  String get editPhotoSave;

  /// No description provided for @editPhotoSaved.
  ///
  /// In en, this message translates to:
  /// **'Your photo was changed.'**
  String get editPhotoSaved;

  /// No description provided for @photoSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get photoSheetTitle;

  /// No description provided for @photoSheetRules.
  ///
  /// In en, this message translates to:
  /// **'It is used to check that it’s you. Use an ID-style photo: evenly lit, light background, no hat or sunglasses.'**
  String get photoSheetRules;

  /// No description provided for @editPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get editPersonal;

  /// No description provided for @editPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get editPhone;

  /// No description provided for @editPesel.
  ///
  /// In en, this message translates to:
  /// **'PESEL'**
  String get editPesel;

  /// No description provided for @editLockedNote.
  ///
  /// In en, this message translates to:
  /// **'These can’t be changed in the app.'**
  String get editLockedNote;

  /// No description provided for @editAddress.
  ///
  /// In en, this message translates to:
  /// **'Home address'**
  String get editAddress;

  /// No description provided for @editAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Needed for your mKKM card.'**
  String get editAddressHint;

  /// No description provided for @editSave.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get editSave;

  /// No description provided for @editSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get editSaving;

  /// No description provided for @editSaved.
  ///
  /// In en, this message translates to:
  /// **'Your details were updated.'**
  String get editSaved;

  /// No description provided for @editDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get editDiscardTitle;

  /// No description provided for @editDiscardBody.
  ///
  /// In en, this message translates to:
  /// **'Your changes to your name, phone or address haven’t been saved.'**
  String get editDiscardBody;

  /// No description provided for @editKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get editKeep;

  /// No description provided for @editDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get editDiscard;

  /// No description provided for @offlineSaveKept.
  ///
  /// In en, this message translates to:
  /// **'Your changes are kept; connect to save them.'**
  String get offlineSaveKept;

  /// No description provided for @passwordCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get passwordCurrent;

  /// No description provided for @passwordRepeatNew.
  ///
  /// In en, this message translates to:
  /// **'Repeat new password'**
  String get passwordRepeatNew;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed.'**
  String get passwordChanged;

  /// No description provided for @passwordStaySignedIn.
  ///
  /// In en, this message translates to:
  /// **'You stay signed in on this device.'**
  String get passwordStaySignedIn;

  /// No description provided for @deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get deleteTitle;

  /// No description provided for @deleteChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking your cards…'**
  String get deleteChecking;

  /// No description provided for @deleteAccountGoesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your eKP account goes too'**
  String get deleteAccountGoesTitle;

  /// No description provided for @deleteAccountGoesBody.
  ///
  /// In en, this message translates to:
  /// **'mobileKKM uses your eKP account, so it is also deleted on ekp.mpk.krakow.pl.'**
  String get deleteAccountGoesBody;

  /// No description provided for @deleteTicketsLostTitle.
  ///
  /// In en, this message translates to:
  /// **'Tickets and invoices are lost'**
  String get deleteTicketsLostTitle;

  /// No description provided for @deleteTicketsLostBody.
  ///
  /// In en, this message translates to:
  /// **'You won’t be able to see or use the tickets and invoices on this account.'**
  String get deleteTicketsLostBody;

  /// No description provided for @deletePlasticTitle.
  ///
  /// In en, this message translates to:
  /// **'Plastic cards need an eKP account'**
  String get deletePlasticTitle;

  /// No description provided for @deletePlasticBody.
  ///
  /// In en, this message translates to:
  /// **'Buying tickets online for a plastic card only works with an eKP account.'**
  String get deletePlasticBody;

  /// No description provided for @deleteCardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Detach your cards first'**
  String get deleteCardsTitle;

  /// No description provided for @deleteCardsBody.
  ///
  /// In en, this message translates to:
  /// **'Your account still has cards attached. Sign in on ekp.mpk.krakow.pl, detach them, then try again.'**
  String get deleteCardsBody;

  /// No description provided for @deleteCardsAction.
  ///
  /// In en, this message translates to:
  /// **'Open eKP website'**
  String get deleteCardsAction;

  /// No description provided for @deletePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get deletePasswordTitle;

  /// No description provided for @deletePasswordBody.
  ///
  /// In en, this message translates to:
  /// **'Your account is deleted straight away.'**
  String get deletePasswordBody;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @deleteDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Account deleted'**
  String get deleteDoneTitle;

  /// No description provided for @buyTitle.
  ///
  /// In en, this message translates to:
  /// **'Buy a ticket'**
  String get buyTitle;

  /// No description provided for @extendTitle.
  ///
  /// In en, this message translates to:
  /// **'Extend ticket'**
  String get extendTitle;

  /// No description provided for @buyType.
  ///
  /// In en, this message translates to:
  /// **'Ticket type'**
  String get buyType;

  /// No description provided for @buyFare.
  ///
  /// In en, this message translates to:
  /// **'Fare'**
  String get buyFare;

  /// No description provided for @buyZone.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get buyZone;

  /// No description provided for @buyZoneSub.
  ///
  /// In en, this message translates to:
  /// **'Choose every zone you need'**
  String get buyZoneSub;

  /// No description provided for @buyZoneName.
  ///
  /// In en, this message translates to:
  /// **'Zone {zone}'**
  String buyZoneName(String zone);

  /// No description provided for @buyTypeDiscount.
  ///
  /// In en, this message translates to:
  /// **'Ticket with the Karta Krakowska discount'**
  String get buyTypeDiscount;

  /// No description provided for @buyTypeDiscountSub.
  ///
  /// In en, this message translates to:
  /// **'All or chosen KMK lines in the chosen zone'**
  String get buyTypeDiscountSub;

  /// No description provided for @buyTypeNoDiscount.
  ///
  /// In en, this message translates to:
  /// **'Ticket without the Karta Krakowska discount'**
  String get buyTypeNoDiscount;

  /// No description provided for @buyTypeNoDiscountSub.
  ///
  /// In en, this message translates to:
  /// **'All KMK lines in the chosen zone, plus regional trains'**
  String get buyTypeNoDiscountSub;

  /// No description provided for @fareStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get fareStandard;

  /// No description provided for @fareReduced.
  ///
  /// In en, this message translates to:
  /// **'Reduced'**
  String get fareReduced;

  /// No description provided for @fareActivation.
  ///
  /// In en, this message translates to:
  /// **'Activation'**
  String get fareActivation;

  /// No description provided for @buyZonesNotTogether.
  ///
  /// In en, this message translates to:
  /// **'Zones {zones} aren’t sold together. Add Zone {missing} to travel in both.'**
  String buyZonesNotTogether(String zones, String missing);

  /// No description provided for @buyFareZones.
  ///
  /// In en, this message translates to:
  /// **'{fare} is sold for zones {sets}.'**
  String buyFareZones(String fare, String sets);

  /// No description provided for @buyDiscountZones.
  ///
  /// In en, this message translates to:
  /// **'The Karta Krakowska discount is for Zone {zones} only.'**
  String buyDiscountZones(String zones);

  /// No description provided for @buyZoneList.
  ///
  /// In en, this message translates to:
  /// **'{rest} and {last}'**
  String buyZoneList(String rest, String last);

  /// No description provided for @buyLines.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get buyLines;

  /// No description provided for @buyAllLines.
  ///
  /// In en, this message translates to:
  /// **'All lines'**
  String get buyAllLines;

  /// No description provided for @buyLineCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 line} other{{count} lines}}'**
  String buyLineCount(int count);

  /// No description provided for @buyLinesSub.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Choose 1 line} other{Choose {count} lines}}'**
  String buyLinesSub(int count);

  /// No description provided for @buyLinesChosen.
  ///
  /// In en, this message translates to:
  /// **'{chosen} of {count} chosen'**
  String buyLinesChosen(int chosen, int count);

  /// No description provided for @buyAddLine.
  ///
  /// In en, this message translates to:
  /// **'Add line'**
  String get buyAddLine;

  /// No description provided for @buyAlsoZoneII.
  ///
  /// In en, this message translates to:
  /// **'+ Zone II'**
  String get buyAlsoZoneII;

  /// No description provided for @buyDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get buyDuration;

  /// No description provided for @buyMonths.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 month} other{{count} months}}'**
  String buyMonths(int count);

  /// No description provided for @buyDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String buyDays(int count);

  /// No description provided for @buyStarts.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get buyStarts;

  /// No description provided for @buyDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get buyDate;

  /// No description provided for @buyStartsRange.
  ///
  /// In en, this message translates to:
  /// **'Any day from {first} to {last}'**
  String buyStartsRange(String first, String last);

  /// No description provided for @buyExtendRange.
  ///
  /// In en, this message translates to:
  /// **'From {first}, the day after your ticket ends, to {last}'**
  String buyExtendRange(String first, String last);

  /// No description provided for @buyNeedType.
  ///
  /// In en, this message translates to:
  /// **'Choose a ticket type'**
  String get buyNeedType;

  /// No description provided for @buyNeedFare.
  ///
  /// In en, this message translates to:
  /// **'Choose a fare'**
  String get buyNeedFare;

  /// No description provided for @buyNeedZone.
  ///
  /// In en, this message translates to:
  /// **'Choose where you travel'**
  String get buyNeedZone;

  /// No description provided for @buyNeedLines.
  ///
  /// In en, this message translates to:
  /// **'Choose the lines'**
  String get buyNeedLines;

  /// No description provided for @buyNeedMoreLines.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Choose 1 more line} other{Choose {count} more lines}}'**
  String buyNeedMoreLines(int count);

  /// No description provided for @buyNeedDuration.
  ///
  /// In en, this message translates to:
  /// **'Choose how long'**
  String get buyNeedDuration;

  /// No description provided for @buyCalculating.
  ///
  /// In en, this message translates to:
  /// **'Calculating…'**
  String get buyCalculating;

  /// No description provided for @buyPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get buyPrice;

  /// No description provided for @buyContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get buyContinue;

  /// No description provided for @buyPrefilled.
  ///
  /// In en, this message translates to:
  /// **'Filled in from your ticket. The new one starts the day after it ends.'**
  String get buyPrefilled;

  /// No description provided for @buyOffline.
  ///
  /// In en, this message translates to:
  /// **'Buying a ticket needs a connection.'**
  String get buyOffline;

  /// No description provided for @buyLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'The ticket options could not be loaded.'**
  String get buyLoadFailed;

  /// No description provided for @buyFieldErrors.
  ///
  /// In en, this message translates to:
  /// **'Please choose the fare and type correctly.'**
  String get buyFieldErrors;

  /// No description provided for @payTitle.
  ///
  /// In en, this message translates to:
  /// **'Check and pay'**
  String get payTitle;

  /// No description provided for @payTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay for ticket'**
  String get payTicketTitle;

  /// No description provided for @payValidFrom.
  ///
  /// In en, this message translates to:
  /// **'Valid from'**
  String get payValidFrom;

  /// No description provided for @payValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get payValidUntil;

  /// No description provided for @payProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get payProduct;

  /// No description provided for @payValidOn.
  ///
  /// In en, this message translates to:
  /// **'Valid on'**
  String get payValidOn;

  /// No description provided for @payEveryDay.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get payEveryDay;

  /// No description provided for @payDaysAWeek.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day a week} other{{count} days a week}}'**
  String payDaysAWeek(int count);

  /// No description provided for @payMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get payMethod;

  /// No description provided for @payLastUsed.
  ///
  /// In en, this message translates to:
  /// **'Last used'**
  String get payLastUsed;

  /// No description provided for @payTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank transfer'**
  String get payTransfer;

  /// No description provided for @payChooseBank.
  ///
  /// In en, this message translates to:
  /// **'Choose your bank'**
  String get payChooseBank;

  /// No description provided for @payChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get payChange;

  /// No description provided for @payBankSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your bank'**
  String get payBankSheetTitle;

  /// No description provided for @payBankSheetSub.
  ///
  /// In en, this message translates to:
  /// **'Online transfer through tPay'**
  String get payBankSheetSub;

  /// No description provided for @payButton.
  ///
  /// In en, this message translates to:
  /// **'Pay {price}'**
  String payButton(String price);

  /// No description provided for @payOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening payment…'**
  String get payOpening;

  /// No description provided for @payMethodsFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment methods could not be loaded.'**
  String get payMethodsFailed;

  /// No description provided for @payHowAndroid.
  ///
  /// In en, this message translates to:
  /// **'You pay on tPay’s secure page in your browser. mobileKKM opens again when you’re done.'**
  String get payHowAndroid;

  /// No description provided for @payHowIos.
  ///
  /// In en, this message translates to:
  /// **'You pay on tPay’s secure page in Safari. Tap Done when you’ve finished to come back.'**
  String get payHowIos;

  /// No description provided for @payLinkHint.
  ///
  /// In en, this message translates to:
  /// **'To come back here by itself after paying, allow mobileKKM to open ekp.mpk.krakow.pl links.'**
  String get payLinkHint;

  /// No description provided for @paySimilar.
  ///
  /// In en, this message translates to:
  /// **'You already have a similar ticket that is valid for part of this period.'**
  String get paySimilar;

  /// No description provided for @payScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payScreenTitle;

  /// No description provided for @payOpeningTpay.
  ///
  /// In en, this message translates to:
  /// **'Opening tPay…'**
  String get payOpeningTpay;

  /// No description provided for @payOpenBodyAndroid.
  ///
  /// In en, this message translates to:
  /// **'When you finish paying, mobileKKM brings you back here by itself.'**
  String get payOpenBodyAndroid;

  /// No description provided for @payOpenBodyAndroidNoLink.
  ///
  /// In en, this message translates to:
  /// **'When you finish paying, close the payment page to come back here.'**
  String get payOpenBodyAndroidNoLink;

  /// No description provided for @payOpenBodyIos.
  ///
  /// In en, this message translates to:
  /// **'When you finish paying, tap Done to come back here.'**
  String get payOpenBodyIos;

  /// No description provided for @payRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'The payment didn’t go through'**
  String get payRejectedTitle;

  /// No description provided for @payRejectedBody.
  ///
  /// In en, this message translates to:
  /// **'Try again, or choose another payment method.'**
  String get payRejectedBody;

  /// No description provided for @payTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get payTryAgain;

  /// No description provided for @payFinishing.
  ///
  /// In en, this message translates to:
  /// **'Finishing your purchase…'**
  String get payFinishing;

  /// No description provided for @payFinishingBody.
  ///
  /// In en, this message translates to:
  /// **'This takes a moment.'**
  String get payFinishingBody;

  /// No description provided for @payChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking your payment…'**
  String get payChecking;

  /// No description provided for @payNotYet.
  ///
  /// In en, this message translates to:
  /// **'We can’t see your payment yet'**
  String get payNotYet;

  /// No description provided for @payNotYetBody.
  ///
  /// In en, this message translates to:
  /// **'If you paid, it can take a few minutes to arrive. Until then, the ticket waits in Tickets as awaiting payment.'**
  String get payNotYetBody;

  /// No description provided for @payAgain.
  ///
  /// In en, this message translates to:
  /// **'Pay again'**
  String get payAgain;

  /// No description provided for @payCheckAgain.
  ///
  /// In en, this message translates to:
  /// **'Check again'**
  String get payCheckAgain;

  /// No description provided for @payBackToTickets.
  ///
  /// In en, this message translates to:
  /// **'Back to tickets'**
  String get payBackToTickets;

  /// No description provided for @payMade.
  ///
  /// In en, this message translates to:
  /// **'Payment made.'**
  String get payMade;

  /// No description provided for @payReady.
  ///
  /// In en, this message translates to:
  /// **'Your ticket is ready.'**
  String get payReady;

  /// No description provided for @payRepeatTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay again?'**
  String get payRepeatTitle;

  /// No description provided for @payRepeatBody.
  ///
  /// In en, this message translates to:
  /// **'We’re still waiting to hear about your last payment for this ticket. Pay again only if you’re sure it didn’t go through.'**
  String get payRepeatBody;

  /// No description provided for @payAlreadyPaid.
  ///
  /// In en, this message translates to:
  /// **'This ticket is already paid.'**
  String get payAlreadyPaid;

  /// No description provided for @lineChosen.
  ///
  /// In en, this message translates to:
  /// **'Chosen {chosen} of {count}'**
  String lineChosen(int chosen, int count);

  /// No description provided for @lineDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get lineDone;

  /// No description provided for @lineZoneI.
  ///
  /// In en, this message translates to:
  /// **'Zone I'**
  String get lineZoneI;

  /// No description provided for @lineAlsoZoneII.
  ///
  /// In en, this message translates to:
  /// **'also Zone II'**
  String get lineAlsoZoneII;

  /// No description provided for @lineRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove line {line}'**
  String lineRemove(String line);

  /// No description provided for @firstStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Before you start'**
  String get firstStartTitle;

  /// No description provided for @firstStartBody.
  ///
  /// In en, this message translates to:
  /// **'mobileKKM is a community-made app for Kraków’s EKP ticket system.'**
  String get firstStartBody;

  /// No description provided for @firstStartUnofficialTitle.
  ///
  /// In en, this message translates to:
  /// **'Unofficial'**
  String get firstStartUnofficialTitle;

  /// No description provided for @firstStartUnofficialBody.
  ///
  /// In en, this message translates to:
  /// **'Not made by or affiliated with ZTP or MPK. The official app is mobilna KKM.'**
  String get firstStartUnofficialBody;

  /// No description provided for @firstStartOpenSourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Open source'**
  String get firstStartOpenSourceTitle;

  /// No description provided for @firstStartOpenSourceBody.
  ///
  /// In en, this message translates to:
  /// **'Licensed under GPL-3.0; anyone can read the code on GitHub. Your login goes only to the EKP service.'**
  String get firstStartOpenSourceBody;

  /// No description provided for @firstStartNoWarrantyTitle.
  ///
  /// In en, this message translates to:
  /// **'No warranty'**
  String get firstStartNoWarrantyTitle;

  /// No description provided for @firstStartNoWarrantyBody.
  ///
  /// In en, this message translates to:
  /// **'Provided as is. The developer isn’t liable for failed purchases, fines or issues with your EKP account.'**
  String get firstStartNoWarrantyBody;

  /// No description provided for @firstStartAccept.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get firstStartAccept;

  /// No description provided for @viewSourceCode.
  ///
  /// In en, this message translates to:
  /// **'View source code'**
  String get viewSourceCode;
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
