import 'package:material_ui/material_ui.dart';

/// The frame of the signed-out screens besides the sign-in itself: an
/// optional app bar, a scrolling, width-constrained body and an optional
/// action pinned to the bottom.
class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
    this.title,
    this.showAppBar = true,
    this.leading,
    this.centered = false,
    this.bottom,
    required this.child,
  });

  final String? title;

  /// Off for a screen there is no way back from.
  final bool showAppBar;

  /// Instead of the back arrow.
  final Widget? leading;

  /// The body in the middle of the screen while it fits, as on the lead
  /// screens; from the top otherwise.
  final bool centered;

  /// Stays in view under the scrolling body.
  final Widget? bottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    final bottom = this.bottom;
    return Scaffold(
      appBar: showAppBar ? AppBar(title: title == null ? null : Text(title), leading: leading) : null,
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: centered ? Alignment.center : Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, showAppBar ? 4 : 24, 16, 24),
                  child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480), child: child),
                ),
              ),
            ),
            if (bottom != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: SizedBox(width: double.infinity, child: bottom),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
