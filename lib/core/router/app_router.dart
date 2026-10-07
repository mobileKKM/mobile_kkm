import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/coming_soon_screen.dart';
import 'package:mobile_kkm/features/account/screens/account_screen.dart';
import 'package:mobile_kkm/features/auth/models/email_link.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/auth/screens/activate_screen.dart';
import 'package:mobile_kkm/features/auth/screens/forgot_password_screen.dart';
import 'package:mobile_kkm/features/auth/screens/inbox_screen.dart';
import 'package:mobile_kkm/features/auth/screens/login_screen.dart';
import 'package:mobile_kkm/features/auth/screens/register_screen.dart';
import 'package:mobile_kkm/features/auth/screens/reset_password_screen.dart';
import 'package:mobile_kkm/features/home/screens/home_screen.dart';
import 'package:mobile_kkm/features/map/screens/map_screen.dart';
import 'package:mobile_kkm/features/shell/widgets/main_shell.dart';
import 'package:mobile_kkm/features/splash/screens/splash_screen.dart';
import 'package:mobile_kkm/features/tickets/screens/ticket_control_screen.dart';
import 'package:mobile_kkm/features/tickets/screens/ticket_details_screen.dart';
import 'package:mobile_kkm/features/tickets/screens/ticket_return_screen.dart';
import 'package:mobile_kkm/features/tickets/screens/tickets_screen.dart';
import 'package:mobile_kkm/features/update/screens/update_required_screen.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.onDispose(refresh.dispose);
  ref.listen(authControllerProvider.select((state) => state.status), (_, _) => refresh.value++);
  // Also starts the start-up check.
  ref.listen(appStartupProvider, (_, _) => refresh.value++);
  ref.listen(appStatusProvider.select((status) => status.mode == AppMode.outdated), (_, _) => refresh.value++);

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      // The splash stays up until the service check and the app config are
      // through, whatever the session says.
      final started = !ref.read(appStartupProvider).isLoading;
      return redirectFor(
        state.uri,
        started ? ref.read(authControllerProvider).status : AuthStatus.unknown,
        outdated: ref.read(appStatusProvider).mode == AppMode.outdated,
      );
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: Routes.updateRequired, builder: (context, state) => const UpdateRequiredScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: Routes.tickets, builder: (context, state) => const TicketsScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: Routes.map, builder: (context, state) => const MapScreen())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: Routes.account, builder: (context, state) => const AccountScreen())],
          ),
        ],
      ),
      // Full screen, above the navigation bar.
      GoRoute(
        path: '/ticket/:transactionCode',
        builder: (context, state) => TicketDetailsScreen(transactionCode: state.pathParameters['transactionCode']!),
        routes: [
          GoRoute(
            path: 'return',
            builder: (context, state) => TicketReturnScreen(transactionCode: state.pathParameters['transactionCode']!),
          ),
        ],
      ),
      GoRoute(
        path: '/ticket-control/:ticketGuid',
        builder: (context, state) => TicketControlScreen(ticketGuid: state.pathParameters['ticketGuid']!),
      ),
      // Not built yet.
      _comingSoon(Routes.accountEdit, (l10n) => l10n.accountEdit),
      _comingSoon(Routes.accountChangePassword, (l10n) => l10n.accountChangePassword),
      _comingSoon(Routes.accountDelete, (l10n) => l10n.accountDelete),
      _comingSoon(Routes.cityCard, (l10n) => l10n.cityCardTitle),
      _comingSoon(Routes.buy, (l10n) => l10n.navBuy),
      _comingSoon(Routes.subscription, (l10n) => l10n.subscriptionTitle),
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

GoRoute _comingSoon(String path, String Function(AppLocalizations l10n) title) => GoRoute(
  path: path,
  builder: (context, state) => ComingSoonScreen(title: title(AppLocalizations.of(context))),
);

/// Where [uri] should go instead, or null to stay.
///
/// [outdated]: the server no longer serves this client. Then there is one
/// screen, in every auth state and for every link.
@visibleForTesting
String? redirectFor(Uri uri, AuthStatus status, {bool outdated = false}) {
  if (outdated) {
    return uri.path == Routes.updateRequired ? null : Routes.updateRequired;
  }

  // A link from an EKP e-mail, delivered by the platform's deep linking.
  final link = EmailLink.tryParse(uri);
  if (link != null) {
    return Routes.forEmailLink(link);
  }

  final path = uri.path;
  if (Routes.isEmailLinkTarget(path)) {
    return null;
  }

  return switch (status) {
    AuthStatus.unknown => path == Routes.splash ? null : Routes.splash,
    AuthStatus.authenticated => Routes.isSignedIn(path) ? null : Routes.home,
    AuthStatus.unauthenticated => Routes.isPublic(path) ? null : Routes.login,
  };
}
