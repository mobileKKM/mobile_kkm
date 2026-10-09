import 'package:flutter/foundation.dart';
import 'package:no_screenshot/no_screenshot.dart';

/// Keeps a screen's content from being copied off the device, through the
/// `no_screenshot` plugin.
///
/// While [setSecure] is on, screenshots and recordings come out empty
/// (`FLAG_SECURE` on Android, a secure layer on iOS) and the app switcher
/// shows the launch screen instead of the content: the plugin's image
/// overlay, `NoScreenshotImage` in the iOS asset catalog and
/// `no_screenshot_image` among the Android drawables, both rendered by
/// `tool/render_branding.sh`.
class ScreenSecurity {
  const ScreenSecurity();

  Future<void> setSecure(bool secure) async {
    final plugin = NoScreenshot.instance;
    try {
      if (secure) {
        // The overlay mode brings the prevention with it.
        await plugin.screenshotWithImage();
      } else {
        // Two claims on the prevention, the overlay's and the plain one:
        // released both, whichever was taken.
        await plugin.overlayOff();
        await plugin.screenshotOn();
      }
    } catch (_) {
      // Without the plugin (or on a platform it does not know) the screen
      // stays usable, only unprotected.
    }
  }

  /// The plugin keeps its state across app starts. Called at start-up, so
  /// that an app killed with the protection on does not come back with every
  /// screen protected.
  Future<void> reset() => setSecure(false);

  /// Whether the screen is being recorded or mirrored: every change while
  /// listened to. Only on iOS, where the prevention is a workaround rather
  /// than a system guarantee and the app hides the content itself as well;
  /// on Android a recording is empty anyway and the user keeps their code.
  Stream<bool> get captured async* {
    if (defaultTargetPlatform != TargetPlatform.iOS) {
      return;
    }
    final plugin = NoScreenshot.instance;
    try {
      await plugin.startScreenRecordingListening();
      yield* plugin.screenshotStream.map((snapshot) => snapshot.isScreenRecording).distinct();
    } catch (_) {
      // Without the plugin there is nothing to tell.
    } finally {
      // Also when the listener goes away.
      try {
        await plugin.stopScreenRecordingListening();
      } catch (_) {
        // As above.
      }
    }
  }
}
