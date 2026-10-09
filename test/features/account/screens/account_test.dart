import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/core/widgets/skeleton_box.dart';
import 'package:mobile_kkm/features/account/services/photo_cache.dart';
import 'package:mobile_kkm/features/account/widgets/link_sheet.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

FakeAdapter _adapter({String? photoUrl, bool? resident = true}) => FakeAdapter()
  ..reply('GET', '/account/user-data', 200, userDataJson(photoUrl: photoUrl, resident: resident))
  ..reply('GET', '/client/mobile-app/config', 200, appConfigJson);

Future<App> _openAccount(
  WidgetTester tester,
  FakeAdapter adapter, {
  List<Uri>? openedUrls,
  PhotoCache? photoCache,
}) async {
  final app = await pumpApp(tester, adapter, session: signedInSession, openedUrls: openedUrls, photoCache: photoCache);
  await openTab(tester, 'Account');
  return app;
}

/// Opens the sheet behind [row] and taps [entry] in it.
Future<void> _follow(WidgetTester tester, String row, String entry) async {
  await tapVisible(tester, find.widgetWithText(GroupRow, row));
  await tester.tap(find.text(entry));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the header shows who is signed in', (tester) async {
    await _openAccount(tester, _adapter());

    expect(find.text('Jan Testowy'), findsOneWidget);
    expect(find.text('Customer code 100001', findRichText: true), findsOneWidget);
    expect(find.widgetWithText(CircleAvatar, 'JT'), findsOneWidget);
  });

  testWidgets('the header waits for the user data instead of guessing', (tester) async {
    final adapter = _adapter();
    final release = adapter.hold('GET', '/account/user-data');
    await pumpApp(tester, adapter, session: signedInSession);
    await openTab(tester, 'Account');

    expect(find.text('Jan Testowy'), findsNothing);
    expect(find.byType(SkeletonBox), findsNWidgets(2));

    release();
    await tester.pumpAndSettle();
    expect(find.text('Jan Testowy'), findsOneWidget);
    expect(find.byType(SkeletonBox), findsNothing);
  });

  testWidgets('the photo comes from the photo cache, not through the API client', (tester) async {
    const url = 'https://ekp.test/photo.jpg?preset=preview';
    final adapter = _adapter(photoUrl: url);
    final photos = FakePhotoCache();
    await _openAccount(tester, adapter, photoCache: photos);

    expect(photos.requested.toSet(), {url});
    expect(tester.widget<CircleAvatar>(find.byType(CircleAvatar)).foregroundImage, isNotNull);
    expect(adapter.requests.where((request) => request.path.contains('photo')), isEmpty);
  });

  testWidgets('without a photo the avatar is the initials alone', (tester) async {
    final photos = FakePhotoCache();
    await _openAccount(tester, _adapter(), photoCache: photos);

    expect(photos.requested, isEmpty);
    expect(tester.widget<CircleAvatar>(find.byType(CircleAvatar)).foregroundImage, isNull);
  });

  group('Karta Krakowska', () {
    for (final (resident, shown, hidden) in [
      (true, ['Active'], ['Inactive']),
      (false, ['Inactive'], ['Active']),
      (null, <String>[], ['Active', 'Inactive']),
    ]) {
      testWidgets('with the inhabitant privilege $resident', (tester) async {
        await _openAccount(tester, _adapter(resident: resident));

        final row = find.widgetWithText(GroupRow, 'Karta Krakowska');
        for (final label in shown) {
          expect(find.descendant(of: row, matching: find.text(label)), findsOneWidget);
        }
        for (final label in hidden) {
          expect(find.descendant(of: row, matching: find.text(label)), findsNothing);
        }
      });
    }
  });

  testWidgets('the sections are My account, Help and Security', (tester) async {
    await _openAccount(tester, _adapter());

    for (final title in ['My account', 'Help', 'Security']) {
      expect(find.text(title), findsOneWidget);
    }
    expect(find.widgetWithText(AppBar, 'Account'), findsOneWidget);
  });

  testWidgets('a sheet covers the navigation bar', (tester) async {
    await _openAccount(tester, _adapter());
    await tapVisible(tester, find.widgetWithText(GroupRow, 'Contact MPK Kraków'));

    final sheet = tester.getRect(find.byType(BottomSheet));
    final bar = tester.getRect(find.byType(NavigationBar));
    expect(sheet.bottom, bar.bottom);
    // The bar is behind the sheet's barrier: tapping it closes the sheet
    // instead of switching sections.
    await tester.tapAt(bar.center.translate(0, -sheet.height));
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheet), findsNothing);
  });

  testWidgets('the help rows say what they are for', (tester) async {
    await _openAccount(tester, _adapter());

    expect(find.text('Terms, purchases, 5+1'), findsOneWidget);
    expect(find.text('Tickets, payments, Karta Krakowska'), findsOneWidget);
    expect(find.text('Bugs and suggestions about the app'), findsOneWidget);
  });

  testWidgets('deleting the account is set apart: no chevron', (tester) async {
    await _openAccount(tester, _adapter());

    Finder chevronIn(String row) =>
        find.descendant(of: find.widgetWithText(GroupRow, row), matching: find.byIcon(Symbols.chevron_right_rounded));
    expect(chevronIn('Change password'), findsOneWidget);
    expect(chevronIn('Delete account'), findsNothing);
    // And the one row in the error colour.
    final scheme = Theme.of(tester.element(find.text('Delete account'))).colorScheme;
    expect(tester.widget<Text>(find.text('Delete account')).style?.color, scheme.error);
    expect(tester.widget<Text>(find.text('Change password')).style?.color, isNot(scheme.error));
  });

  testWidgets('Regulations lists the three regulations from the app config', (tester) async {
    final opened = <Uri>[];
    await _openAccount(tester, _adapter(), openedUrls: opened);

    await tapVisible(tester, find.widgetWithText(GroupRow, 'Regulations'));
    expect(find.byType(LinkTile), findsNWidgets(3));
    await tester.tap(find.text('EKP account regulations'));
    await tester.pumpAndSettle();
    await _follow(tester, 'Regulations', 'Online ticket sales regulations');
    await _follow(tester, 'Regulations', 'Half-year ticket regulations');

    expect(opened.map((url) => url.toString()), [
      'https://ekp.test/documents/Regulamin%20konta.pdf',
      'https://ekp.test/documents/Regulamin%20sprzedazy.pdf',
      'https://ekp.test/documents/Regulamin%20polroczny.pdf',
    ]);
  });

  testWidgets('Regulations can be retried when the config did not load', (tester) async {
    final adapter = FakeAdapter()..fail('GET', '/client/mobile-app/config');
    await _openAccount(tester, adapter);
    await tapVisible(tester, find.widgetWithText(GroupRow, 'Regulations'));
    expect(find.textContaining('The regulations could not be loaded.'), findsOneWidget);

    adapter.reply('GET', '/client/mobile-app/config', 200, appConfigJson);
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(find.text('EKP account regulations'), findsOneWidget);
  });

  testWidgets('the contact rows lead to MPK and to the developer', (tester) async {
    final opened = <Uri>[];
    await _openAccount(tester, _adapter(), openedUrls: opened);

    await tapVisible(tester, find.widgetWithText(GroupRow, 'Contact MPK Kraków'));
    expect(find.text('12 19 150'), findsOneWidget);
    expect(find.text('ekp@mpk.krakow.pl'), findsOneWidget);
    await tester.tap(find.text('Call the helpline'));
    await tester.pumpAndSettle();
    await _follow(tester, 'Contact MPK Kraków', 'Send an e-mail');
    await _follow(tester, 'Contact app developer', 'Report an issue on GitHub');
    await _follow(tester, 'Contact app developer', 'Send an e-mail');

    expect(opened.map((url) => url.toString()), [
      'tel:+481219150',
      'mailto:ekp@mpk.krakow.pl',
      'https://github.com/mobileKKM/mobile_kkm/issues',
      'mailto:mobilekkm@codebucket.de',
    ]);
  });

  for (final (row, location) in [
    ('Edit account', '/account/edit'),
    ('Karta Krakowska', '/karta-krakowska'),
    ('Change password', '/account/change-password'),
    ('Delete account', '/account/delete'),
  ]) {
    testWidgets('$row is announced as coming soon', (tester) async {
      final app = await _openAccount(tester, _adapter());

      await tapVisible(tester, find.widgetWithText(GroupRow, row));

      expect(app.location, location);
      expect(find.text('Coming soon'), findsOneWidget);
    });
  }

  group('signing out', () {
    testWidgets('asks first and can be cancelled', (tester) async {
      final adapter = _adapter()..reply('POST', '/auth/logout', 200);
      final app = await _openAccount(tester, adapter);

      await tapVisible(tester, find.widgetWithText(OutlinedButton, 'Sign out'));
      expect(find.text('Sign out?'), findsOneWidget);
      expect(
        find.text('Tickets assigned to this device will be available again after you sign back in.'),
        findsOneWidget,
      );

      await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
      expect(app.location, '/account');
      expect(adapter.requestsTo('/auth/logout'), isEmpty);
    });

    testWidgets('happens once confirmed', (tester) async {
      final adapter = _adapter()..reply('POST', '/auth/logout', 200);
      final app = await pumpApp(tester, adapter, session: signedInSession);

      await signOut(tester);

      expect(adapter.requestsTo('/auth/logout'), hasLength(1));
      expect(app.location, '/login');
    });
  });

  testWidgets('the app version is at the bottom', (tester) async {
    await _openAccount(tester, _adapter());
    // With the official client's version, which the app speaks to the server as.
    expect(find.text('Version 1.2.3 (45) · eKP API ${EkpDefaults.clientVersion}'), findsOneWidget);
  });
}
