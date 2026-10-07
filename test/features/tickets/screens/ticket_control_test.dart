import 'dart:convert';
import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _contract = '/mkkm/tickets/contract-e';

/// The synthetic contract of `ekp_api`'s tests and the token planted in it.
final _contractJson = jsonDecode(
  File('packages/ekp_api/test/fixtures/contract_e_response.json').readAsStringSync(),
) as Map<String, dynamic>;
final _token = '07E5C3A18F6D4B29' * 32;

FakeAdapter _adapter() => FakeAdapter()
  ..reply('GET', '/mkkm/tickets/list', 200, ticketsReply([validTicket(assigned: true)]))
  ..reply('GET', '/account/user-data', 200, userDataJson());

Future<App> _open(WidgetTester tester, FakeAdapter adapter) async {
  final app = await pumpApp(tester, adapter, session: signedInSession);
  await openTab(tester, 'Tickets');
  await tester.tap(find.widgetWithText(FilledButton, 'Ticket control'));
  await tester.pumpAndSettle();
  return app;
}

void main() {
  testWidgets('shows whose ticket it is and its code, fetched once', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);

    expect(app.location, Routes.ticketControl(networkGuid));
    expect(adapter.requestTo(_contract).data, contains('message'));
    expect(tester.widget<BarcodeWidget>(find.byType(BarcodeWidget)).data, utf8.encode(_token));
    expect(find.text('Jan Testowy'), findsOneWidget);
    expect(find.textContaining('100001'), findsOneWidget);
    expect(find.text('Code valid for 1:59'), findsOneWidget);

    await tester.pump(const Duration(seconds: 60));
    expect(find.text('Code valid for 0:59'), findsOneWidget);
    expect(adapter.requestsTo(_contract), hasLength(1));
  });

  testWidgets('closes when the code has run out', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, _contractJson);
    final app = await _open(tester, adapter);

    await tester.pump(const Duration(seconds: 119));
    await tester.pumpAndSettle();

    expect(app.location, '/tickets');
  });

  testWidgets('the server says why there is no code', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, {'code': 4, 'message': 'Bilet nie jest powiązany.'});
    await _open(tester, adapter);

    expect(find.text('Bilet nie jest powiązany.'), findsOneWidget);
    expect(find.byType(BarcodeWidget), findsNothing);
  });

  testWidgets('a code that cannot be read can be asked for again', (tester) async {
    final adapter = _adapter()..reply('POST', _contract, 200, {'contract': 'AAAA'});
    await _open(tester, adapter);
    expect(find.text('The ticket code could not be loaded. Try again.'), findsOneWidget);

    adapter.reply('POST', _contract, 200, _contractJson);
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(find.byType(BarcodeWidget), findsOneWidget);
    // Leave before the test ends: the countdown is still running.
    await tester.pageBack();
    await tester.pumpAndSettle();
  });
}
