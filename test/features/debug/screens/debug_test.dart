import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/router/routes.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';
import '../../../support/sample_data.dart';

Future<App> _openDebug(WidgetTester tester) async {
  final adapter = FakeAdapter()
    ..reply('GET', '/account/user-data', 200, userDataJson())
    ..reply('GET', '/client/mobile-app/config', 200, appConfigJson);
  final app = await pumpApp(tester, adapter, session: signedInSession);
  unawaited(app.router.push(Routes.debug));
  await tester.pumpAndSettle();
  return app;
}

String _text(WidgetTester tester, String label) => tester.widget<TextFormField>(field(label)).controller!.text;

void main() {
  testWidgets('the fields show the identity in use', (tester) async {
    final app = await _openDebug(tester);

    expect(_text(tester, 'Device ID'), app.client.device.deviceId);
    expect(_text(tester, 'Device name'), app.client.device.deviceName);
  });

  testWidgets('saving changes the identity and stores it', (tester) async {
    final app = await _openDebug(tester);

    await tester.enterText(field('Device ID'), '0123456789abcdef');
    await tester.enterText(field('Device name'), 'Other Phone');
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Save'));

    final device = app.container.read(deviceIdentityProvider);
    expect(device.deviceId, '0123456789abcdef');
    expect(device.deviceName, 'Other Phone');
    expect(device.platform, app.client.device.platform);
    expect(app.savedIdentities, [(deviceId: '0123456789abcdef', deviceName: 'Other Phone')]);
  });

  testWidgets('an empty name brings the hardware name back', (tester) async {
    final app = await _openDebug(tester);

    await tester.enterText(field('Device name'), ' ');
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Save'));

    expect(app.container.read(deviceIdentityProvider).deviceName, testHardwareName);
    expect(app.savedIdentities.single.deviceName, isNull);
  });

  testWidgets('an ID of another length is refused', (tester) async {
    final app = await _openDebug(tester);

    await tester.enterText(field('Device ID'), '0123456789abcde');
    await tapVisible(tester, find.widgetWithText(FilledButton, 'Save'));

    expect(find.text('Must be 16 characters'), findsOneWidget);
    expect(app.savedIdentities, isEmpty);
    expect(app.container.read(deviceIdentityProvider).deviceId, app.client.device.deviceId);
  });

  testWidgets('a new ID can be generated', (tester) async {
    final app = await _openDebug(tester);

    await tester.tap(find.byTooltip('Generate'));
    await tester.pump();

    final generated = _text(tester, 'Device ID');
    expect(generated, matches(RegExp(r'^[0-9a-f]{16}$')));
    expect(generated, isNot(app.client.device.deviceId));
    // Nothing changes before it is saved.
    expect(app.savedIdentities, isEmpty);
  });

  testWidgets('the switch turns the screen security off and on', (tester) async {
    final app = await _openDebug(tester);
    expect(app.container.read(screenSecurityEnabledProvider), isTrue);

    await tapVisible(tester, find.byType(Switch));
    expect(app.container.read(screenSecurityEnabledProvider), isFalse);

    await tapVisible(tester, find.text('Screen security'));
    expect(app.container.read(screenSecurityEnabledProvider), isTrue);
  });

  testWidgets('the key for the ticket code says where it is from, and the relay can be asked again', (tester) async {
    final app = await _openDebug(tester);
    expect(find.text('The one built into the app. Tap to ask the relay.'), findsOneWidget);

    await tapVisible(tester, find.text('Ticket code key'));
    expect(find.text('The relay did not answer with a key.'), findsOneWidget);

    app.relay.reply(
      'GET',
      'aztec-key',
      200,
      relayKeyJson(rotatedAztecKeyPem, version: 7, fingerprint: '0123456789abcdef'),
    );
    await tapVisible(tester, find.text('Ticket code key'));
    expect(find.text('From the relay: version 7, 01234567. Tap to ask again.'), findsOneWidget);
  });
}
