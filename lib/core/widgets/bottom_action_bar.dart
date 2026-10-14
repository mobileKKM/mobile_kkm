import 'package:material_ui/material_ui.dart';

/// A button pinned to the bottom of a screen, 12 dp above and 12 dp below it
/// as in the design, the system's navigation bar (gestures or three buttons
/// alike) under that: the inset is added to the gap, not compared with it, as
/// `SafeArea.minimum` would.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key, required this.child, this.topPadding = 12, this.maxWidth});

  final Widget child;

  /// The space between what is above and the button.
  final double topPadding;

  /// Keeps the button from stretching across a wide screen.
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    Widget button = SizedBox(width: double.infinity, child: child);
    final maxWidth = this.maxWidth;
    if (maxWidth != null) {
      button = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: button,
      );
    }
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, topPadding, 16, 12),
        child: Center(child: button),
      ),
    );
  }
}
