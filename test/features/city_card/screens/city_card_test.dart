import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_area.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_ring.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_state.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

const _userData = '/account/user-data';
const _status = '/account/inhabitant-status';
const _contract = '/account/inhabitant-contract';
const _code = Key('status-code');

/// A code as the server sends it: a picture, and the moment it runs out.
Map<String, dynamic> _contractJson({Duration? life}) => {
  'expirationDate': life == null ? null : clock.now().add(life).millisecondsSinceEpoch,
  'contract': base64Encode(onePixelPng),
  'code': null,
  'message': null,
};

FakeAdapter _adapter({bool? resident = true, String? until}) => FakeAdapter()
  ..reply(
    'GET',
    _userData,
    200,
    until == null ? userDataJson(resident: resident) : userDataJson(resident: resident, residentUntil: until),
  );

Future<App> _open(WidgetTester tester, FakeAdapter adapter, {List<Uri>? openedUrls, UserDataResponse? stored}) async {
  final app = await pumpApp(
    tester,
    adapter,
    session: signedInSession,
    openedUrls: openedUrls,
    userDataCache: stored == null ? null : InMemoryUserDataCache(stored),
  );
  await openTab(tester, 'Account');
  await tapVisible(tester, find.widgetWithText(GroupRow, 'Karta Krakowska'));
  return app;
}

Future<App> _openCode(WidgetTester tester, FakeAdapter adapter) async {
  final app = await _open(tester, adapter);
  await tester.tap(find.widgetWithText(FilledButton, 'Show status code'));
  await pumpWithCode(tester);
  return app;
}

CodeState _state(WidgetTester tester) => tester.widget<CodeArea>(find.byType(CodeArea)).state;

