import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/platform/link_settings.dart';
import 'package:mobile_kkm/core/platform/location_service.dart';
import 'package:mobile_kkm/core/platform/payment_browser.dart';
import 'package:mobile_kkm/core/platform/photo_picker.dart';
import 'package:mobile_kkm/core/platform/scan_display.dart';
import 'package:mobile_kkm/core/platform/screen_security.dart';
import 'package:mobile_kkm/core/platform/url_opener.dart';
import 'package:mobile_kkm/features/account/services/photo_cache.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final linkSettingsProvider = Provider<LinkSettings>((ref) => const LinkSettings());

/// The device's position and the permission for it. A provider so tests need
/// neither.
final locationServiceProvider = Provider<LocationService>((ref) => const LocationService());

/// Whether the ticket code is protected at all. Only the debug menu turns it
/// off, and only until the app is closed: it is not stored.
class ScreenSecurityEnabled extends Notifier<bool> {
  @override
  bool build() => true;

  void set(bool enabled) => state = enabled;
}

final screenSecurityEnabledProvider = NotifierProvider<ScreenSecurityEnabled, bool>(ScreenSecurityEnabled.new);

/// Screenshot and recording protection for the ticket code. A provider so
/// tests can see it switched on and off, and so the debug menu can put one
/// that does nothing in its place.
final screenSecurityProvider = Provider<ScreenSecurity>(
  (ref) => ref.watch(screenSecurityEnabledProvider) ? const ScreenSecurity() : const NoScreenSecurity(),
);

/// A bright display that stays awake for the ticket code. A provider so
/// tests can see it switched on and off.
final scanDisplayProvider = Provider<ScanDisplay>((ref) => const ScanDisplay());

/// tPay's payment page in the in-app browser. A provider so tests can
/// play its return link or its closing.
final paymentBrowserProvider = Provider<PaymentBrowser>((ref) => PaymentBrowser());

/// Opens a web page in the system browser. A provider so tests can capture
/// the URL instead of launching anything.
final urlOpenerProvider = Provider<UrlOpener>(
  (ref) =>
      (url) => launchUrl(url, mode: LaunchMode.externalApplication),
);

/// What the platform knows of the installed app, resolved in `main()` for
/// whatever needs the version without waiting for it.
final packageInfoProvider = Provider<PackageInfo>((ref) => throw UnimplementedError('overridden in main()'));

/// The installed app's version as `1.2.3 (45)`.
final appVersionProvider = FutureProvider<String>((ref) async {
  final info = await PackageInfo.fromPlatform();
  return '${info.version} (${info.buildNumber})';
});

/// The profile photo, from the network and kept on disk. A provider so tests
/// need neither.
final photoCacheProvider = Provider<PhotoCache>((ref) => const NetworkPhotoCache());

/// The camera and the gallery, for the photo on the mKKM card. A provider so
/// tests can hand over a picture of their own.
final photoPickerProvider = Provider<PhotoPicker>((ref) => const PhotoPicker());
