import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Host of the activation / password reset links in the EKP e-mails.
const ekpLinkHost = 'ekp.mpk.krakow.pl';

/// Android's per-app "Open supported links" setting for [ekpLinkHost].
///
/// The app cannot verify that domain, so on Android 12+ the user has to
/// enable link handling once. Not applicable on iOS, where such links
/// always open in the browser.
class LinkSettings {
  const LinkSettings();

  static const _channel = MethodChannel('de.codebucket.mobile_kkm/links');

  bool get isSupported => defaultTargetPlatform == TargetPlatform.android;

  Future<bool> canOpenLinks() async {
    if (!isSupported) return false;
    try {
      return await _channel.invokeMethod<bool>('canOpenLinks', ekpLinkHost) ??
          false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  Future<void> openSettings() async {
    if (!isSupported) return;
    await _channel.invokeMethod<void>('openLinkSettings');
  }
}
