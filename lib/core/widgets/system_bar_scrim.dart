import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

/// For a screen whose content scrolls under the system's navigation bar:
/// lets Android put its translucent scrim behind the three buttons, so that
/// they stay readable over whatever passes below. Gesture navigation gets no
/// scrim, and neither does iOS.
///
/// Not for screens that end in a bar or a button of their own: the scrim
/// would show on those as a band of another colour.
class SystemBarScrim extends StatelessWidget {
  const SystemBarScrim({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final icons = brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    // The app's own style (see `MobileKkmApp`), but for the last line.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: icons,
        statusBarBrightness: brightness,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: icons,
        systemNavigationBarContrastEnforced: true,
      ),
      child: child,
    );
  }
}
