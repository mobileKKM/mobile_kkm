import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// The display for a screen that is there to be scanned: at full brightness
/// and kept awake, through the `screen_brightness` and `wakelock_plus`
/// plugins.
///
/// Only this app's brightness, not the system setting: on Android an
/// attribute of the window, which needs no permission and only counts while
/// the app is in front; on iOS the plugin gives the user's own level back
/// while the app is in the background. Staying awake needs no permission
/// either.
class ScanDisplay {
  const ScanDisplay();

  /// Bright and awake while [active], the user's own brightness and the
  /// system's timeout otherwise.
  Future<void> setActive(bool active) async {
    final brightness = ScreenBrightness.instance;
    try {
      if (active) {
        await brightness.setApplicationScreenBrightness(1);
      } else {
        await brightness.resetApplicationScreenBrightness();
      }
    } catch (_) {
      // Without the plugin (or on a platform it does not know) the screen
      // stays usable, only no brighter.
    }
    // On its own: one plugin failing must not leave the other one out.
    try {
      await WakelockPlus.toggle(enable: active);
    } catch (_) {
      // As above: the display then times out as usual.
    }
  }
}
