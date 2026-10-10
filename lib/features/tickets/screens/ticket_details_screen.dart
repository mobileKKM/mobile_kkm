import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/form_card.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/features/tickets/widgets/mkkm_ticket_card.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_actions.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The line number that stands for "all lines" on network tickets.
const _allLines = 1000;

/// Whether the lines of a purchase can be changed: the server's flag, and
/// only for a ticket that names lines. A network or metropolitan ticket
/// covers them all, whatever the flag says.
bool canChangeLineOf(TicketDetailResponse detail) {
  final ticket = detail.ticketEkp;
  return (detail.canChangeLine ?? false) &&
      ticket != null &&
      !(ticket.isNetwork ?? false) &&
      !(ticket.isMetropolitan ?? false) &&
      ticket.lines.isNotEmpty &&
      ticket.lines.every((line) => line.line != _allLines);
}

/// One step in a purchase's life, with the list it came from.
typedef TimelineEntry = ({String kind, TicketStateChange change});

/// The transaction, payment and refund states as one history, newest first.
List<TimelineEntry> timelineOf(AppLocalizations l10n, TicketDetailResponse detail) {
  final entries = <TimelineEntry>[
    for (final (kind, changes) in [
      (l10n.ticketHistoryTransaction, detail.transactionStateList),
      (l10n.ticketHistoryPayment, detail.paymentStateList),
      (l10n.ticketHistoryRefund, detail.refundStateList),
    ])
      for (final change in changes ?? const <TicketStateChange>[]) (kind: kind, change: change),
  ];
  final order = {for (final (index, entry) in entries.indexed) entry: index};
  return entries..sort((a, b) {
    final at = a.change.createDate;
    final bt = b.change.createDate;
    // Undated ones last; equal moments keep the order the server gave.
    final byDate = at == null || bt == null ? (at == null ? 1 : 0) - (bt == null ? 1 : 0) : bt.compareTo(at);
    return byDate != 0 ? byDate : order[a]!.compareTo(order[b]!);
  });
}

/// One purchase in full: the ticket, what can still be done with it, how it
/// was paid and what happened to it since.
class TicketDetailsScreen extends ConsumerWidget {
  const TicketDetailsScreen({super.key, required this.transactionCode});

  final String transactionCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final detail = ref.watch(ticketDetailProvider(transactionCode));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.ticketDetailsTitle)),
      body: switch (detail) {
        AsyncValue(value: final detail?) => _Details(detail, transactionCode: transactionCode),
        AsyncError(:final error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: LoadProblem(
              message: describeError(l10n, error),
              onRetry: () => ref.invalidate(ticketDetailProvider(transactionCode)),
            ),
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Details extends ConsumerWidget {
  const _Details(this.detail, {required this.transactionCode});

  final TicketDetailResponse detail;
  final String transactionCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final locale = l10n.localeName;
    final purchase = detail.ticket;
    // Cancelled for want of a payment: only the purchase says so, the
    // ticket in it has no status for that.
    final cancelled = isCancelledPurchase(purchase?.transactionStateId);
    final mobile = detail.ticketEkp;
    final returns = detail.ticketReturns ?? const <TicketReturn>[];
    final timeline = timelineOf(l10n, detail);
    final expiry = purchase?.ticketExpiryDate;
    final running = expiry != null && DateTime.now().isBefore(expiry);

    GroupRow action(IconData icon, String label, String hint, VoidCallback onTap) => GroupRow(
      minHeight: 72,
      color: scheme.surfaceContainerHigh,
      leading: IconTile(icon),
      label: label,
      subtitle: hint,
      onTap: onTap,
    );
    final actions = [
      // Nothing is left to change, extend or give back; only to buy it again.
      if (cancelled) ...[
        if (detail.canBuyTheSame ?? false)
          action(
            Symbols.add_shopping_cart_rounded,
            l10n.ticketActionBuyAgain,
            l10n.ticketActionBuySimilarHint,
            () => context.push(Routes.buy),
          ),
      ] else ...[
        if (canChangeLineOf(detail))
          action(
            Symbols.swap_horiz_rounded,
            l10n.ticketActionChangeLine,
            l10n.ticketActionChangeLineHint,
            () => context.push(Routes.ticketChangeLine(transactionCode)),
          ),
        // Both are part of the purchase flow.
        if (detail.canBuyTheSame ?? false)
          if (running)
            action(
              Symbols.event_repeat_rounded,
              l10n.ticketActionExtend,
              l10n.ticketActionExtendHint(formatDate(locale, expiry.add(const Duration(seconds: 1)))),
              () => context.push(Routes.buy),
            )
          else
            action(
              Symbols.add_shopping_cart_rounded,
              l10n.ticketActionBuySimilar,
              l10n.ticketActionBuySimilarHint,
              () => context.push(Routes.buy),
            ),
        if (detail.canReturn ?? false)
          action(
            Symbols.undo_rounded,
            l10n.ticketActionReturn,
            l10n.ticketActionReturnHint,
            () => context.push(Routes.ticketReturn(transactionCode)),
          ),
      ],
    ];

    return RefreshIndicator(
      // A failure shows in the screen's place, not here.
      onRefresh: () => ref.refresh(ticketDetailProvider(transactionCode).future).then<void>((_) {}, onError: (_) {}),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 4, 16, 24 + MediaQuery.viewPaddingOf(context).bottom),
        children: [
          if (mobile != null)
            MkkmTicketCard(mobile, cancelled: cancelled)
          else
            TicketCard(
              title: purchase?.productName ?? l10n.ticketTitleGeneric,
              pill: cancelled ? TicketPill(l10n.ticketStatusCancelled, Symbols.block_rounded) : null,
              range: formatValidity(locale, purchase?.ticketStartDate, purchase?.ticketExpiryDate),
              stub: cancelled ? TicketNote(Symbols.block_rounded, l10n.ticketCancelledNote) : null,
            ),
          if (mobile != null && !cancelled && actionOf(mobile) == TicketAction.assignedElsewhere) ...[
            const SizedBox(height: 16),
            MessageBanner(l10n.ticketCantAssign, kind: BannerKind.info),
          ],
          if (actions.isNotEmpty) ...[
            const SizedBox(height: 16),
            RowGroup(title: l10n.ticketDetailsManage, titleColor: scheme.onSurface, children: actions),
          ],
          for (final entry in returns) ...[const SizedBox(height: 16), _ReturnCard(entry)],
          if (purchase != null) ...[
            const SizedBox(height: 16),
            FormCard(
              title: l10n.ticketSectionPurchase,
              children: [
                _FieldGrid([
                  // The server's name for what was bought; the card above
                  // names it from the dictionaries.
                  if (purchase.productName case final name? when name.isNotEmpty) (l10n.ticketDetailsProduct, name),
                  if (purchase.transactionDate case final date?)
                    (l10n.ticketFieldPurchased, formatDateTime(locale, date)),
                  (l10n.ticketFieldPaid, (purchase.isPayed ?? false) ? l10n.yes : l10n.no),
                  // The server's own wording (Polish only) from here on.
                  (l10n.ticketFieldPaymentType, purchase.paymentDescription),
                  (l10n.ticketFieldPaymentState, purchase.paymentStateDescription),
                  (l10n.ticketFieldTransactionState, purchase.transactionStateDescription),
                  (l10n.ticketFieldPromotion, purchase.promotionName),
                  if (purchase.price case final price?) (l10n.ticketFieldPrice, formatPrice(price)),
                ]),
              ],
            ),
          ],
          if (timeline.isNotEmpty) ...[
            const SizedBox(height: 16),
            FormCard(title: l10n.ticketHistoryTitle, children: [_Timeline(timeline)]),
          ],
        ],
      ),
    );
  }
}

