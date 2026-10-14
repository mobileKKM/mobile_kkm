import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Which ticket a screen is about, in one line and a half: what it is, when
/// it runs and what it cost. Its card stays on the details.
class TicketSummaryPanel extends ConsumerWidget {
  const TicketSummaryPanel({super.key, required this.detail});

  final TicketDetailResponse detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final locale = l10n.localeName;
    final purchase = detail.ticket;
    final mobile = detail.ticketEkp;
    final start = purchase?.ticketStartDate;
    final end = purchase?.ticketExpiryDate;
    final price = purchase?.price;

    final String title;
    if (mobile != null) {
      final zone = ticketZone(mobile.ticketNumberOfLineCode, ref.watch(ticketLineScopesProvider).value);
      title = ticketScope(l10n, mobile, zone: zone);
    } else {
      title = purchase?.productName ?? l10n.ticketTitleGeneric;
    }
    final range = [
      if (start != null) DateFormat.MMMd(locale).format(start.toLocal()),
      if (end != null) formatDate(locale, end),
    ].join(' – ');

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 16, 14),
      decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          IconTile(
            mobile != null && isTramTicket(mobile) ? Symbols.tram_rounded : Symbols.directions_bus_rounded,
            radius: 16,
            iconSize: 24,
            background: scheme.primaryFixed,
            foreground: scheme.onPrimaryFixed,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 17,
                    height: 22 / 17,
                    color: scheme.primaryFixed,
                  ),
                ),
                Text(
                  [if (range.isNotEmpty) range, if (price != null) formatPrice(price)].join(' · '),
                  style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
