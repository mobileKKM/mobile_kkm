import 'package:dio/dio.dart';
import 'package:ekp_api/ekp_api.dart';
import 'package:ekp_crypto/ekp_crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/crypto/aztec_key_relay.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/aztec_key_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';

import '../../support/fake_adapter.dart';
import '../../support/harness.dart';
import '../../support/sample_data.dart';

void main() {
  test('a changed device identity rebuilds the client with it', () async {
    final container = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
        deviceIdentityProvider.overrideWith(
          () => DeviceIdentityController(
            const EkpDeviceIdentity(deviceId: 'aaaaaaaaaaaaaaaa', platform: 'android 34', deviceName: 'First Phone'),
            hardwareName: 'First Phone',
            save: ({required deviceId, required deviceName}) async {},
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final before = container.read(ekpClientProvider);
    expect(before.device.deviceId, 'aaaaaaaaaaaaaaaa');

    await container
        .read(deviceIdentityProvider.notifier)
        .change(deviceId: 'bbbbbbbbbbbbbbbb', deviceName: 'Second Phone');

    final after = container.read(ekpClientProvider);
    expect(after, isNot(same(before)));
    expect(after.device.deviceId, 'bbbbbbbbbbbbbbbb');
    expect(after.device.deviceName, 'Second Phone');
    expect(after.device.platform, 'android 34');

    // Saved as it is: nothing to rebuild for.
    await container
        .read(deviceIdentityProvider.notifier)
        .change(deviceId: 'bbbbbbbbbbbbbbbb', deviceName: 'Second Phone');
    expect(container.read(ekpClientProvider), same(after));
  });

  test('the client encrypts with the key in use, without being rebuilt for a new one', () async {
    final relay = FakeAdapter();
    final container = ProviderContainer(
      overrides: [
        tokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
        deviceIdentityProvider.overrideWith(
          () => DeviceIdentityController(
            EkpDeviceIdentity.test(),
            hardwareName: 'First Phone',
            save: ({required deviceId, required deviceName}) async {},
          ),
        ),
        appStartupProvider.overrideWith((ref) async {}),
        aztecKeyStoreProvider.overrideWithValue(InMemoryAztecKeyStore()),
        aztecKeyRelayProvider.overrideWithValue(
          AztecKeyRelay(
            Dio(BaseOptions(baseUrl: 'https://relay.test/api/v1/'))..httpClientAdapter = relay,
            userAgent: 'mobileKKM/1.2.3',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    final client = container.read(ekpClientProvider);
    expect(client.aztecKey!(), aztecKeyPem);

    relay.reply('GET', 'aztec-key', 200, relayKeyJson(rotatedAztecKeyPem));
    expect(await container.read(aztecKeyProvider.notifier).reload(), isTrue);

    expect(container.read(ekpClientProvider), same(client));
    expect(client.aztecKey!(), rotatedAztecKeyPem);
  });
}
