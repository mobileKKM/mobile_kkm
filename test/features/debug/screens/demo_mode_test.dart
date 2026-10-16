import 'dart:convert';
import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/demo/demo_data.dart';
import 'package:mobile_kkm/core/providers/demo_mode_provider.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _userData = '/account/user-data';

FakeAdapter _adapter() => FakeAdapter()
  ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([validTicket(assigned: true)]))
  ..reply('GET', _userData, 200, userDataJson(address: addressJson, phone: '600123456'));

/// The app signed in, with demo mode switched on.
Future<App> _demo(WidgetTester tester, FakeAdapter adapter, {bool tall = false}) async {
  final app = await pumpApp(tester, adapter, session: signedInSession, tall: tall);
  app.container.read(demoModeProvider.notifier).set(true);
  await tester.pumpAndSettle();
  return app;
}

void main() {
  testWidgets('Home and Account show the made-up person, not the user', (tester) async {
    await _demo(tester, _adapter());

    expect(find.text('Hello, Anna!'), findsOneWidget);
    expect(find.text('Customer number 123456'), findsOneWidget);
    expect(find.textContaining('Jan'), findsNothing);
    expect(find.textContaining('100001'), findsNothing);

    await openTab(tester, 'Account');
    expect(find.text('Anna Kowalska'), findsOneWidget);
    expect(find.textContaining('123456', findRichText: true), findsOneWidget);
    expect(find.textContaining('Testowy'), findsNothing);
    expect(find.textContaining('100001', findRichText: true), findsNothing);
  });

  testWidgets('switched off again, the user is back', (tester) async {
    final app = await _demo(tester, _adapter());

    app.container.read(demoModeProvider.notifier).set(false);
    await tester.pumpAndSettle();

    expect(find.text('Hello, Jan!'), findsOneWidget);
    expect(find.text('Customer number 100001'), findsOneWidget);
  });

  testWidgets('Edit account shows the placeholders and saves nothing', (tester) async {
    final adapter = _adapter()..reply('POST', _userData, 204);
    await _demo(tester, adapter, tall: true);
    await openTab(tester, 'Account');
    await tapVisible(tester, find.widgetWithText(GroupRow, 'Edit account'));

    final firstName = tester.widget<TextFormField>(field('First name')).controller!;
    expect(firstName.text, 'Anna');
    expect(find.text('anna.kowalska@example.com'), findsOneWidget);
    expect(find.text('jan@example.com'), findsNothing);

    await tester.enterText(field('First name'), 'Ewa');
    await tester.pump();

    final save = find.widgetWithText(FilledButton, 'Save changes');
    final changePhoto = find.widgetWithText(FilledButton, 'Change photo');
    expect(tester.widget<FilledButton>(save).onPressed, isNull);
    expect(tester.widget<FilledButton>(changePhoto).onPressed, isNull);
    expect(adapter.requests.where((request) => request.method == 'POST'), isEmpty);
  });

  testWidgets('Ticket control shows a code nobody can check a ticket with', (tester) async {
    final contract = jsonDecode(
      File('packages/ekp_api/test/fixtures/contract_e_response.json').readAsStringSync(),
    ) as Map<String, dynamic>;
    final adapter = _adapter()..reply('POST', '/mkkm/tickets/contract-e', 200, contract);
    await _demo(tester, adapter);
    await openTab(tester, 'Tickets');
    await tester.tap(find.widgetWithText(FilledButton, 'Ticket control'));
    await pumpWithCode(tester);

    expect(tester.widget<BarcodeWidget>(find.byKey(const Key('ticket-code'))).data, utf8.encode(demoTicketCode));
    expect(find.text('Anna Kowalska'), findsOneWidget);
    expect(find.text('123456'), findsOneWidget);
    // The real request still went out, so the timer behaves as it would.
    expect(adapter.requestsTo('/mkkm/tickets/contract-e'), hasLength(1));
  });

  testWidgets('the Karta Krakowska code is a placeholder, not the picture the server drew', (tester) async {
    final adapter = _adapter()
      ..reply('GET', '/account/inhabitant-contract', 200, {
        'expirationDate': clock.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch,
        'contract': base64Encode(onePixelPng),
        'code': null,
        'message': null,
      });
    await _demo(tester, adapter);
    await openTab(tester, 'Account');
    await tapVisible(tester, find.widgetWithText(GroupRow, 'Karta Krakowska'));
    await tester.tap(find.widgetWithText(FilledButton, 'Show status code'));
    await pumpWithCode(tester);

    final code = find.byKey(const Key('status-code'));
    expect(tester.widget<BarcodeWidget>(code).data, utf8.encode(demoCityCardCode));
    expect(find.text('Anna Kowalska'), findsOneWidget);
  });

  testWidgets('the requests still use the real customer number', (tester) async {
    final adapter = _adapter()..reply('GET', '/api/v1/tickets', 200, historyJson);
    await _demo(tester, adapter);
    await openTab(tester, 'Tickets');

    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();

    expect(adapter.requestTo('/api/v1/tickets').queryParameters['customerCode'], '100001');
  });
}
