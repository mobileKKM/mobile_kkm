import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/auth/models/email_link.dart';

void main() {
  group('EmailLink', () {
    test('parses the activation link', () {
      final link = EmailLink.tryParse(Uri.parse('https://ekp.mpk.krakow.pl/konto-uzytkownika/activate,0a1b2c.html'));
      expect(link?.kind, EmailLinkKind.activate);
      expect(link?.token, '0a1b2c');
    });

    test('parses the reset link from a bare path', () {
      final link = EmailLink.tryParse(Uri.parse('/konto-uzytkownika/reset,0a1b2c.html'));
      expect(link?.kind, EmailLinkKind.resetPassword);
      expect(link?.token, '0a1b2c');
    });

    test('ignores other paths', () {
      for (final path in [
        '/',
        '/login',
        '/konto-uzytkownika/',
        '/konto-uzytkownika/reset,.html',
        '/konto-uzytkownika/other,abc.html',
        '/payment/success',
      ]) {
        expect(EmailLink.tryParse(Uri.parse(path)), isNull, reason: path);
      }
    });
  });
}
