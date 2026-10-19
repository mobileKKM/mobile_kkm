import 'package:ekp_api/ekp_api.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// A section's title and optional line of help, 10 above its control.
class SectionHeading extends StatelessWidget {
  const SectionHeading(this.title, {super.key, this.sub});

  final String title;
  final String? sub;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sub = this.sub;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontSize: 16, height: 22 / 16)),
          ),
          if (sub != null && sub.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              sub,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                height: 18 / 13,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A tile in a 3-column choice grid (fares, zones).
class ChoiceTile extends StatelessWidget {
  const ChoiceTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.enabled = true,
    this.exclusive = true,
  });

  final String label;
  final bool selected;
  final bool enabled;

  /// One of the group (a fare) rather than a toggle (a zone).
  final bool exclusive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final BorderSide side;
    final Color background;
    if (!enabled) {
      side = BorderSide(color: scheme.outlineVariant);
      background = Colors.transparent;
    } else if (selected) {
      side = BorderSide(color: scheme.primary, width: 2);
      background = scheme.secondaryContainer;
    } else {
      side = BorderSide.none;
      background = scheme.surfaceContainer;
    }
    return MergeSemantics(
      child: Semantics(
        button: true,
        selected: selected,
        enabled: enabled,
        inMutuallyExclusiveGroup: exclusive,
        child: Material(
          color: background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: side),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: enabled ? onTap : null,
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 64),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Center(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontFamily: theme.textTheme.bodyMedium?.fontFamily,
                          fontSize: 15,
                          height: 20 / 15,
                          color: enabled ? scheme.onSurface : scheme.onSurface.withValues(alpha: 0.38),
                        ),
                      ),
                    ),
                  ),
                ),
                if (selected)
                  PositionedDirectional(
                    top: 6,
                    end: 6,
                    child: Icon(Symbols.check_circle_rounded, fill: 1, size: 18, color: scheme.primary),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// [children] in rows of three, 8 apart; a row is as tall as its tallest.
class ChoiceTileGrid extends StatelessWidget {
  const ChoiceTileGrid({super.key, required this.children});

  static const columns = 3;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var start = 0; start < children.length; start += columns) {
      final cells = <Widget>[];
      for (var i = start; i < start + columns; i++) {
        if (i > start) {
          cells.add(const SizedBox(width: 8));
        }
        cells.add(Expanded(child: i < children.length ? children[i] : const SizedBox.shrink()));
      }
      if (rows.isNotEmpty) {
        rows.add(const SizedBox(height: 8));
      }
      rows.add(
        IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: cells),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }
}

/// One row of a radio list: a title and a line under it.
typedef RadioOption = ({String title, String? sub});

/// The ticket types: rows 2 apart in one rounded block.
class TypeRadioGroup extends StatelessWidget {
  const TypeRadioGroup({super.key, required this.options, required this.selected, required this.onSelect});

  final List<RadioOption> options;
  final int? selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    const inner = Radius.circular(6);
    const outer = Radius.circular(20);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, option) in options.indexed) ...[
          if (index > 0) const SizedBox(height: 2),
          Semantics(
            inMutuallyExclusiveGroup: true,
            checked: index == selected,
            child: Material(
              color: index == selected ? scheme.secondaryContainer : scheme.surfaceContainer,
              borderRadius: BorderRadius.vertical(
                top: index == 0 ? outer : inner,
                bottom: index == options.length - 1 ? outer : inner,
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onSelect(index),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 64),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          index == selected ? Symbols.radio_button_checked_rounded : Symbols.radio_button_unchecked,
                          size: 24,
                          color: index == selected ? scheme.primary : scheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option.title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 15,
                                  height: 20 / 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (option.sub case final sub? when sub.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Text(
                                  sub,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: 13,
                                    height: 18 / 13,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// A picked line: its number, "+ Strefa II" when it reaches there, and a
/// cross to remove it.
class LineChip extends StatelessWidget {
  const LineChip({super.key, required this.line, required this.onRemove});

  final TransportLine line;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final number = '${line.line ?? ''}';
    return Container(
      height: 40,
      padding: const EdgeInsetsDirectional.only(start: 14, end: 4),
      decoration: BoxDecoration(color: scheme.secondaryContainer, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: theme.textTheme.titleMedium?.copyWith(
              color: scheme.onSecondaryContainer,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          if (line.secondZone ?? false) ...[
            const SizedBox(width: 8),
            Text(l10n.buyAlsoZoneII, style: theme.textTheme.labelMedium?.copyWith(color: scheme.onSecondaryContainer)),
          ],
          const SizedBox(width: 4),
          IconButton(
            tooltip: l10n.lineRemove(number),
            iconSize: 18,
            visualDensity: VisualDensity.compact,
            color: scheme.onSecondaryContainer,
            icon: const Icon(Symbols.close_rounded),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

/// Opens the line search.
class AddLineButton extends StatelessWidget {
  const AddLineButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 40),
        padding: const EdgeInsetsDirectional.only(start: 10, end: 16),
        iconSize: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: Theme.of(context).textTheme.labelLarge,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      icon: const Icon(Symbols.add_rounded),
      label: Text(AppLocalizations.of(context).buyAddLine),
    );
  }
}

/// The start date: a read-only field that opens the date picker.
class DateField extends StatelessWidget {
  const DateField({super.key, required this.label, required this.value, required this.helper, required this.onTap});

  /// For screen readers.
  final String label;
  final String value;
  final String helper;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          button: true,
          label: label,
          value: value,
          excludeSemantics: true,
          child: Material(
            color: scheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: scheme.primary, width: 2),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                height: 56,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15, end: 11),
                  child: Row(
                    children: [
                      Icon(Symbols.calendar_month_rounded, size: 24, color: scheme.onSurfaceVariant),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(value, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 12),
                      Icon(Symbols.arrow_drop_down_rounded, size: 24, color: scheme.onSurfaceVariant),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (helper.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Text(helper, style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
          ),
      ],
    );
  }
}

/// A short line with an icon under a control, such as the discount's zone.
class PurchaseCaption extends StatelessWidget {
  const PurchaseCaption({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: scheme.onSurfaceVariant),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 13, height: 19 / 13, color: scheme.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