void main() {
  group('the status', () {
    testWidgets('an active one says from when until when, and offers its code', (tester) async {
      final adapter = _adapter();
      final app = await _open(tester, adapter);

      expect(app.location, Routes.cityCard);
      expect(find.text('Jan Testowy'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Active from'), findsOneWidget);
      expect(find.text('Jan 1, 2026'), findsOneWidget);
      expect(find.text('Active until'), findsOneWidget);
      expect(find.text('Dec 31, 2026'), findsOneWidget);
      expect(find.text('Customer number'), findsOneWidget);
      expect(find.text('100001'), findsOneWidget);
      expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Show status code')).onPressed, isNotNull);
      // It is what the user data says: asked for again, and nothing else.
      expect(adapter.requestsTo(_userData), hasLength(2));
      expect(adapter.requestsTo(_status), isEmpty);
      expect(adapter.requestsTo(_contract), isEmpty);
    });

    testWidgets('the dates are shown as sent, never judged: the server says whether it is active', (tester) async {
      await _open(tester, _adapter(until: '2020-12-31T11:00:00Z'));

      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Dec 31, 2020'), findsOneWidget);
      expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Show status code')).onPressed, isNotNull);
    });

    for (final resident in [false, null]) {
      testWidgets('without one ($resident) there is only where to get it', (tester) async {
        final opened = <Uri>[];
        await _open(tester, _adapter(resident: resident), openedUrls: opened);

        expect(find.text('You don’t have Karta Krakowska status on your mKKM card.'), findsOneWidget);
        expect(find.text('Jan Testowy'), findsOneWidget);
        // Neither the dates the server still sends, nor a way to a code.
        expect(find.text('Active from'), findsNothing);
        expect(find.text('100001'), findsNothing);
        expect(find.text('Show status code'), findsNothing);

        await tester.tap(find.text('How to get Karta Krakowska'));
        await tester.pumpAndSettle();
        expect(opened, [Uri.parse('https://kk.krakow.pl/jak-wyrobic-karte-krakowska')]);
      });
    }

    testWidgets('pulling down asks for the user data again', (tester) async {
      final adapter = _adapter();
      await _open(tester, adapter);
      adapter.reply('GET', _userData, 200, userDataJson(resident: false));

      await tester.fling(find.byType(Scrollable).last, const Offset(0, 400), 1000);
      await tester.pumpAndSettle();

      expect(find.text('Active from'), findsNothing);
      expect(find.text('You don’t have Karta Krakowska status on your mKKM card.'), findsOneWidget);
    });

    testWidgets('offline it is the stored status, and the code has to wait', (tester) async {
      final adapter = FakeAdapter()..fail('GET', _userData);
      final app = await _open(tester, adapter, stored: UserDataResponse.fromJson(userDataJson()));

      // The request that got no answer is how the app found out.
      expect(app.container.read(appStatusProvider).mode, AppMode.offline);
      expect(find.text('You’re offline. Showing saved data.'), findsOneWidget);
      expect(find.text('Dec 31, 2026'), findsOneWidget);
      expect(find.text('The status code needs a connection.'), findsOneWidget);
      expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Show status code')).onPressed, isNull);

      adapter
        ..reply('GET', _userData, 200, userDataJson())
        ..reply('GET', '/service-status', 200, {'isAvailable': true});
      await tester.fling(find.byType(Scrollable).last, const Offset(0, 400), 1000);
      await tester.pumpAndSettle();

      expect(find.text('The status code needs a connection.'), findsNothing);
      expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Show status code')).onPressed, isNotNull);
    });
  });

  group('the status code', () {
    testWidgets('shows whose it is and the code the server drew', (tester) async {
      final adapter = _adapter()..reply('GET', _contract, 200, _contractJson());
      final app = await _openCode(tester, adapter);

      expect(app.location, Routes.cityCardCode);
      expect(find.byKey(_code), findsOneWidget);
      expect(find.text('Jan Testowy'), findsOneWidget);
      expect(find.text('Customer number'), findsOneWidget);
      expect(find.text('100001'), findsOneWidget);
      expect(find.text('Tap the code to enlarge it'), findsOneWidget);
      expect(tester.getSize(find.byKey(const Key('code-photo'))), const Size(128, 128));
      // No date from the server: what it gives a code.
      expect((_state(tester) as CodeRunning).time, '5:00');
      expect(adapter.requestsTo(_contract), hasLength(1));
      // Asked for without a check of the status first.
      expect(adapter.requestsTo(_status), isEmpty);
    });

    testWidgets('is good until the moment the server names, then the screen closes', (tester) async {
      final adapter = _adapter();
      final app = await _open(tester, adapter);
      // The moment counted from here: the start-up takes seconds of the
      // test's clock too.
      adapter.reply('GET', _contract, 200, _contractJson(life: const Duration(seconds: 40)));
      await tester.tap(find.widgetWithText(FilledButton, 'Show status code'));
      await pumpWithCode(tester);
      final scheme = Theme.of(tester.element(find.byType(CodeArea))).colorScheme;
      CodeRing ring() => tester.widget<CodeRing>(find.byType(CodeRing));
      expect((_state(tester) as CodeRunning).time, '0:40');
      expect(ring().left, 1);
      expect(ring().color, scheme.primary);

      await tester.pump(const Duration(seconds: 25));
      expect(ring().left, closeTo(15 / 40, 0.001));
      expect(ring().color, scheme.error);

      await tester.pump(const Duration(seconds: 15));
      await pumpWithCode(tester);
      expect(app.location, Routes.cityCard);
      // No next code by itself: the button asks for a fresh one.
      expect(adapter.requestsTo(_contract), hasLength(1));

      await tester.tap(find.widgetWithText(FilledButton, 'Show status code'));
      await pumpWithCode(tester);
      expect(find.byKey(_code), findsOneWidget);
      expect(adapter.requestsTo(_contract), hasLength(2));
    });

    testWidgets('a moment further off than a code lasts is the device clock’s doing', (tester) async {
      final adapter = _adapter()..reply('GET', _contract, 200, _contractJson(life: const Duration(hours: 2)));
      await _openCode(tester, adapter);

      expect((_state(tester) as CodeRunning).time, '5:00');
    });

    testWidgets('a tap enlarges it, and the end of its time closes both', (tester) async {
      final adapter = _adapter()..reply('GET', _contract, 200, _contractJson(life: const Duration(seconds: 40)));
      final app = await _openCode(tester, adapter);

      await tester.tap(find.byKey(_code));
      await pumpWithCode(tester);
      expect(find.text('Tap anywhere to close'), findsOneWidget);
      expect(find.text('Customer number 100001'), findsOneWidget);

      await tester.tap(find.text('Tap anywhere to close'));
      await pumpWithCode(tester);
      expect(find.text('Tap anywhere to close'), findsNothing);
      expect(app.location, Routes.cityCardCode);

      await tester.tap(find.byKey(_code));
      await pumpWithCode(tester);
      await tester.pump(const Duration(seconds: 40));
      await pumpWithCode(tester);
      expect(find.text('Tap anywhere to close'), findsNothing);
      expect(app.location, Routes.cityCard);
      expect(adapter.requestsTo(_contract), hasLength(1));
    });

    testWidgets('the server says why there is no code, in a reply', (tester) async {
      final adapter = _adapter()
        ..reply('GET', _contract, 200, {'code': 4, 'message': 'Brak aktywnego statusu mieszkańca.'});
      final app = await _openCode(tester, adapter);

      expect(find.text('Brak aktywnego statusu mieszkańca.'), findsOneWidget);
      expect(find.byKey(_code), findsNothing);
      expect(find.byType(CodeRing), findsNothing);
      expect(find.text('Tap the code to enlarge it'), findsNothing);
      // It stays open, for the reason.
      await tester.pump(const Duration(minutes: 6));
      expect(app.location, Routes.cityCardCode);
    });

    testWidgets('the server says why there is no code, as an error', (tester) async {
      final adapter = _adapter()
        ..reply('GET', _contract, 400, {'code': 4, 'message': 'Brak aktywnego statusu mieszkańca.'});
      await _openCode(tester, adapter);

      expect(find.text('Brak aktywnego statusu mieszkańca.'), findsOneWidget);
    });

    testWidgets('without an answer the app says so, and the code can be asked for again', (tester) async {
      final adapter = _adapter()..fail('GET', _contract);
      final app = await _openCode(tester, adapter);

      expect(find.text('The code could not be loaded. Check your connection and try again.'), findsOneWidget);
      expect(app.container.read(appStatusProvider).mode, AppMode.offline);

      adapter.reply('GET', _contract, 200, _contractJson());
      await tester.tap(find.text('Try again'));
      await pumpWithCode(tester);
      expect(find.byKey(_code), findsOneWidget);
    });

    testWidgets('a reply without a picture is no code', (tester) async {
      final adapter = _adapter()..reply('GET', _contract, 200, {'contract': '', 'expirationDate': null});
      await _openCode(tester, adapter);

      expect(find.text('The code could not be loaded. Check your connection and try again.'), findsOneWidget);
    });

    testWidgets('is kept out of screenshots, on a bright display that stays awake', (tester) async {
      final adapter = _adapter()..reply('GET', _contract, 200, _contractJson());
      final app = await _open(tester, adapter);
      expect(app.screen.changes, isEmpty);
      expect(app.scanDisplay.changes, isEmpty);

      await tester.tap(find.widgetWithText(FilledButton, 'Show status code'));
      await pumpWithCode(tester);
      expect(app.screen.secure, isTrue);
      expect(app.scanDisplay.active, isTrue);

      await tester.tap(find.byTooltip('Close'));
      await pumpWithCode(tester);
      expect(app.location, Routes.cityCard);
      expect(app.screen.changes, [true, false]);
      expect(app.scanDisplay.changes, [true, false]);
    });

    testWidgets('is hidden while the screen is being recorded', (tester) async {
      final adapter = _adapter()..reply('GET', _contract, 200, _contractJson());
      final app = await _openCode(tester, adapter);

      app.screen.capture(true);
      await tester.pump();
      await tester.pump();
      expect(find.byKey(_code), findsNothing);
      expect(find.text('The code is hidden while the screen is recorded or shared.'), findsOneWidget);

      app.screen.capture(false);
      await tester.pump();
      await tester.pump();
      expect(find.byKey(_code), findsOneWidget);
    });
  });
}
