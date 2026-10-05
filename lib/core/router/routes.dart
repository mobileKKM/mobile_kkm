import 'package:mobile_kkm/features/auth/models/email_link.dart';

abstract final class Routes {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const registerSent = '/register/sent';
  static const forgotPassword = '/forgot-password';
  static const forgotPasswordSent = '/forgot-password/sent';

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
}
