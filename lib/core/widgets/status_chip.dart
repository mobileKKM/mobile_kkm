import 'package:material_ui/material_ui.dart';

/// A short state label on a tinted background, with the icon that says the
/// same thing: the colour never carries the state alone.
class StatusChip extends StatelessWidget {
  const StatusChip(
    this.label, {
    super.key,
    required this.icon,
    required this.background,
    required this.foreground,
    this.compact = false,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;

  /// The smaller size, for a row's trailing end; its icon is filled.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelLarge
        ?.copyWith(color: foreground, fontSize: compact ? 13 : 14, height: compact ? 18 / 13 : 20 / 14);
    return Container(
      constraints: BoxConstraints(minHeight: compact ? 28 : 32),
      padding: EdgeInsetsDirectional.only(start: 8, end: compact ? 10 : 12, top: 2, bottom: 2),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(compact ? 8 : 10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: compact ? 16 : 20, fill: compact ? 1 : 0, color: foreground),
          SizedBox(width: compact ? 4 : 6),
          Flexible(child: Text(label, style: style)),
        ],
      ),
    );
  }
}
