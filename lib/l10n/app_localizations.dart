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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

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
  /// **'{count, plural, =1{At least 1 lowercase letter} other{At least {count} lowercase letters}}'**
  String passwordRuleLowercase(int count);

  /// No description provided for @passwordRuleUppercase.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{At least 1 uppercase letter} other{At least {count} uppercase letters}}'**
  String passwordRuleUppercase(int count);

  /// No description provided for @passwordRuleDigits.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{At least 1 digit} other{At least {count} digits}}'**
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

  /// No description provided for @activateTitle.
  ///
  /// In en, this message translates to:
  /// **'Account activation'**
  String get activateTitle;

  /// No description provided for @activateInProgress.
  ///
  /// In en, this message translates to:
  /// **'Activating your account…'**
  String get activateInProgress;

  /// No description provided for @activateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your account is active. You can sign in now.'**
  String get activateSuccess;

  /// No description provided for @activateFailure.
  ///
  /// In en, this message translates to:
  /// **'The account could not be activated. The link may have expired or already been used.'**
  String get activateFailure;

  /// No description provided for @continueToLogin.
  ///
  /// In en, this message translates to:
  /// **'Go to sign in'**
  String get continueToLogin;

  /// No description provided for @homePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'You are signed in. Tickets are coming soon.'**
  String get homePlaceholder;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logout;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

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
