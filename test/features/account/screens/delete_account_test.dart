import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _cards = '/storage-medium/list';
const _anonymise = '/account/anonymise';

/// An account with [cards] attached cards.
FakeAdapter _adapter({int cards = 0}) => FakeAdapter()
  ..reply('GET', '/account/user-data', 200, userDataJson())
  ..reply('GET', _cards, 200, {
    'items': [
      for (var card = 0; card < cards; card++) {'cityCardCode': 8, 'customerCode': 100001},
    ],
  })
  ..reply('PUT', _anonymise, 200, {'code': null, 'message': 'Twoje konto zostanie wkrótce usunięte.'});

Future<App> _open(WidgetTester tester, FakeAdapter adapter, {List<Uri>? openedUrls}) async {
  final app = await pumpApp(tester, adapter, session: signedInSession, openedUrls: openedUrls);
  await openTab(tester, 'Account');
  await tapVisible(tester, find.widgetWithText(GroupRow, 'Delete account'));
  return app;
}

final _delete = find.widgetWithText(FilledButton, 'Delete account');

/// The button of the password dialog.
final _confirm = find.descendant(of: find.byType(AlertDialog), matching: find.widgetWithText(FilledButton, 'Delete'));

void main() {
  testWidgets('says what goes with the account before anything is asked of the server', (tester) async {
    final adapter = _adapter();
    await _open(tester, adapter);

    expect(find.text('Delete your account?'), findsOneWidget);
    expect(find.text('Your eKP account goes too'), findsOneWidget);
    expect(find.text('Tickets and invoices are lost'), findsOneWidget);
    expect(find.text('Plastic cards need an eKP account'), findsOneWidget);
    expect(adapter.requestsTo(_cards), isEmpty);
  });

  testWidgets('with a card still attached the way leads to the website, not to a deletion', (tester) async {
    final opened = <Uri>[];
    final adapter = _adapter(cards: 1);
    final app = await _open(tester, adapter, openedUrls: opened);

    await tapVisible(tester, _delete);
    expect(find.text('Detach your cards first'), findsOneWidget);
    expect(find.text('Enter your password'), findsNothing);

    await tester.tap(find.widgetWithText(FilledButton, 'Open eKP website'));
    await tester.pumpAndSettle();

    expect(opened.single.host, 'ekp.mpk.krakow.pl');
    expect(adapter.requestsTo(_anonymise), isEmpty);
    expect(app.location, Routes.accountDelete);
  });

  testWidgets('without cards the password deletes the account and ends the session here', (tester) async {
    final adapter = _adapter();
    final app = await _open(tester, adapter);

    await tapVisible(tester, _delete);
    expect(find.text('Enter your password'), findsOneWidget);
    // Nothing to send yet.
    expect(tester.widget<FilledButton>(_confirm).onPressed, isNull);
    await tester.enterText(field('Password'), 'Stare1234');
    await tester.pump();
    await tester.tap(_confirm);
    await tester.pumpAndSettle();

    final sent = adapter.requestTo(_anonymise);
    expect(sent.method, 'PUT');
    expect(sent.data, {'password': 'Stare1234'});
    expect(find.text('Account deleted'), findsOneWidget);
    expect(find.text('Twoje konto zostanie wkrótce usunięte.'), findsOneWidget);
    // Still signed in until the dialog is closed.
    expect(app.location, Routes.accountDelete);

    await tester.tap(find.widgetWithText(FilledButton, 'Sign out'));
    await tester.pumpAndSettle();

    expect(app.location, Routes.login);
    // The server no longer knows the token: it is not asked to end it.
    expect(adapter.requestsTo('/auth/logout'), isEmpty);
  });

  testWidgets('a password the server refuses stays in the dialog, with its reason', (tester) async {
    const reason = 'Nieprawidłowe hasło';
    final adapter = _adapter()..reply('PUT', _anonymise, 400, {'message': reason, 'exceptionCode': 259, 'code': 1});
    final app = await _open(tester, adapter);

    await tapVisible(tester, _delete);
    await tester.enterText(field('Password'), 'zle');
    await tester.pump();
    await tester.tap(_confirm);
    await tester.pumpAndSettle();

    expect(find.text(reason), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    expect(find.text('Account deleted'), findsNothing);
    expect(app.location, Routes.accountDelete);
  });

  testWidgets('cancelling the password deletes nothing', (tester) async {
    final adapter = _adapter();
    final app = await _open(tester, adapter);

    await tapVisible(tester, _delete);
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(adapter.requestsTo(_anonymise), isEmpty);
    expect(app.location, Routes.accountDelete);
  });

  testWidgets('offline, nothing can be deleted', (tester) async {
    final adapter = _adapter()..fail('GET', '/service-status');
    await _open(tester, adapter);

    expect(tester.widget<FilledButton>(_delete).onPressed, isNull);
  });
}
