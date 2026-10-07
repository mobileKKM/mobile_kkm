import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/router/routes.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/features/tickets/widgets/mkkm_ticket_card.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// One purchase in full: the ticket, how it was paid, what happened to it
/// since, and what can still be done with it.
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
    final locale = l10n.localeName;
    final purchase = detail.ticket;
    final mobile = detail.ticketEkp;
    final returns = detail.ticketReturns ?? const <TicketReturn>[];
    final canReturn = detail.canReturn ?? false;
    final canBuyAgain = detail.canBuyTheSame ?? false;
    final expiry = purchase?.ticketExpiryDate;
    final running = expiry != null && DateTime.now().isBefore(expiry);

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            // A failure shows in the screen's place, not here.
            onRefresh: () =>
                ref.refresh(ticketDetailProvider(transactionCode).future).then<void>((_) {}, onError: (_) {}),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                if (mobile != null)
                  MkkmTicketCard(mobile)
                else
                  TicketCard(
                    title: purchase?.productName ?? l10n.ticketTitleGeneric,
                    start: purchase?.ticketStartDate,
                    end: purchase?.ticketExpiryDate,
                  ),
                if (mobile != null && actionOf(mobile) == TicketAction.assignedElsewhere) ...[
                  const SizedBox(height: 12),
                  MessageBanner(l10n.ticketCantAssign, kind: BannerKind.info),
                ],
                if (purchase != null) ...[
                  const SizedBox(height: 12),
                  _Section(
                    title: l10n.ticketSectionPurchase,
                    children: [
                      if (purchase.transactionDate case final date?)
                        _Field(l10n.ticketFieldPurchased, formatDateTime(locale, date)),
                      _Field(l10n.ticketFieldPaid, (purchase.isPayed ?? false) ? l10n.yes : l10n.no),
                      // The server's own wording (Polish only) from here on.
                      _Field(l10n.ticketFieldPaymentType, purchase.paymentDescription),
                      _Field(l10n.ticketFieldPaymentState, purchase.paymentStateDescription),
                      _Field(l10n.ticketFieldTransactionState, purchase.transactionStateDescription),
                      _Field(l10n.ticketFieldPromotion, purchase.promotionName),
                      if (purchase.price case final price?) _Field(l10n.ticketFieldPrice, formatPrice(locale, price)),
                    ],
                  ),
                ],
                for (final (title, changes) in [
                  (l10n.ticketHistoryTransaction, detail.transactionStateList),
                  (l10n.ticketHistoryPayment, detail.paymentStateList),
                  (l10n.ticketHistoryRefund, detail.refundStateList),
                ])
                  if (changes != null && changes.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _Section(
                      title: title,
                      children: [
                        for (final change in changes)
                          _Field(
                            change.createDate == null ? null : formatDateTime(locale, change.createDate!),
                            change.stateDescription,
                          ),
                      ],
                    ),
                  ],
                for (final entry in returns) ...[
                  const SizedBox(height: 12),
                  _Section(
                    title: l10n.ticketSectionReturn,
                    children: [
                      if (entry.returnDate case final date?)
                        _Field(l10n.ticketFieldReturnOrdered, formatDateTime(locale, date)),
                      if (entry.returnQty case final days?) _Field(l10n.ticketFieldReturnedDays, '$days'),
                      if (entry.unitPriceReturn case final amount?)
                        _Field(l10n.ticketFieldRefundAmount, formatPrice(locale, amount)),
                      // The server's own wording (Polish only).
                      if (entry.paymentTypeDescription case final method?) _Field(l10n.ticketFieldRefundMethod, method),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        if (canReturn || canBuyAgain)
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  if (canBuyAgain)
                    Expanded(
                      child: TextButton(
                        // Part of the purchase flow.
                        onPressed: () => context.push(Routes.buy),
                        child: Text(running ? l10n.ticketActionExtend : l10n.ticketActionBuySimilar),
                      ),
                    ),
                  if (canReturn && canBuyAgain) const SizedBox(width: 8),
                  if (canReturn)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.push(Routes.ticketReturn(transactionCode)),
                        child: Text(l10n.ticketActionReturn),
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Text(title, style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary)),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// A value under its label; a dash for a value the server left out.
class _Field extends StatelessWidget {
  const _Field(this.label, this.value);

  final String? label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value = this.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(label!, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        Text(value == null || value.isEmpty ? '–' : value, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}
