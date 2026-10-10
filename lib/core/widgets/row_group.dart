import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Rows that belong together, drawn as one rounded block with hairline gaps.
class RowGroup extends StatelessWidget {
  const RowGroup({super.key, this.title, this.titleColor, required this.children});

  final String? title;

  /// Primary unless given.
  final Color? titleColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
            child: Semantics(
              header: true,
              child: Text(
                title!,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  height: 22 / 16,
                  color: titleColor ?? theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 2, children: children),
        ),
      ],
    );
  }
}

/// One row of a [RowGroup]: a tile, a label with an optional line under it,
/// and what the row leads to.
class GroupRow extends StatelessWidget {
  const GroupRow({
    super.key,
    required this.leading,
    required this.label,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showChevron = true,
    this.color,
    this.labelColor,
    this.minHeight = 68,
    this.dense = false,
  });

  final Widget leading;
  final String label;
  final String? subtitle;

  /// Before the chevron, e.g. a state or a price.
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  /// The row's own colour; surfaceContainer unless given.
  final Color? color;
  final Color? labelColor;
  final double minHeight;

  /// The smaller row of a sheet: a 15 dp label and less room around it.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Material(
      color: color ?? scheme.surfaceContainer,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, dense ? 10 : 12, showChevron ? 8 : 16, dense ? 10 : 12),
            child: Row(
              children: [
                leading,
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: dense ? 15 : null,
                          height: dense ? 20 / 15 : 22 / 16,
                          fontWeight: FontWeight.w600,
                          color: labelColor,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
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
                if (trailing != null) ...[const SizedBox(width: 8), trailing!],
                if (showChevron)
                  SizedBox(width: 40, child: Icon(Symbols.chevron_right_rounded, color: scheme.onSurfaceVariant)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
