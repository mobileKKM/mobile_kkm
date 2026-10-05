import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/router/app_router.dart';
import 'package:mobile_kkm/features/auth/providers/auth_controller.dart';

void main() {
  group('redirectFor', () {
    String? go(String location, AuthStatus status) =>
        redirectFor(Uri.parse(location), status);

    test('e-mail links map to their screens in every auth state', () {
      for (final status in AuthStatus.values) {
        expect(
          go('/konto-uzytkownika/reset,abc.html', status),
          '/reset-password/abc',
        );
        expect(
          go('/konto-uzytkownika/activate,abc.html', status),
          '/activate/abc',
        );
        expect(go('/reset-password/abc', status), isNull);
        expect(go('/activate/abc', status), isNull);
      }
    });

    test('unknown auth state waits on the splash', () {
      expect(go('/', AuthStatus.unknown), isNull);
      expect(go('/login', AuthStatus.unknown), '/');
      expect(go('/home', AuthStatus.unknown), '/');
    });

    test('signed-out users are confined to the public screens', () {
      expect(go('/', AuthStatus.unauthenticated), '/login');
      expect(go('/home', AuthStatus.unauthenticated), '/login');
      expect(go('/nope', AuthStatus.unauthenticated), '/login');
      expect(go('/login', AuthStatus.unauthenticated), isNull);
      expect(
        go('/login?notice=password-reset', AuthStatus.unauthenticated),
        isNull,
      );
      expect(go('/register', AuthStatus.unauthenticated), isNull);
      expect(go('/forgot-password/sent', AuthStatus.unauthenticated), isNull);
    });

    test('signed-in users go home', () {
      expect(go('/', AuthStatus.authenticated), '/home');
      expect(go('/login', AuthStatus.authenticated), '/home');
      expect(go('/home', AuthStatus.authenticated), isNull);
    });
  });
}
