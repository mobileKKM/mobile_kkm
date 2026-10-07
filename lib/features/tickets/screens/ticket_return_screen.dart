import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
import 'package:mobile_kkm/features/tickets/widgets/mkkm_ticket_card.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_card.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The days a return can be dated: from today, or from the ticket's first
/// day when that is still ahead, up to the last day the server allows.
(DateTime first, DateTime last) returnDateBounds(TicketDetailResponse detail, DateTime now) {
  DateTime dayOf(DateTime moment) => DateTime(moment.year, moment.month, moment.day);

  final start = detail.ticket?.ticketStartDate?.toLocal();
  final first = start != null && now.isBefore(start) ? dayOf(start) : dayOf(now);
  final limit = (detail.minExpireReturnDate ?? detail.ticket?.ticketExpiryDate)?.toLocal();
  final last = limit == null ? first.add(const Duration(days: 366)) : dayOf(limit);
  return (first, last.isBefore(first) ? first : last);
}

/// Gives a ticket back for the days from a chosen date on: the server says
/// what that is worth before anything is returned.
class TicketReturnScreen extends ConsumerStatefulWidget {
  const TicketReturnScreen({super.key, required this.transactionCode});

  final String transactionCode;

  @override
  ConsumerState<TicketReturnScreen> createState() => _TicketReturnScreenState();
}

class _TicketReturnScreenState extends ConsumerState<TicketReturnScreen> {
  DateTime? _date;
  TicketReturnCalculation? _preview;
  String? _error;
  bool _calculating = false;
  bool _returning = false;

  Future<void> _pickDate(TicketDetailResponse detail, int transactionId) async {
    final (first, last) = returnDateBounds(detail, DateTime.now());
    final current = _date;
    final picked = await showDatePicker(
      context: context,
      firstDate: first,
      lastDate: last,
      initialDate: current != null && !current.isBefore(first) && !current.isAfter(last) ? current : first,
    );
    if (picked == null || !mounted) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    setState(() {
      _date = picked;
      _preview = null;
      _error = null;
      _calculating = true;
    });
    TicketReturnCalculation? preview;
    String? error;
    try {
      preview = await ref
          .read(ekpClientProvider)
          .tickets
          .calculateReturn(transactionId: transactionId, returnDate: picked);
      // A refusal arrives as a reply like any other.
      if (preview.code != null || preview.returnPrice == null) {
        error = preview.message ?? l10n.errorGeneric;
        preview = null;
      }
    } on Exception catch (exception) {
      error = describeError(l10n, exception);
    }
    // Another date was picked in the meantime.
    if (!mounted || _date != picked) {
      return;
    }
    setState(() {
      _preview = preview;
      _error = error;
      _calculating = false;
    });
  }

  Future<void> _return(int transactionId, DateTime date, double amount) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.ticketReturnConfirmTitle),
        content: Text(l10n.ticketReturnConfirmBody(formatPrice(l10n.localeName, amount))),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(l10n.ticketActionReturn)),
        ],
      ),
    );
    if (!(confirmed ?? false) || !mounted) {
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _returning = true;
      _error = null;
    });
    String? error;
    try {
      final result = await ref
          .read(ekpClientProvider)
          .tickets
          .returnTicket(transactionId: transactionId, returnDate: date);
      if (!(result.success ?? false)) {
        error = l10n.ticketReturnError;
      }
    } on Exception catch (exception) {
      error = describeError(l10n, exception);
    }
    if (!mounted) {
      return;
    }
    if (error != null) {
      setState(() {
        _returning = false;
        _error = error;
      });
      return;
    }
    // The ticket has changed everywhere it is shown.
    ref
      ..invalidate(ticketDetailProvider(widget.transactionCode))
      ..invalidate(ticketHistoryProvider);
    unawaited(ref.read(ticketSyncProvider.notifier).refresh());
    messenger.showSnackBar(SnackBar(content: Text(l10n.ticketReturnDone)));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detail = ref.watch(ticketDetailProvider(widget.transactionCode));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.ticketReturnTitle)),
      body: switch (detail) {
        AsyncValue(value: final detail?) => _form(context, detail),
        AsyncError(:final error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: LoadProblem(
              message: describeError(l10n, error),
              onRetry: () => ref.invalidate(ticketDetailProvider(widget.transactionCode)),
            ),
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Widget _form(BuildContext context, TicketDetailResponse detail) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = l10n.localeName;
    final purchase = detail.ticket;
    final mobile = detail.ticketEkp;
    final transactionId = purchase?.transactionId;
    final date = _date;
    final preview = _preview;
    final amount = preview?.returnPrice;
    final muted = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              if (mobile != null)
                MkkmTicketCard(mobile, showActions: false)
              else
                TicketCard(
                  title: purchase?.productName ?? l10n.ticketTitleGeneric,
                  start: purchase?.ticketStartDate,
                  end: purchase?.ticketExpiryDate,
                ),
              const SizedBox(height: 12),
              MessageBanner(l10n.ticketReturnNotice, kind: BannerKind.info),
              const SizedBox(height: 12),
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 12,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.ticketReturnDate, style: muted),
                                Text(date == null ? '–' : formatDate(locale, date), style: theme.textTheme.bodyLarge),
                              ],
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: transactionId == null || _returning
                                ? null
                                : () => unawaited(_pickDate(detail, transactionId)),
                            icon: const Icon(Symbols.calendar_month_rounded),
                            label: Text(l10n.ticketReturnChooseDate),
                          ),
                        ],
                      ),
                      if (_calculating) const LinearProgressIndicator(),
                      if (preview != null) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.ticketReturnNewEnd, style: muted),
                            Text(
                              preview.newTicketExpiryDate == null
                                  ? '–'
                                  : formatDateTime(locale, preview.newTicketExpiryDate!),
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        if (amount != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.ticketFieldRefundAmount, style: muted),
                              Text(formatPrice(locale, amount), style: theme.textTheme.headlineSmall),
                            ],
                          ),
                      ],
                    ],
                  ),
                ),
              ),
              if (_error != null) ...[const SizedBox(height: 12), MessageBanner(_error!)],
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: FilledButton(
              onPressed: transactionId == null || date == null || amount == null || _returning
                  ? null
                  : () => unawaited(_return(transactionId, date, amount)),
              child: Text(l10n.ticketActionReturn),
            ),
          ),
        ),
      ],
    );
  }
}