/// A return of the ticket: money coming back, so the one green card.
class _ReturnCard extends StatelessWidget {
  const _ReturnCard(this.entry);

  final TicketReturn entry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = AppColors.of(context);
    final locale = l10n.localeName;
    final amount = entry.unitPriceReturn;
    final on = colors.onSuccessContainer;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: colors.successContainer, borderRadius: BorderRadius.circular(28)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Row(
            children: [
              Icon(Symbols.undo_rounded, size: 22, color: on),
              const SizedBox(width: 10),
              Text(
                l10n.ticketSectionReturn,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 16, height: 22 / 16, color: on),
              ),
            ],
          ),
          if (amount != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  l10n.ticketFieldRefundAmount,
                  style: theme.textTheme.labelMedium?.copyWith(fontSize: 13, height: 18 / 13, color: on),
                ),
                Text(
                  formatPrice(amount),
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: on,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          _FieldGrid(
            [
              if (entry.returnDate case final date?) (l10n.ticketFieldReturnOrdered, formatDateTime(locale, date)),
              if (entry.returnQty case final days?) (l10n.ticketFieldReturnedDays, '$days'),
              // The server's own wording (Polish only).
              if (entry.paymentTypeDescription case final method?) (l10n.ticketFieldRefundMethod, method),
            ],
            labelColor: on,
            valueColor: on,
            valueWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

/// Values under their labels, two to a row; a dash for a value the server
/// left out.
class _FieldGrid extends StatelessWidget {
  const _FieldGrid(this.fields, {this.labelColor, this.valueColor, this.valueWeight = FontWeight.w500});

  final List<(String label, String? value)> fields;
  final Color? labelColor;
  final Color? valueColor;
  final FontWeight valueWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    Widget field((String, String?) entry) {
      final (label, value) = entry;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 13,
              height: 18 / 13,
              color: labelColor ?? scheme.onSurfaceVariant,
            ),
          ),
          Text(
            value == null || value.isEmpty ? '–' : value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 15,
              height: 20 / 15,
              fontWeight: valueWeight,
              color: valueColor,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 14,
      children: [
        for (var row = 0; row < fields.length; row += 2)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Expanded(child: field(fields[row])),
              Expanded(child: row + 1 < fields.length ? field(fields[row + 1]) : const SizedBox.shrink()),
            ],
          ),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline(this.entries);

  final List<TimelineEntry> entries;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      children: [
        for (final (index, entry) in entries.indexed)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 16,
                  child: Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // The latest state is the one that holds now.
                          color: index == 0 ? scheme.primary : null,
                          border: index == 0 ? null : Border.all(color: scheme.outline, width: 2),
                        ),
                      ),
                      if (index < entries.length - 1)
                        Expanded(
                          child: Container(
                            width: 2,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              color: scheme.outlineVariant,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: index < entries.length - 1 ? 16 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 2,
                      children: [
                        // The server's own wording (Polish only).
                        Text(
                          entry.change.stateDescription ?? '–',
                          style: theme.textTheme.labelLarge?.copyWith(fontSize: 15),
                        ),
                        Text(
                          [
                            if (entry.change.createDate case final date?) formatDateTime(l10n.localeName, date),
                            entry.kind,
                          ].join(' · '),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 13,
                            height: 18 / 13,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
