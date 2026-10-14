import 'package:material_ui/material_ui.dart';

/// Primary action button that shows a spinner and blocks taps while
/// [loading].
class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.loadingLabel,
    this.style,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  /// What the button says while [loading]; [label] unless given.
  final String? loadingLabel;

  /// On top of the theme's, e.g. a smaller size.
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (loading) {
      // Still in its own colours, only dimmed: it is at work, not unavailable.
      return FilledButton.icon(
        style: FilledButton.styleFrom(
          disabledBackgroundColor: scheme.primary.withValues(alpha: 0.72),
          disabledForegroundColor: scheme.onPrimary,
        ).merge(style),
        onPressed: null,
        icon: SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2, color: scheme.onPrimary)),
        label: Text(loadingLabel ?? label),
      );
    }
    return icon == null
        ? FilledButton(style: style, onPressed: onPressed, child: Text(label))
        : FilledButton.icon(style: style, onPressed: onPressed, icon: Icon(icon), label: Text(label));
  }
}
