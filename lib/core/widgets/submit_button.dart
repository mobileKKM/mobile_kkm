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
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;

  /// What the button says while [loading]; [label] unless given.
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (loading) {
      // Still in its own colours, only dimmed: it is at work, not unavailable.
      return FilledButton.icon(
        style: FilledButton.styleFrom(
          disabledBackgroundColor: scheme.primary.withValues(alpha: 0.72),
          disabledForegroundColor: scheme.onPrimary,
        ),
        onPressed: null,
        icon: SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(strokeWidth: 2.5, color: scheme.onPrimary),
        ),
        label: Text(loadingLabel ?? label),
      );
    }
    return icon == null
        ? FilledButton(onPressed: onPressed, child: Text(label))
        : FilledButton.icon(onPressed: onPressed, icon: Icon(icon), label: Text(label));
  }
}
