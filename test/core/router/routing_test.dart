import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/router/app_router.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';
import 'package:mobile_kkm/features/card_setup/models/card_gate.dart';

void main() {
  group('redirectFor', () {
    String? go(String location, AuthStatus status) => redirectFor(Uri.parse(location), status);

    test('e-mail links map to their screens in every auth state', () {
      for (final status in AuthStatus.values) {
        expect(go('/konto-uzytkownika/reset,abc.html', status), '/reset-password/abc');
        expect(go('/konto-uzytkownika/activate,abc.html', status), '/activate/abc');
        expect(go('/reset-password/abc', status), isNull);
        expect(go('/activate/abc', status), isNull);
      }
    });

    test('an outdated client sees the update screen and nothing else', () {
      for (final status in AuthStatus.values) {
        for (final location in ['/', '/login', '/home', '/account/edit', '/konto-uzytkownika/reset,abc.html']) {
          expect(redirectFor(Uri.parse(location), status, outdated: true), '/update-required', reason: location);
        }
        expect(redirectFor(Uri.parse('/update-required'), status, outdated: true), isNull);
      }
    });

    test('the update screen is left when it does not apply', () {
      expect(go('/update-required', AuthStatus.unknown), '/');
      expect(go('/update-required', AuthStatus.unauthenticated), '/login');
      expect(go('/update-required', AuthStatus.authenticated), '/home');
    });

    test('the debug menu is open signed in and out, once the app has started', () {
      expect(go('/debug', AuthStatus.unknown), '/');
      expect(go('/debug', AuthStatus.unauthenticated), isNull);
      expect(go('/debug', AuthStatus.authenticated), isNull);
    });

    test('unknown auth state waits on the splash', () {
      expect(go('/', AuthStatus.unknown), isNull);
      expect(go('/login', AuthStatus.unknown), '/');
      expect(go('/home', AuthStatus.unknown), '/');
    });

    test('signed-out users are confined to the public screens', () {
      expect(go('/', AuthStatus.unauthenticated), '/login');
      expect(go('/home', AuthStatus.unauthenticated), '/login');
      expect(go('/tickets', AuthStatus.unauthenticated), '/login');
      expect(go('/account/edit', AuthStatus.unauthenticated), '/login');
      expect(go('/ticket/NDAwMDAxIzE', AuthStatus.unauthenticated), '/login');
      expect(go('/nope', AuthStatus.unauthenticated), '/login');
      expect(go('/login', AuthStatus.unauthenticated), isNull);
      expect(go('/login?notice=password-reset', AuthStatus.unauthenticated), isNull);
      expect(go('/register', AuthStatus.unauthenticated), isNull);
      expect(go('/forgot-password/sent', AuthStatus.unauthenticated), isNull);
    });

    test('without an mKKM card the signed-in area is the card set-up alone', () {
      String? gated(String location, CardGate card) =>
          redirectFor(Uri.parse(location), AuthStatus.authenticated, card: card);

      for (final card in [CardGate.setUp, CardGate.detached, CardGate.settling]) {
        for (final location in ['/', '/home', '/tickets', '/ticket/NDAwMDAxIzE', '/login']) {
          expect(gated(location, card), '/card-setup', reason: '$location, $card');
        }
        expect(gated('/card-setup', card), isNull);
        // Still open: it needs no session either.
        expect(gated('/debug', card), isNull);
        expect(gated('/reset-password/abc', card), isNull);
      }
      // The steps only while there is a card to make.
      expect(gated('/card-setup/address', CardGate.setUp), isNull);
      expect(gated('/card-setup/address/photo', CardGate.setUp), isNull);
      for (final card in [CardGate.detached, CardGate.settling]) {
        expect(gated('/card-setup/address/photo', card), '/card-setup');
      }
    });

    test('until the first user data is there, the sign-in and the splash stay', () {
      String? checking(String location) =>
          redirectFor(Uri.parse(location), AuthStatus.authenticated, card: CardGate.checking);

      expect(checking('/login'), isNull);
      expect(checking('/'), isNull);
      // Neither the app nor the set-up before it is known which.
      expect(checking('/home'), '/');
      expect(checking('/card-setup'), '/');
      expect(checking('/debug'), isNull);
    });

    test('with a card the set-up is left, and closed to the signed-out', () {
      expect(go('/card-setup', AuthStatus.authenticated), '/home');
      expect(go('/card-setup/address', AuthStatus.authenticated), '/home');
      expect(go('/card-setup', AuthStatus.unauthenticated), '/login');
      expect(go('/card-setup', AuthStatus.unknown), '/');
    });

    test('signed-in users go home from everything outside the signed-in area', () {
      expect(go('/', AuthStatus.authenticated), '/home');
      expect(go('/login', AuthStatus.authenticated), '/home');
      expect(go('/nope', AuthStatus.authenticated), '/home');
    });

    test('signed-in users may stay on the sections and their screens', () {
      for (final path in [
        '/home',
        '/tickets',
        '/map',
        '/account',
        '/account/edit',
        '/account/change-password',
        '/account/delete',
        '/karta-krakowska',
        '/buy',
        '/subscription',
        '/ticket/NDAwMDAxIzE',
        '/ticket/NDAwMDAxIzE/return',
        '/ticket-control/feedfacefeedfacefeedfacefeedface',
      ]) {
        expect(go(path, AuthStatus.authenticated), isNull, reason: path);
      }
    });
  });
}
