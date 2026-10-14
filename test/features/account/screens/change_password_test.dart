import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _change = '/auth/change-password';

FakeAdapter _adapter() => FakeAdapter()
  ..reply('GET', '/account/user-data', 200, userDataJson())
  ..reply('GET', '/auth/password-policy', 200, {
    'minLength': 8,
    'requiredLowercase': 1,
    'requiredUppercase': 1,
    'requiredDigits': 1,
  })
  ..reply('POST', _change, 200, {'code': null, 'message': null});

Future<App> _open(WidgetTester tester, FakeAdapter adapter) async {
  final app = await pumpApp(tester, adapter, session: signedInSession);
  await openTab(tester, 'Account');
  await tapVisible(tester, find.widgetWithText(GroupRow, 'Change password'));
  return app;
}

final _submit = find.widgetWithText(FilledButton, 'Change password');

bool _ready(WidgetTester tester) => tester.widget<FilledButton>(_submit).onPressed != null;

Future<void> _type(
  WidgetTester tester, {
  String current = 'Stare1234',
  String password = 'Krakow2026',
  String? repeat,
}) async {
  await tester.enterText(field('Current password'), current);
  await tester.enterText(field('New password'), password);
  await tester.enterText(field('Repeat new password'), repeat ?? password);
  await tester.pump();
}

void main() {
  testWidgets('the button waits for all three, a password the server takes and its repeat', (tester) async {
    await _open(tester, _adapter());
    expect(_ready(tester), isFalse);
    expect(find.text('At least 8 characters'), findsOneWidget);

    await _type(tester, password: 'krakow');
    expect(_ready(tester), isFalse);

    await _type(tester, repeat: 'Krakow2025');
    expect(_ready(tester), isFalse);

    await _type(tester, current: '');
    expect(_ready(tester), isFalse);

    await _type(tester);
    expect(_ready(tester), isTrue);
  });

  testWidgets('a repeat that differs is said once its field is left', (tester) async {
    await _open(tester, _adapter());
    await tester.enterText(field('New password'), 'Krakow2026');
    await tester.tap(field('Repeat new password'));
    await tester.enterText(field('Repeat new password'), 'Krakow');
    await tester.pump();
    expect(find.text('The passwords do not match'), findsNothing);

    await tester.tap(field('Current password'));
    await tester.pump();

    expect(find.text('The passwords do not match'), findsOneWidget);
  });

  testWidgets('changing it leads back to Account, still signed in', (tester) async {
    final adapter = _adapter();
    final app = await _open(tester, adapter);
    await _type(tester);

    await tapVisible(tester, _submit);

    expect(adapter.requestTo(_change).data, {
      'previousPassword': 'Stare1234',
      'newPassword': 'Krakow2026',
      'repeatPassword': 'Krakow2026',
    });
    expect(app.location, Routes.account);
    expect(find.text('Password changed.'), findsOneWidget);
  });

  testWidgets('a refusal is the server\'s message on top', (tester) async {
    const reason = 'Niepoprawne poprzednie hasło';
    final adapter = _adapter()..reply('POST', _change, 400, {'message': reason, 'exceptionCode': 259, 'code': 8});
    final app = await _open(tester, adapter);
    await _type(tester);

    await tapVisible(tester, _submit);

    expect(find.widgetWithText(MessageBanner, reason), findsOneWidget);
    expect(app.location, Routes.accountChangePassword);
    expect(_ready(tester), isTrue);
  });

  testWidgets('leaving asks nothing, whatever was typed', (tester) async {
    final app = await _open(tester, _adapter());
    await _type(tester);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(app.location, Routes.account);
  });

  testWidgets('offline, the password cannot be changed', (tester) async {
    final adapter = _adapter()..fail('GET', '/service-status');
    await _open(tester, adapter);
    await _type(tester);

    expect(find.textContaining('You’re offline.', findRichText: true), findsOneWidget);
    expect(_ready(tester), isFalse);
  });
}
