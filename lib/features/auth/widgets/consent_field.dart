import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/check_row.dart';
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
        void toggle(bool checked) {
          field.didChange(checked);
          onChanged(checked);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckRow(
              value: field.value ?? false,
              isError: field.hasError,
              onChanged: toggle,
              label: label,
              // At the row's end, whatever the length of the consent.
              trailing: onOpenRegulations == null
                  ? null
                  : TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 48),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: onOpenRegulations,
                      child: Text(l10n.regulationsLink),
                    ),
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
