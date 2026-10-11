import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Where the user is in the set-up: one bar per step, filled up to this
/// one, and the step in words.
class StepBar extends StatelessWidget {
  const StepBar({super.key, required this.step, this.of = 2, required this.name});

  /// Counted from 1.
  final int step;
  final int of;

  /// What this step is about.
  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          ExcludeSemantics(
            child: Row(
              spacing: 6,
              children: [
                for (var i = 1; i <= of; i++)
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: i <= step ? scheme.primary : scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // One line, as designed; only the translations are apart.
          Text(
            '${AppLocalizations.of(context).cardSetupStep(step, of)} · $name',
            style: theme.textTheme.labelLarge?.copyWith(fontSize: 13, height: 18 / 13, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
