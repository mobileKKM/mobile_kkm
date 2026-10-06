import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';

/// How much a state should stand out.
enum StatusTone { positive, neutral, warning }

/// A short state label on a tinted background.
class StatusChip extends StatelessWidget {
  const StatusChip(this.label, {super.key, this.tone = StatusTone.neutral});

  final String label;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = AppColors.of(context);
    final (background, foreground) = switch (tone) {
      StatusTone.positive => (colors.successContainer, colors.onSuccessContainer),
      StatusTone.warning => (scheme.tertiaryContainer, scheme.onTertiaryContainer),
      StatusTone.neutral => (scheme.surfaceContainerHighest, scheme.onSurfaceVariant),
    };
    return DecoratedBox(
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: foreground)),
      ),
    );
  }
}
