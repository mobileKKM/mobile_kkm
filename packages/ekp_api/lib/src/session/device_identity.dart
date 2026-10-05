import '../common/ekp_defaults.dart';

/// Device identity sent with every request via `x-*` headers and embedded in
/// login / token recovery bodies. The server remembers the device id bound to
/// a refresh token.
class EkpDeviceIdentity {
  const EkpDeviceIdentity({
    required this.deviceId,
    required this.platform,
    required this.deviceName,
    this.clientVersion = EkpDefaults.clientVersion,
    this.userAgent = EkpDefaults.userAgent,
  });

  /// Stable per-installation identifier (16 hex chars in the official app).
  final String deviceId;

  /// e.g. `android 34`, `ios 18.0.0`.
  final String platform;

  /// Human readable model, e.g. `Pixel 8` or
  /// `unknown Android SDK built for arm64`.
  final String deviceName;

  /// Mimicked official client version (`x-client-version`).
  final String clientVersion;

  /// Mimicked HTTP stack (`user-agent`) — okhttp in the official app.
  final String userAgent;

  /// Placeholder identity for tests — never send to production.
  factory EkpDeviceIdentity.test() =>
      const EkpDeviceIdentity(deviceId: '0000000000000000', platform: 'test', deviceName: 'ekp_api test');
}
