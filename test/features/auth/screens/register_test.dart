import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/auth/constants/information_obligation.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';

const _noPesel = "I don't have a PESEL number";
const _consent = 'Akceptuję regulamin';

FakeAdapter _adapter() => FakeAdapter()
  ..reply('GET', '/auth/password-policy', 200, {
    'minLength': 8,
    'requiredLowercase': 0,
    'requiredUppercase': 1,
    'requiredDigits': 1,
  })
  ..reply('GET', '/auth/marketing-consents', 200, {
    'marketingConsents': [
      {'id': 4, 'content': _consent, 'isChecked': false},
    ],
  })
  ..reply('GET', '/client/mobile-app/config', 200, {'regulationsUrl': 'https://ekp.test/documents/Regulamin konta.pdf'})
  ..reply('POST', '/auth/register', 200, {'code': null, 'message': null});

Future<void> _openRegister(WidgetTester tester, FakeAdapter adapter, {List<Uri>? openedUrls}) async {
  await pumpApp(tester, adapter, openedUrls: openedUrls);
  await tapVisible(tester, find.text('Create account'));
}

/// Fills everything except PESEL / birth date and the consent.
Future<void> _fillBasics(WidgetTester tester) async {
  await tester.enterText(field('First name'), 'Jan');
  await tester.enterText(field('Last name'), 'Kowalski');
  await tester.enterText(field('E-mail'), 'jan@example.com');
  await tester.enterText(field('Repeat e-mail'), 'jan@example.com');
  await tester.enterText(field('Password'), 'Secret123');
  await tester.enterText(field('Repeat password'), 'Secret123');
}

Future<void> _submit(WidgetTester tester) => tapVisible(tester, find.widgetWithText(FilledButton, 'Create account'));

Iterable<Object?> _registerRequests(FakeAdapter adapter) =>
    adapter.requests.where((r) => r.path.endsWith('/auth/register'));

TextFormField _widget(WidgetTester tester, String label) => tester.widget<TextFormField>(field(label));

