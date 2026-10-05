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
      one: 'At least 1 lowercase letter',
    );
    return '$_temp0';
  }

  @override
  String passwordRuleUppercase(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'At least $count uppercase letters',
      one: 'At least 1 uppercase letter',
    );
    return '$_temp0';
  }

  @override
  String passwordRuleDigits(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'At least $count digits',
      one: 'At least 1 digit',
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
  String get activateTitle => 'Account activation';

  @override
  String get activateInProgress => 'Activating your account…';

  @override
  String get activateSuccess => 'Your account is active. You can sign in now.';

  @override
  String get activateFailure => 'The account could not be activated. The link may have expired or already been used.';

  @override
  String get continueToLogin => 'Go to sign in';

  @override
  String get homePlaceholder => 'You are signed in. Tickets are coming soon.';

  @override
  String get logout => 'Sign out';
}
