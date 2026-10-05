import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';

const _envelope = {'code': null, 'message': null};

void main() {
  testWidgets('requesting a reset shows the inbox screen', (tester) async {
    final adapter = FakeAdapter()
      ..reply('POST', '/auth/reset-password-link-request', 200, _envelope);
    final links = FakeLinkSettings();
    await pumpApp(tester, adapter, linkSettings: links);

    await tapVisible(tester, find.text('Forgot password?'));
    await tester.enterText(field('E-mail'), 'jan@example.com');
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Send link'));

    final request = adapter.requestTo('/auth/reset-password-link-request');
    expect(request.data, {'email': 'jan@example.com'});
    expect(find.text('Check your inbox'), findsOneWidget);

    // Link handling is off: offer the system settings.
    await tapVisible(tester, find.text('Open link settings'));
    expect(links.openedSettings, 1);
  });

  testWidgets('an unknown address gets the same confirmation', (tester) async {
    final adapter = FakeAdapter()
      ..reply('POST', '/auth/reset-password-link-request', 404, {
        'code': 1,
        'message': 'Nie znaleziono konta',
      });
    await pumpApp(tester, adapter);

    await tapVisible(tester, find.text('Forgot password?'));
    await tester.enterText(field('E-mail'), 'nobody@example.com');
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Send link'));

    expect(find.text('Check your inbox'), findsOneWidget);
    expect(find.text('Nie znaleziono konta'), findsNothing);
  });

  testWidgets('where links are not intercepted the browser is mentioned', (
    tester,
  ) async {
    final adapter = FakeAdapter()
      ..reply('POST', '/auth/reset-password-link-request', 200, _envelope);
    await pumpApp(
      tester,
      adapter,
      linkSettings: FakeLinkSettings(supported: false),
    );

    await tapVisible(tester, find.text('Forgot password?'));
    await tester.enterText(field('E-mail'), 'jan@example.com');
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Send link'));

    expect(find.textContaining('opens in your browser'), findsOneWidget);
    expect(find.text('Open link settings'), findsNothing);
  });

  testWidgets('the e-mailed reset link opens the new-password form', (
    tester,
  ) async {
    final adapter = FakeAdapter()
      ..reply('GET', '/auth/password-policy', 200, {
        'minLength': 8,
        'requiredUppercase': 1,
        'requiredDigits': 1,
      })
      ..reply('POST', '/auth/reset-password', 200, _envelope);
    final app = await pumpApp(tester, adapter);

    app.router.go('/konto-uzytkownika/reset,0a1b2c.html');
    await tester.pumpAndSettle();
    expect(find.text('Set new password'), findsOneWidget);

    await tester.enterText(field('New password'), 'Secret123');
    await tester.enterText(field('Repeat password'), 'Secret124');
    await tapVisible(
      tester,
      find.widgetWithText(FilledButton, 'Change password'),
    );
    expect(find.text('The passwords do not match'), findsOneWidget);

    await tester.enterText(field('Repeat password'), 'Secret123');
    await tapVisible(
      tester,
      find.widgetWithText(FilledButton, 'Change password'),
    );

    expect(adapter.requestTo('/auth/reset-password').data, {
      'token': '0a1b2c',
      'newPassword': 'Secret123',
    });
    expect(
      find.text('Your password has been changed. You can sign in now.'),
      findsOneWidget,
    );
  });

  testWidgets('the e-mailed activation link activates the account', (
    tester,
  ) async {
    final adapter = FakeAdapter()
      ..reply('POST', '/auth/activate', 200, _envelope);
    final app = await pumpApp(tester, adapter);

    app.router.go('/konto-uzytkownika/activate,0a1b2c.html');
    await tester.pumpAndSettle();

    expect(adapter.requestTo('/auth/activate').data, {'token': '0a1b2c'});
    expect(
      find.text('Your account is active. You can sign in now.'),
      findsOneWidget,
    );

    await tapVisible(tester, find.text('Go to sign in'));
    expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
  });

  testWidgets('a rejected activation link shows the failure', (tester) async {
    final adapter = FakeAdapter()
      ..reply('POST', '/auth/activate', 400, {
        'code': 4,
        'message': 'Link aktywacyjny wygasł',
      });
    final app = await pumpApp(tester, adapter);

    app.router.go('/konto-uzytkownika/activate,0a1b2c.html');
    await tester.pumpAndSettle();

    expect(find.textContaining('could not be activated'), findsOneWidget);
    expect(find.text('Link aktywacyjny wygasł'), findsOneWidget);
  });
}
