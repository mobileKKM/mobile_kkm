import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/status_chip.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

StatusTone toneOf(TicketPhase phase) => switch (phase) {
  TicketPhase.valid => StatusTone.positive,
  TicketPhase.pending || TicketPhase.processing => StatusTone.warning,
  TicketPhase.upcoming || TicketPhase.returned || TicketPhase.expired || TicketPhase.unknown => StatusTone.neutral,
};

/// One ticket: what it covers, when it is valid, what it cost, its state
/// and what can be done with it. Serves the mobile tickets and the purchase
/// history alike.
class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Symbols.directions_bus_rounded,
    this.start,
    this.end,
    this.price,
    this.statusLabel,
    this.tone = StatusTone.neutral,
    this.note,
    this.pinned = false,
    this.trailing,
    this.actions,
    this.onTap,
  });

  final String title;

  /// The product's name, under what it covers.
  final String? subtitle;
  final IconData icon;
  final DateTime? start;
  final DateTime? end;
  final double? price;

  /// Short state shown as a chip.
  final String? statusLabel;
  final StatusTone tone;

  /// Longer state text, for the server's own descriptions.
  final String? note;

  /// Marks the ticket the user pinned to the home screen.
  final bool pinned;
  final Widget? trailing;

  /// Buttons along the bottom.
  final Widget? actions;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final muted = theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant);
    final dates = formatValidity(l10n.localeName, start, end);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16, end: trailing == null ? 16 : 4),
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(color: scheme.secondaryContainer, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(icon, color: scheme.onSecondaryContainer),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: theme.textTheme.titleMedium),
                          if (subtitle != null) Text(subtitle!, style: muted),
                        ],
                      ),
                    ),
                    if (pinned) ...[
                      const SizedBox(width: 8),
                      Icon(
                        Symbols.push_pin_rounded,
                        size: 18,
                        fill: 1,
                        color: scheme.primary,
                        semanticLabel: l10n.ticketPinned,
                      ),
                    ],
                    // Keeps the title row the same height with and without a menu.
                    trailing ?? const SizedBox(height: 48),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dates.isNotEmpty) ...[const SizedBox(height: 4), Text(dates, style: muted)],
                    if (note != null) ...[
                      const SizedBox(height: 4),
                      Text(note!, style: muted, maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                    if (statusLabel != null || price != null) ...[
                      const SizedBox(height: 12),
                      // The price moves below a status too long to share its line.
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            if (statusLabel != null) StatusChip(statusLabel!, tone: tone),
                            if (price != null)
                              Text(formatPrice(l10n.localeName, price!), style: theme.textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                    if (actions != null) ...[const SizedBox(height: 16), actions!],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
