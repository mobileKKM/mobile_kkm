import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// A checkbox with its label, level with the fields around it: the box
/// starts where their borders do. The whole row toggles it.
class CheckRow extends StatelessWidget {
  const CheckRow({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.isError = false,
    this.trailing,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  /// Draws the empty box as a mistake.
  final bool isError;

  /// After the label, e.g. a link; not part of what toggles.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final trailing = this.trailing;
    return Row(
      children: [
        Expanded(
          child: Semantics(
            checked: value,
            label: label,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onChanged(!value),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48),
                child: Row(
                  children: [
                    Icon(
                      value ? Symbols.check_box_rounded : Symbols.check_box_outline_blank_rounded,
                      fill: value ? 1 : 0,
                      color: isError
                          ? scheme.error
                          : value
                          ? scheme.primary
                          : scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ExcludeSemantics(
                        child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15, height: 20 / 15)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }
}
