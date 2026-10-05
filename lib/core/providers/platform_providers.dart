import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/platform/link_settings.dart';
import 'package:mobile_kkm/core/platform/url_opener.dart';
import 'package:url_launcher/url_launcher.dart';

final linkSettingsProvider = Provider<LinkSettings>((ref) => const LinkSettings());

/// Opens a web page in the system browser. A provider so tests can capture
/// the URL instead of launching anything.
final urlOpenerProvider = Provider<UrlOpener>(
  (ref) =>
      (url) => launchUrl(url, mode: LaunchMode.externalApplication),
);
