import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/dictionary_providers.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/theme/app_theme.dart';
import 'package:mobile_kkm/core/widgets/form_card.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/skeleton_box.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/features/tickets/utils/ticket_format.dart';
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

/// How many days a return dated [returnFrom] gives back of a ticket that
/// runs from [start] to [end].
///
/// The server's [keptUntil] decides where it is known. Before that the
/// count follows its rule: the days from the chosen date on, but a ticket
/// that has started stays valid through today, so then from tomorrow at the
/// earliest.
int returnedDays({
  required DateTime returnFrom,
  required DateTime start,
  required DateTime end,
  required DateTime now,
  DateTime? keptUntil,
}) {
  DateTime dayOf(DateTime moment) {
    final local = moment.toLocal();
    return DateTime.utc(local.year, local.month, local.day);
  }

  final last = dayOf(end);
  if (keptUntil != null) {
    // Everything after the last day kept.
    final days = last.difference(dayOf(keptUntil)).inDays;
    return days < 0 ? 0 : days;
  }
  var first = DateTime.utc(returnFrom.year, returnFrom.month, returnFrom.day);
  final tomorrow = dayOf(now).add(const Duration(days: 1));
  if (!now.isBefore(start) && first.isBefore(tomorrow)) {
    first = tomorrow;
  }
  final days = last.difference(first).inDays + 1;
  return days < 0 ? 0 : days;
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
      helpText: AppLocalizations.of(context).ticketReturnPickerTitle,
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

  Future<void> _return(int transactionId, DateTime date, double amount, DateTime? validUntil) async {
    final l10n = AppLocalizations.of(context);
    final price = formatPrice(l10n.localeName, amount);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Symbols.undo_rounded),
        title: Text(l10n.ticketReturnConfirmTitle, textAlign: TextAlign.center),
        content: Text(
          validUntil == null
              ? l10n.ticketReturnConfirmBodyPlain(price)
              : l10n.ticketReturnConfirmBody(price, formatDateTime(l10n.localeName, validUntil)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
          FilledButton(
            style: AppTheme.dialogAction,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.ticketActionReturn),
          ),
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
    final scheme = theme.colorScheme;
    final colors = AppColors.of(context);
    final locale = l10n.localeName;
    final purchase = detail.ticket;
    final mobile = detail.ticketEkp;
    final transactionId = purchase?.transactionId;
    final date = _date;
    final preview = _preview;
    final amount = preview?.returnPrice;
    final start = purchase?.ticketStartDate;
    final end = purchase?.ticketExpiryDate;
    final price = purchase?.price;
    final quiet = theme.textTheme.bodySmall?.copyWith(fontSize: 13, height: 18 / 13, color: scheme.onSurfaceVariant);
    final canPick = transactionId != null && !_returning;

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

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              // Which ticket this is about; its card stays on the details.
              Container(
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
                            [if (range.isNotEmpty) range, if (price != null) formatPrice(locale, price)].join(' · '),
                            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onPrimaryContainer),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FormCard(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8,
                    children: [
                      Text(l10n.ticketReturnFrom, style: quiet?.copyWith(fontWeight: FontWeight.w500)),
                      _DateField(
                        text: date == null ? l10n.ticketReturnChooseDate : DateFormat.yMMMEd(locale).format(date),
                        chosen: date != null,
                        onTap: canPick ? () => unawaited(_pickDate(detail, transactionId)) : null,
                      ),
                    ],
                  ),
                  if (start != null && end != null)
                    _ValidityBar(
                      start: start,
                      end: end,
                      // Where the kept part ends: the server's word once it
                      // is there, the chosen date until then.
                      returnFrom: date == null ? null : preview?.newTicketExpiryDate ?? date,
                      now: DateTime.now(),
                    ),
                  if (date != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 8,
                      children: [
                        if (preview?.newTicketExpiryDate case final keptUntil?)
                          _Legend(hatched: false, text: l10n.ticketReturnKeep(formatDateTime(locale, keptUntil))),
                        if (start != null && end != null)
                          _Legend(
                            hatched: true,
                            text: l10n.ticketReturnDaysBack(
                              returnedDays(
                                returnFrom: date,
                                start: start,
                                end: end,
                                now: DateTime.now(),
                                keptUntil: preview?.newTicketExpiryDate,
                              ),
                            ),
                          ),
                      ],
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Symbols.info_rounded, size: 18, color: scheme.onSurfaceVariant),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(l10n.ticketReturnNotice, style: quiet?.copyWith(height: 19 / 13)),
                      ),
                    ],
                  ),
                ],
              ),
              if (_calculating) ...[
                const SizedBox(height: 16),
                Material(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(28),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LinearProgressIndicator(minHeight: 4, backgroundColor: Colors.transparent, color: scheme.primary),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Text(
                              l10n.ticketReturnCalculating,
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            const SkeletonBox(width: 190, height: 48, radius: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              // Only once the server has worked it out.
              if (amount != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: colors.successContainer, borderRadius: BorderRadius.circular(28)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      Text(
                        l10n.ticketReturnYouGet,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colors.onSuccessContainer,
                        ),
                      ),
                      Text(
                        formatPrice(locale, amount),
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: colors.onSuccessContainer,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (_error != null) ...[const SizedBox(height: 16), MessageBanner(_error!)],
            ],
          ),
        ),
        SafeArea(
          top: false,
          minimum: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: transactionId == null || date == null || amount == null || _returning
                    ? null
                    : () => unawaited(_return(transactionId, date, amount, preview?.newTicketExpiryDate)),
                icon: const Icon(Symbols.undo_rounded),
                label: Text(l10n.ticketActionReturn),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The chosen date, shaped like a text field; opens the picker.
class _DateField extends StatelessWidget {
  const _DateField({required this.text, required this.chosen, required this.onTap});

  final String text;
  final bool chosen;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Semantics(
      button: true,
      child: Material(
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: chosen ? BorderSide(color: scheme.primary, width: 2) : BorderSide(color: scheme.outline),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 56),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 12, 8),
              child: Row(
                children: [
                  Icon(Symbols.calendar_month_rounded, color: scheme.onSurfaceVariant),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      text,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: chosen ? FontWeight.w600 : FontWeight.w400,
                        color: chosen ? scheme.onSurface : scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Icon(Symbols.arrow_drop_down_rounded, color: scheme.onSurfaceVariant),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The ticket's validity as a bar: what is behind, what is kept and, once a
/// date is chosen, what goes back (hatched).
class _ValidityBar extends StatelessWidget {
  const _ValidityBar({required this.start, required this.end, required this.returnFrom, required this.now});

  final DateTime start;
  final DateTime end;

  /// The first day given back; none chosen yet when null.
  final DateTime? returnFrom;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final day = DateFormat.MMMd(l10n.localeName);
    final whole = end.difference(start).inSeconds;
    double share(DateTime moment) =>
        whole <= 0 ? 0 : (moment.difference(start).inSeconds / whole).clamp(0, 1).toDouble();
    final today = share(now);
    final running = !now.isBefore(start) && !now.isAfter(end);
    final kept = returnFrom == null ? 1.0 : share(returnFrom!).clamp(today, 1).toDouble();
    final quiet = theme.textTheme.bodySmall?.copyWith(fontSize: 13, height: 18 / 13, color: scheme.onSurfaceVariant);

    return ExcludeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 6,
        children: [
          SizedBox(
            height: 46,
            child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                clipBehavior: Clip.none,
                children: [
                  if (running)
                    Positioned(
                      left: constraints.maxWidth * today,
                      top: 0,
                      // Centred on the tick, but kept inside the bar's width.
                      child: FractionalTranslation(
                        translation: Offset(-today, 0),
                        child: Text(
                          l10n.ticketToday,
                          style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 24,
                    height: 16,
                    child: CustomPaint(
                      painter: _ValidityPainter(
                        today: today,
                        kept: kept,
                        track: scheme.surfaceContainerHigh,
                        used: Color.alphaBlend(scheme.primary.withValues(alpha: 0.38), scheme.surfaceContainerHigh),
                        keep: scheme.primary,
                        hatch: scheme.outline,
                        gap: scheme.surfaceContainerLow,
                      ),
                    ),
                  ),
                  if (running)
                    Positioned(
                      left: constraints.maxWidth * today - 1,
                      top: 19,
                      child: Container(
                        width: 2,
                        height: 26,
                        decoration: BoxDecoration(color: scheme.onSurface, borderRadius: BorderRadius.circular(1)),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(day.format(start.toLocal()), style: quiet),
              Text(day.format(end.toLocal()), style: quiet),
            ],
          ),
        ],
      ),
    );
  }
}

class _ValidityPainter extends CustomPainter {
  const _ValidityPainter({
    required this.today,
    required this.kept,
    required this.track,
    required this.used,
    required this.keep,
    required this.hatch,
    required this.gap,
  });

  final double today;
  final double kept;
  final Color track;
  final Color used;
  final Color keep;
  final Color hatch;
  final Color gap;

  @override
  void paint(Canvas canvas, Size size) {
    final bar = RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(size.height / 2));
    canvas
      ..save()
      ..clipRRect(bar)
      ..drawRect(Offset.zero & size, Paint()..color = track)
      ..drawRect(Rect.fromLTRB(0, 0, size.width * today, size.height), Paint()..color = used)
      ..drawRect(Rect.fromLTRB(size.width * today, 0, size.width * kept, size.height), Paint()..color = keep);
    if (kept < 1) {
      final from = size.width * kept;
      hatchRect(canvas, Rect.fromLTRB(from, 0, size.width, size.height), hatch);
      canvas.drawRect(Rect.fromLTWH(from, 0, 2, size.height), Paint()..color = gap);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_ValidityPainter old) =>
      old.today != today || old.kept != kept || old.keep != keep || old.track != track || old.hatch != hatch;
}

/// Diagonal stripes: the pattern for "given back", which no colour means.
void hatchRect(Canvas canvas, Rect rect, Color color) {
  final stroke = Paint()
    ..color = color
    ..strokeWidth = 2;
  canvas
    ..save()
    ..clipRect(rect);
  for (var x = rect.left - rect.height; x < rect.right; x += 6) {
    canvas.drawLine(Offset(x, rect.bottom), Offset(x + rect.height, rect.top), stroke);
  }
  canvas.restore();
}

/// What a part of the bar stands for.
class _Legend extends StatelessWidget {
  const _Legend({required this.hatched, required this.text});

  final bool hatched;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox.square(
            dimension: 16,
            child: CustomPaint(
              painter: _SwatchPainter(
                hatched: hatched,
                color: hatched ? scheme.outline : scheme.primary,
                background: scheme.surfaceContainerHigh,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}

class _SwatchPainter extends CustomPainter {
  const _SwatchPainter({required this.hatched, required this.color, required this.background});

  final bool hatched;
  final Color color;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    if (hatched) {
      canvas.drawRect(rect, Paint()..color = background);
      hatchRect(canvas, rect, color);
    } else {
      canvas.drawRect(rect, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(_SwatchPainter old) => old.hatched != hatched || old.color != color;
}
