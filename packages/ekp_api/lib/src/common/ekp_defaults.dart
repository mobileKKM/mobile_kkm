/// Default values observed from the official Android client (v1.6.10).
abstract final class EkpDefaults {
  EkpDefaults._();

  static const String baseUrl = 'https://api.ekp.mpk.krakow.pl';

  /// Client version sent in `x-client-version`. The official app is a
  /// first-party client of the same backend; we mimic it to receive the same
  /// behaviour. The server also exposes a `minAppVersion` gate via
  /// `client/mobile-app/config`.
  static const String clientVersion = '1.6.10';

  /// User-Agent of the official Android client (its HTTP stack is okhttp).
  /// dart:io would otherwise announce `Dart/x.y (dart:io)` — an instant
  /// non-official-client fingerprint.
  static const String userAgent = 'okhttp/4.12.0';
}
