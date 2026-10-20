import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/coming_soon_screen.dart';
import 'package:mobile_kkm/features/account/screens/account_screen.dart';
import 'package:mobile_kkm/features/account/screens/change_password_screen.dart';
import 'package:mobile_kkm/features/account/screens/delete_account_screen.dart';
import 'package:mobile_kkm/features/account/screens/edit_account_screen.dart';
import 'package:mobile_kkm/features/auth/models/email_link.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/auth/screens/activate_screen.dart';
import 'package:mobile_kkm/features/auth/screens/forgot_password_screen.dart';
import 'package:mobile_kkm/features/auth/screens/inbox_screen.dart';
import 'package:mobile_kkm/features/auth/screens/login_screen.dart';
import 'package:mobile_kkm/features/auth/screens/register_screen.dart';
import 'package:mobile_kkm/features/auth/screens/reset_password_screen.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';
import 'package:mobile_kkm/features/card_setup/providers/card_gate_provider.dart';
import 'package:mobile_kkm/features/card_setup/screens/card_address_screen.dart';
import 'package:mobile_kkm/features/card_setup/screens/card_photo_screen.dart';
import 'package:mobile_kkm/features/card_setup/screens/card_setup_screen.dart';
import 'package:mobile_kkm/features/city_card/screens/city_card_code_screen.dart';
import 'package:mobile_kkm/features/city_card/screens/city_card_screen.dart';
import 'package:mobile_kkm/features/debug/screens/debug_screen.dart';
import 'package:mobile_kkm/features/home/screens/home_screen.dart';
import 'package:mobile_kkm/features/map/screens/map_screen.dart';
import 'package:mobile_kkm/features/purchase/models/purchase_selection.dart';
import 'package:mobile_kkm/features/purchase/screens/buy_screen.dart';
import 'package:mobile_kkm/features/purchase/screens/checkout_screen.dart';
import 'package:mobile_kkm/features/purchase/screens/payment_status_screen.dart';
import 'package:mobile_kkm/features/purchase/services/checkout_controller.dart';
import 'package:mobile_kkm/features/shell/widgets/main_shell.dart';
import 'package:mobile_kkm/features/splash/screens/splash_screen.dart';
import 'package:mobile_kkm/features/tickets/screens/ticket_change_line_screen.dart';
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
  ref.listen(cardGateProvider, (_, _) => refresh.value++);

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
        card: ref.read(cardGateProvider),
      );
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: Routes.updateRequired, builder: (context, state) => const UpdateRequiredScreen()),
      // In the place of the whole signed-in area until the account has a card.
      GoRoute(
        path: Routes.cardSetup,
        builder: (context, state) => const CardSetupScreen(),
        routes: [
          GoRoute(
            path: 'address',
            builder: (context, state) => const CardAddressScreen(),
            routes: [GoRoute(path: 'photo', builder: (context, state) => const CardPhotoScreen())],
          ),
        ],
      ),
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
          GoRoute(
            path: 'pay',
            builder: (context, state) => TicketPayScreen(
              transactionCode: state.pathParameters['transactionCode']!,
              details: switch (state.extra) {
                final TicketDetailResponse details => details,
                _ => null,
              },
            ),
          ),
          GoRoute(
            path: 'change-line',
            builder: (context, state) =>
                TicketChangeLineScreen(transactionCode: state.pathParameters['transactionCode']!),
          ),
        ],
      ),
      GoRoute(
        path: '/ticket-control/:ticketGuid',
        builder: (context, state) => TicketControlScreen(ticketGuid: state.pathParameters['ticketGuid']!),
      ),
      GoRoute(
        path: Routes.cityCard,
        builder: (context, state) => const CityCardScreen(),
        routes: [GoRoute(path: 'code', builder: (context, state) => const CityCardCodeScreen())],
      ),
      GoRoute(path: Routes.debug, builder: (context, state) => const DebugScreen()),
      GoRoute(path: Routes.accountEdit, builder: (context, state) => const EditAccountScreen()),
      GoRoute(path: Routes.accountChangePassword, builder: (context, state) => const ChangePasswordScreen()),
      GoRoute(path: Routes.accountDelete, builder: (context, state) => const DeleteAccountScreen()),
      GoRoute(
        path: Routes.buy,
        builder: (context, state) => BuyScreen(entry: purchaseEntryOf(state.uri)),
        routes: [
          GoRoute(
            path: 'pay',
            // The priced choice comes along; without it (a restored stack) the form starts again.
            redirect: (context, state) => state.extra is CheckoutEntry ? null : Routes.buy,
            builder: (context, state) => CheckoutScreen(entry: state.extra! as CheckoutEntry),
          ),
        ],
      ),
      GoRoute(path: Routes.payment, builder: (context, state) => const PaymentStatusScreen()),
      // Not built yet.
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
///
/// [card]: whether the signed-in user has an mKKM card. Until they do, the
/// signed-in area is the card set-up alone; until that is known, nothing
/// moves.
@visibleForTesting
String? redirectFor(Uri uri, AuthStatus status, {bool outdated = false, CardGate card = CardGate.open}) {
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

  // The debug menu needs no session, only an app that has started.
  if (path == Routes.debug && status != AuthStatus.unknown) {
    return null;
  }

  return switch (status) {
    AuthStatus.unknown => path == Routes.splash ? null : Routes.splash,
    AuthStatus.authenticated => switch (card) {
      CardGate.open => Routes.isSignedIn(path) ? null : Routes.home,
      // TODO(card-gate): Delete account is let past the gate of a detached
      // card, since an account can only be deleted once its card was taken
      // off on the website, which is when the gate is shut. Nothing leads
      // there yet. To go when the re-attach moves out of the gate.
      CardGate.detached when path == Routes.accountDelete => null,
      CardGate.setUp => Routes.isCardSetup(path) ? null : Routes.cardSetup,
      CardGate.detached || CardGate.settling => path == Routes.cardSetup ? null : Routes.cardSetup,
      // The first user data is on its way. Whatever led here waits for it:
      // the sign-in with its button busy, a start with a session the splash.
      CardGate.checking => path == Routes.splash || Routes.isPublic(path) ? null : Routes.splash,
    },
    AuthStatus.unauthenticated => Routes.isPublic(path) ? null : Routes.login,
  };
}

/// How `/buy` was opened: `?extend=` or `?similar=` a transaction code.
PurchaseEntry purchaseEntryOf(Uri uri) {
  final query = uri.queryParameters;
  if (query['extend'] case final code? when code.isNotEmpty) {
    return PurchaseEntry.extend(code);
  }
  if (query['similar'] case final code? when code.isNotEmpty) {
    return PurchaseEntry.similar(code);
  }
  return const PurchaseEntry.fresh();
}
