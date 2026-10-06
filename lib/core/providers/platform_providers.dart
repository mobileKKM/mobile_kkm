import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/platform/link_settings.dart';
import 'package:mobile_kkm/core/platform/location_service.dart';
import 'package:mobile_kkm/core/platform/url_opener.dart';
import 'package:mobile_kkm/features/account/services/photo_cache.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final linkSettingsProvider = Provider<LinkSettings>((ref) => const LinkSettings());

/// The device's position and the permission for it. A provider so tests need
/// neither.
final locationServiceProvider = Provider<LocationService>((ref) => const LocationService());

/// Opens a web page in the system browser. A provider so tests can capture
/// the URL instead of launching anything.
final urlOpenerProvider = Provider<UrlOpener>(
  (ref) =>
      (url) => launchUrl(url, mode: LaunchMode.externalApplication),
);

/// The installed app's version as `1.2.3 (45)`.
final appVersionProvider = FutureProvider<String>((ref) async {
  final info = await PackageInfo.fromPlatform();
  return '${info.version} (${info.buildNumber})';
});

/// The profile photo, from the network and kept on disk. A provider so tests
/// need neither.
final photoCacheProvider = Provider<PhotoCache>((ref) => const NetworkPhotoCache());
