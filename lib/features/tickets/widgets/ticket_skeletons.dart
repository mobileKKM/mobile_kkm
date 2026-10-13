import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/skeleton_box.dart';

/// A bar that takes [share] of the width it is given.
class _Bar extends StatelessWidget {
  const _Bar(this.share, this.height);

  final double share;
  final double height;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
    widthFactor: share,
    alignment: AlignmentDirectional.centerStart,
    child: SkeletonBox(height: height),
  );
}

/// The outline of a ticket card whose ticket is still on its way.
class TicketCardSkeleton extends StatelessWidget {
  const TicketCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 18,
        children: [
          Row(
            spacing: 14,
            children: [
              SkeletonBox(width: 44, height: 44, radius: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [_Bar(0.7, 14), _Bar(0.48, 10)],
                ),
              ),
            ],
          ),
          SkeletonBox(width: 132, height: 40, radius: 12),
          SkeletonBox(height: 8),
          SkeletonBox(height: 56),
        ],
      ),
    );
  }
}

/// A group of rows under a heading: [rows] gives each row's two bar widths,
/// as shares of the room between the tile and the row's end.
class RowGroupSkeleton extends StatelessWidget {
  const RowGroupSkeleton({
    super.key,
    required this.heading,
    required this.rows,
    this.minHeight = 68,
    this.tile = 40,
    this.trailing = false,
  });

  final double heading;
  final List<(double, double)> rows;
  final double minHeight;
  final double tile;

  /// Two short bars at the row's end, where a price and a state will be.
  final bool trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 9, 4, 11),
          child: SkeletonBox(width: heading, height: 14),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            spacing: 2,
            children: [
              for (final (title, subtitle) in rows)
                Container(
                  constraints: BoxConstraints(minHeight: minHeight),
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, trailing ? 16 : 8, 12),
                  decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    spacing: 14,
                    children: [
                      SkeletonBox(width: tile, height: tile, radius: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [_Bar(title, 12), _Bar(subtitle, 10)],
                        ),
                      ),
                      if (trailing)
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 8,
                          children: [SkeletonBox(width: 60, height: 12), SkeletonBox(width: 76, height: 10)],
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The purchase history in outline: three months of rows.
class TicketHistorySkeleton extends StatelessWidget {
  const TicketHistorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        RowGroupSkeleton(heading: 120, trailing: true, rows: [(0.78, 0.52), (0.64, 0.46)]),
        RowGroupSkeleton(heading: 104, trailing: true, rows: [(0.72, 0.5), (0.84, 0.44), (0.6, 0.48)]),
        RowGroupSkeleton(heading: 116, trailing: true, rows: [(0.7, 0.52), (0.76, 0.46)]),
      ],
    );
  }
}

/// What a ticket's details have under the card, in outline: the "Manage"
/// rows and the purchase.
class TicketDetailsSkeleton extends StatelessWidget {
  const TicketDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    Widget field(double label, double value) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [_Bar(label, 10), _Bar(value, 12)],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        const RowGroupSkeleton(heading: 96, minHeight: 72, tile: 44, rows: [(0.52, 0.76), (0.52, 0.76), (0.52, 0.76)]),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 18,
            children: [
              const SkeletonBox(width: 88, height: 14),
              Column(
                spacing: 16,
                children: [
                  Row(spacing: 20, children: [field(0.48, 0.8), field(0.56, 0.64)]),
                  Row(spacing: 20, children: [field(0.4, 0.72), field(0.6, 0.52)]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
