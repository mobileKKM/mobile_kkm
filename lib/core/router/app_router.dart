import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/features/auth/models/email_link.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/auth/screens/activate_screen.dart';
import 'package:mobile_kkm/features/auth/screens/forgot_password_screen.dart';
import 'package:mobile_kkm/features/auth/screens/inbox_screen.dart';
import 'package:mobile_kkm/features/auth/screens/login_screen.dart';
import 'package:mobile_kkm/features/auth/screens/register_screen.dart';
import 'package:mobile_kkm/features/auth/screens/reset_password_screen.dart';
import 'package:mobile_kkm/features/home/screens/home_screen.dart';
import 'package:mobile_kkm/features/splash/screens/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen(authControllerProvider.select((state) => state.status), (_, _) => refresh.value++);

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) => redirectFor(state.uri, ref.read(authControllerProvider).status),
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: Routes.login,
        builder: (context, state) =>
            LoginScreen(passwordResetDone: state.uri.queryParameters['notice'] == 'password-reset'),
      ),
      GoRoute(path: Routes.register, builder: (context, state) => const RegisterScreen()),
      GoRoute(
        path: Routes.registerSent,
        builder: (context, state) =>
            InboxScreen(kind: InboxKind.registration, email: state.uri.queryParameters['email'] ?? ''),
      ),
      GoRoute(path: Routes.forgotPassword, builder: (context, state) => const ForgotPasswordScreen()),
      GoRoute(
        path: Routes.forgotPasswordSent,
        builder: (context, state) =>
            InboxScreen(kind: InboxKind.passwordReset, email: state.uri.queryParameters['email'] ?? ''),
      ),
      GoRoute(
        path: '/activate/:token',
        builder: (context, state) => ActivateScreen(token: state.pathParameters['token']!),
      ),
      GoRoute(
        path: '/reset-password/:token',
        builder: (context, state) => ResetPasswordScreen(token: state.pathParameters['token']!),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Where [uri] should go instead, or null to stay.
@visibleForTesting
String? redirectFor(Uri uri, AuthStatus status) {
  // A link from an EKP e-mail, delivered by the platform's deep linking.
  final link = EmailLink.tryParse(uri);
  if (link != null) return Routes.forEmailLink(link);

  final path = uri.path;
  if (Routes.isEmailLinkTarget(path)) return null;

  return switch (status) {
    AuthStatus.unknown => path == Routes.splash ? null : Routes.splash,
    AuthStatus.authenticated => path == Routes.home ? null : Routes.home,
    AuthStatus.unauthenticated => Routes.isPublic(path) ? null : Routes.login,
  };
}
