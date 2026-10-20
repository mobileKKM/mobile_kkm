import 'package:mobile_kkm/features/auth/models/email_link.dart';

abstract final class Routes {
  static const splash = '/';
  static const home = '/home';
  static const tickets = '/tickets';
  static const map = '/map';
  static const account = '/account';
  static const accountEdit = '/account/edit';
  static const accountChangePassword = '/account/change-password';
  static const accountDelete = '/account/delete';
  static const cityCard = '/karta-krakowska';

  /// The status code, for whoever checks the status.
  static const cityCardCode = '$cityCard/code';

  static const buy = '/buy';

  /// Check and pay for the ticket priced on [buy] (passed as `extra`).
  static const buyPay = '$buy/pay';

  /// The purchase form filled in from a ticket, to extend it or to buy one
  /// like it.
  static String buyExtend(String transactionCode) =>
      Uri(path: buy, queryParameters: {'extend': transactionCode}).toString();
  static String buySimilar(String transactionCode) =>
      Uri(path: buy, queryParameters: {'similar': transactionCode}).toString();

  /// Payment: tPay opens over it, and it shows how the payment went.
  static const payment = '/payment';
  static const subscription = '/subscription';

  /// The mKKM card set-up: all a signed-in user gets until the account has
  /// an attached card. Its two steps lie on top of each other.
  static const cardSetup = '/card-setup';
  static const cardSetupAddress = '$cardSetup/address';
  static const cardSetupPhoto = '$cardSetupAddress/photo';

  /// The hidden debug menu, behind the version line on Account and the logo
  /// on the login screen. Open signed in or out.
  static const debug = '/debug';

  /// Where everything leads once the server has stopped serving this client.
  static const updateRequired = '/update-required';
  static const login = '/login';
  static const register = '/register';
  static const registerSent = '/register/sent';
  static const forgotPassword = '/forgot-password';
  static const forgotPasswordSent = '/forgot-password/sent';

  static const _ticketPrefix = '/ticket/';
  static const _ticketControlPrefix = '/ticket-control/';

  /// One purchase in full. Transaction codes are Base64.
  static String ticket(String transactionCode) => '$_ticketPrefix${Uri.encodeComponent(transactionCode)}';
  static String ticketReturn(String transactionCode) => '${ticket(transactionCode)}/return';
  static String ticketChangeLine(String transactionCode) => '${ticket(transactionCode)}/change-line';

  /// Pay for a ticket that waits for its payment.
  static String ticketPay(String transactionCode) => '${ticket(transactionCode)}/pay';

  /// The ticket's code, for an inspector.
  static String ticketControl(String ticketGuid) => '$_ticketControlPrefix${Uri.encodeComponent(ticketGuid)}';

  static const _activatePrefix = '/activate/';
  static const _resetPasswordPrefix = '/reset-password/';

  static String activate(String token) => '$_activatePrefix${Uri.encodeComponent(token)}';
  static String resetPassword(String token) => '$_resetPasswordPrefix${Uri.encodeComponent(token)}';

  static String loginAfterPasswordReset() => '$login?notice=password-reset';

  static String sent(String route, String email) => Uri(path: route, queryParameters: {'email': email}).toString();

  /// The in-app route for a link from an EKP e-mail.
  static String forEmailLink(EmailLink link) => switch (link.kind) {
    EmailLinkKind.activate => activate(link.token),
    EmailLinkKind.resetPassword => resetPassword(link.token),
  };

  /// Screens reached from an e-mail link — valid in every auth state.
  static bool isEmailLinkTarget(String path) =>
      path.startsWith(_activatePrefix) || path.startsWith(_resetPasswordPrefix);

  /// Screens available without a session.
  static bool isPublic(String path) =>
      path == login || path == register || path == registerSent || path == forgotPassword || path == forgotPasswordSent;

  /// The card set-up and its steps.
  static bool isCardSetup(String path) => path == cardSetup || path.startsWith('$cardSetup/');

  /// Screens of the signed-in area.
  static bool isSignedIn(String path) =>
      const {
        home,
        tickets,
        map,
        account,
        accountEdit,
        accountChangePassword,
        accountDelete,
        cityCard,
        cityCardCode,
        buy,
        buyPay,
        payment,
        subscription,
      }.contains(path) ||
      path.startsWith(_ticketPrefix) ||
      path.startsWith(_ticketControlPrefix);
}
