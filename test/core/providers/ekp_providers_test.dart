import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';

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
}
