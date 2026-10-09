import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// A mandatory consent checkbox, optionally followed by a link to the
/// regulations it refers to.
class ConsentField extends StatelessWidget {
  const ConsentField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    required this.onOpenRegulations,
  });

  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  /// Null while the regulations URL is unknown — the link is then omitted.
  final VoidCallback? onOpenRegulations;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return FormField<bool>(
      initialValue: initialValue,
      validator: (checked) => checked == true ? null : l10n.consentRequired,
      builder: (field) {
        void toggle(bool? checked) {
          field.didChange(checked ?? false);
          onChanged(checked ?? false);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(value: field.value, isError: field.hasError, onChanged: toggle, semanticLabel: label),
                const SizedBox(width: 8),
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => toggle(!(field.value ?? false)),
                        child: ExcludeSemantics(
                          child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15)),
                        ),
                      ),
                      if (onOpenRegulations != null)
                        TextButton(onPressed: onOpenRegulations, child: Text(l10n.regulationsLink)),
                    ],
                  ),
                ),
              ],
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 36),
                child: Text(
                  field.errorText!,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
                ),
              ),
          ],
        );
      },
    );
  }
}
