import 'package:ekp_api/ekp_api.dart';
import 'package:ekp_crypto/ekp_crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Writes a changed identity to the device. No [deviceName]: the hardware's.
typedef DeviceIdentitySaver = Future<void> Function({required String deviceId, required String? deviceName});

/// Holds the identity requests go out with: the one resolved in `main()`,
/// until the debug menu changes it.
class DeviceIdentityController extends Notifier<EkpDeviceIdentity> {
  DeviceIdentityController(this._initial, {required this.hardwareName, required this.save});

  /// The length `loadDeviceIdentity` accepts; anything else is replaced at
  /// the next start.
  static const deviceIdLength = 16;

  final EkpDeviceIdentity _initial;
  final DeviceIdentitySaver save;

  /// What the device calls itself, used when no name is set.
  final String hardwareName;

  @override
  EkpDeviceIdentity build() => _initial;

  /// Takes effect at once: the client is rebuilt with the new identity, and
  /// the app goes through the splash again with the stored session. An empty
  /// [deviceName] brings the hardware's back.
  Future<void> change({required String deviceId, required String deviceName}) async {
    final name = deviceName.trim();
    await save(deviceId: deviceId, deviceName: name.isEmpty ? null : name);
    final shown = name.isEmpty ? hardwareName : name;
    if (deviceId == state.deviceId && shown == state.deviceName) {
      return;
    }
    state = EkpDeviceIdentity(
      deviceId: deviceId,
      platform: state.platform,
      deviceName: shown,
      clientVersion: state.clientVersion,
      userAgent: state.userAgent,
    );
  }
}

/// Device identity, resolved in `main()` before the app starts.
final deviceIdentityProvider = NotifierProvider<DeviceIdentityController, EkpDeviceIdentity>(
  () => throw UnimplementedError('overridden in main()'),
);

/// Session persistence, supplied in `main()`.
final tokenStoreProvider = Provider<TokenStore>((ref) => throw UnimplementedError('overridden in main()'));

/// The key the client encrypts the `assign-e` / `contract-e` requests with,
/// as PEM. `AztecKeyController` writes it here.
///
/// A plain holder, not the controller's state: the controller follows the
/// session, which the client below provides, so the client cannot depend on
/// it in turn. And a new key must not rebuild the client, which would send
/// the app through the splash.
class AztecKeyInUse {
  String pem = aztecKeyPem;
}

final aztecKeyInUseProvider = Provider<AztecKeyInUse>((ref) => AztecKeyInUse());

/// The one client for the EKP backend, with its session.
final ekpClientProvider = Provider<EkpClient>((ref) {
  final key = ref.watch(aztecKeyInUseProvider);
  final client = EkpClient(
    device: ref.watch(deviceIdentityProvider),
    tokenStore: ref.watch(tokenStoreProvider),
    // Read on every encrypted request.
    aztecKey: () => key.pem,
  );
  ref.onDispose(client.dispose);
  return client;
});

/// `client/mobile-app/config` — document URLs (regulations etc.).
///
/// Loaded once behind the splash (see `appStartupProvider`) and kept for the
/// whole run; only a failed load is ever repeated.
final mobileAppConfigProvider = FutureProvider<MobileAppConfig>(
  (ref) => ref.watch(ekpClientProvider).misc.mobileAppConfig(),
  retry: (_, _) => null,
);