void main() {
  testWidgets('sections follow the official order', (tester) async {
    await _openRegister(tester, _adapter());

    double top(String text) => tester.getTopLeft(find.text(text).first).dy;
    final order = [
      'Personal details',
      'First name',
      'PESEL number',
      'Date of birth',
      'Contact details',
      'Repeat e-mail',
      // The section heading; the field label of the same name comes later.
      'Password',
      'Repeat password',
      _consent,
      'Information on data processing',
    ].map(top).toList();
    expect(order, orderedEquals([...order]..sort()));
  });

  testWidgets('birth date follows the PESEL and is not editable', (tester) async {
    await _openRegister(tester, _adapter());

    expect(_widget(tester, 'Date of birth').enabled, isFalse);
    expect(_widget(tester, 'Date of birth').controller!.text, isEmpty);

    await tester.enterText(field('PESEL number'), '44051401359');
    await tester.pumpAndSettle();

    expect(_widget(tester, 'Date of birth').controller!.text, '5/14/1944');
    expect(_widget(tester, 'Date of birth').enabled, isFalse);

    // An incomplete number no longer yields a date.
    await tester.enterText(field('PESEL number'), '4405140135');
    await tester.pumpAndSettle();
    expect(_widget(tester, 'Date of birth').controller!.text, isEmpty);
  });

  testWidgets('without a PESEL the birth date is picked by hand', (tester) async {
    await _openRegister(tester, _adapter());
    await tester.enterText(field('PESEL number'), '44051401359');

    await tapVisible(tester, find.text(_noPesel));

    expect(_widget(tester, 'PESEL number').enabled, isFalse);
    expect(_widget(tester, 'PESEL number').controller!.text, isEmpty);
    expect(_widget(tester, 'Date of birth').enabled, isTrue);
    expect(_widget(tester, 'Date of birth').controller!.text, isEmpty);

    await tapVisible(tester, field('Date of birth'));
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(_widget(tester, 'Date of birth').controller!.text, isNotEmpty);

    // Switching back drops the hand-picked date.
    await tapVisible(tester, find.text(_noPesel));
    expect(_widget(tester, 'Date of birth').enabled, isFalse);
    expect(_widget(tester, 'Date of birth').controller!.text, isEmpty);
  });

  testWidgets('submits PESEL with the derived birth date', (tester) async {
    final adapter = _adapter();
    await _openRegister(tester, adapter);

    await _fillBasics(tester);
    await tester.enterText(field('PESEL number'), '44051401359');
    await tapVisible(tester, find.text(_consent));
    await _submit(tester);

    final body = adapter.requestTo('/auth/register').data as Map<String, dynamic>;
    expect(body['email'], 'jan@example.com');
    expect(body['repeat_email'], 'jan@example.com');
    expect(body['repeat_password'], 'Secret123');
    expect(body['pesel'], '44051401359');
    expect(body['birthDate'], startsWith('1944-05-14T00:00:00'));
    expect(body['marketingConsents'], [
      {'id': 4, 'isChecked': true},
    ]);
    expect(find.text('Check your inbox'), findsOneWidget);
    expect(find.textContaining('jan@example.com'), findsOneWidget);
  });

  testWidgets('submits a hand-picked birth date without a PESEL', (tester) async {
    final adapter = _adapter();
    await _openRegister(tester, adapter);

    await _fillBasics(tester);
    await tapVisible(tester, find.text(_noPesel));
    await tapVisible(tester, field('Date of birth'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text(_consent));
    await _submit(tester);

    final body = adapter.requestTo('/auth/register').data as Map<String, dynamic>;
    expect(body.containsKey('pesel'), isFalse);
    expect(body['birthDate'], isNotNull);
  });

  testWidgets('invalid input is rejected without a request', (tester) async {
    final adapter = _adapter();
    await _openRegister(tester, adapter);

    await tester.enterText(field('E-mail'), 'not-an-email');
    await tester.enterText(field('Password'), 'weak');
    await tester.enterText(field('PESEL number'), '44051401358');
    await _submit(tester);

    expect(find.text('Enter a valid e-mail address'), findsOneWidget);
    expect(find.text('The password does not meet the requirements'), findsOneWidget);
    expect(find.text('Enter a valid PESEL number'), findsOneWidget);
    expect(_registerRequests(adapter), isEmpty);
  });

  testWidgets('repeat fields must match', (tester) async {
    final adapter = _adapter();
    await _openRegister(tester, adapter);

    await _fillBasics(tester);
    await tester.enterText(field('Repeat e-mail'), 'jan@example.org');
    await tester.enterText(field('Repeat password'), 'Secret124');
    await tester.enterText(field('PESEL number'), '44051401359');
    await tapVisible(tester, find.text(_consent));
    await _submit(tester);

    expect(find.text('The e-mail addresses do not match'), findsOneWidget);
    expect(find.text('The passwords do not match'), findsOneWidget);
    expect(_registerRequests(adapter), isEmpty);
  });

  testWidgets('the consent is mandatory', (tester) async {
    final adapter = _adapter();
    await _openRegister(tester, adapter);

    await _fillBasics(tester);
    await tester.enterText(field('PESEL number'), '44051401359');
    await _submit(tester);

    expect(find.text('Consent is required'), findsOneWidget);
    expect(_registerRequests(adapter), isEmpty);

    await tapVisible(tester, find.text(_consent));
    await _submit(tester);
    expect(_registerRequests(adapter), hasLength(1));
  });

  testWidgets('the regulations link opens the document', (tester) async {
    final opened = <Uri>[];
    await _openRegister(tester, _adapter(), openedUrls: opened);

    await tapVisible(tester, find.text('Regulations'));

    expect(opened.map((url) => url.toString()), ['https://ekp.test/documents/Regulamin%20konta.pdf']);
  });

  testWidgets('no regulations link when the config is unavailable', (tester) async {
    final adapter = _adapter()..fail('GET', '/client/mobile-app/config');
    await _openRegister(tester, adapter);

    expect(find.text(_consent), findsOneWidget);
    expect(find.text('Regulations'), findsNothing);
  });

  testWidgets('the data notice expands and collapses', (tester) async {
    await _openRegister(tester, _adapter());

    Text notice() => tester.widget<Text>(find.text(informationObligation));
    expect(notice().maxLines, 3);

    await tapVisible(tester, find.text('Show more'));
    expect(notice().maxLines, isNull);

    await tapVisible(tester, find.text('Show less'));
    expect(notice().maxLines, 3);
  });

  testWidgets('a server error message is shown', (tester) async {
    final adapter = _adapter()
      ..reply('POST', '/auth/register', 400, {'code': 2, 'message': 'Konto o podanym adresie już istnieje'});
    await _openRegister(tester, adapter);

    await _fillBasics(tester);
    await tester.enterText(field('PESEL number'), '44051401359');
    await tapVisible(tester, find.text(_consent));
    await _submit(tester);

    await tester.ensureVisible(find.text('Konto o podanym adresie już istnieje'));
    expect(find.text('Check your inbox'), findsNothing);
  });
}
