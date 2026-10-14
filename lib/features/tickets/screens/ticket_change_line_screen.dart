import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/error_messages.dart';
import 'package:mobile_kkm/core/providers/app_startup_provider.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/widgets/app_snack_bar.dart';
import 'package:mobile_kkm/core/widgets/app_status_banner.dart';
import 'package:mobile_kkm/core/widgets/bottom_action_bar.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/load_problem.dart';
import 'package:mobile_kkm/core/widgets/message_banner.dart';
import 'package:mobile_kkm/core/widgets/submit_button.dart';
import 'package:mobile_kkm/features/tickets/providers/tickets_providers.dart';
import 'package:mobile_kkm/features/tickets/screens/line_search_screen.dart';
import 'package:mobile_kkm/features/tickets/services/ticket_sync.dart';
import 'package:mobile_kkm/features/tickets/widgets/ticket_summary_panel.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// What a ticket is valid on once [picked] lines have taken the places of
/// those of [lines] they stand for, by position.
List<TransportLine> linesAfter(List<TransportLine> lines, Map<int, TransportLine> picked) => [
  for (final (index, line) in lines.indexed) picked[index] ?? line,
];

/// Puts other lines in the place of a line ticket's: one tile per line of
/// the ticket, however many the server says it has.
class TicketChangeLineScreen extends ConsumerStatefulWidget {
  const TicketChangeLineScreen({super.key, required this.transactionCode});

  final String transactionCode;

  @override
  ConsumerState<TicketChangeLineScreen> createState() => _TicketChangeLineScreenState();
}

class _TicketChangeLineScreenState extends ConsumerState<TicketChangeLineScreen> {
  /// The new line for each place on the ticket that gets one.
  final _picked = <int, TransportLine>{};
  bool _saving = false;
  String? _error;

  Future<void> _pick(List<TransportLine> lines, int index) async {
    final after = linesAfter(lines, _picked);
    final picked = await Navigator.of(context).push<TransportLine>(
      MaterialPageRoute(
        builder: (context) => LineSearchScreen(
          replacing: lines[index].line ?? 0,
          // As the ticket will be: a line cannot be on it twice, and picking
          // the one this place shows would change nothing.
          onTicket: {for (final line in after) ?line.line},
        ),
      ),
    );
    if (picked == null || !mounted) {
      return;
    }
    setState(() {
      // Back to the ticket's own line is no change at all.
      if (picked.line == lines[index].line) {
        _picked.remove(index);
      } else {
        _picked[index] = picked;
      }
      _error = null;
    });
  }

  Future<void> _save(int transactionId, List<TransportLine> lines) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref
          .read(ekpClientProvider)
          .tickets
          .changeLine(transactionId: transactionId, lines: linesAfter(lines, _picked));
    } on Exception catch (exception) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = describeError(l10n, exception);
        });
      }
      return;
    }
    if (!mounted) {
      return;
    }
    // The ticket has changed everywhere it is shown.
    ref
      ..invalidate(ticketDetailProvider(widget.transactionCode))
      ..invalidate(ticketHistoryProvider);
    unawaited(ref.read(ticketSyncProvider.notifier).refresh());
    showAppSnackBar(messenger, l10n.lineChangeDone, kind: SnackKind.success);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detail = ref.watch(ticketDetailProvider(widget.transactionCode));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.ticketActionChangeLine)),
      body: switch (detail) {
        AsyncValue(value: final detail?) => _body(context, detail),
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

  Widget _body(BuildContext context, TicketDetailResponse detail) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final online = ref.watch(appStatusProvider.select((status) => status.mode == AppMode.online));
    final transactionId = detail.ticket?.transactionId;
    final lines = detail.ticketEkp?.lines ?? const <TransportLine>[];
    final single = lines.length == 1;
    final numbers = [for (final line in linesAfter(lines, _picked)) '${line.line ?? ''}'];

    Widget tile(int index) => _LineTile(
      line: _picked[index] ?? lines[index],
      replaced: _picked.containsKey(index) ? lines[index] : null,
      onTap: _saving ? null : () => unawaited(_pick(lines, index)),
    );

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              const AppStatusBanner(padding: EdgeInsets.only(bottom: 16)),
              TicketSummaryPanel(detail: detail),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 28, 4, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        single ? l10n.lineChangeYour : l10n.lineChangeWhich,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    Text(
                      single ? l10n.lineChangeYourHint : l10n.lineChangeWhichHint,
                      style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (single)
                tile(0)
              else
                Column(
                  spacing: 12,
                  children: [
                    for (var row = 0; row < lines.length; row += 2)
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 12,
                          children: [
                            Expanded(child: tile(row)),
                            Expanded(child: row + 1 < lines.length ? tile(row + 1) : const SizedBox.shrink()),
                          ],
                        ),
                      ),
                  ],
                ),
              if (_picked.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 20, 4, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Icon(Symbols.swap_horiz_rounded, size: 20, color: scheme.primary),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          numbers.length == 1
                              ? l10n.lineChangeSummaryOne(numbers.single)
                              : l10n.lineChangeSummaryMany(
                                  numbers.sublist(0, numbers.length - 1).join(', '),
                                  numbers.last,
                                ),
                          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 15, height: 22 / 15),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_error != null) ...[const SizedBox(height: 20), MessageBanner(_error!)],
            ],
          ),
        ),
        BottomActionBar(
          child: SubmitButton(
            label: l10n.lineSave,
            icon: Symbols.check_rounded,
            loading: _saving,
            loadingLabel: l10n.editSaving,
            onPressed: transactionId == null || _picked.isEmpty || !online
                ? null
                : () => unawaited(_save(transactionId, lines)),
          ),
        ),
      ],
    );
  }
}

/// One line of the ticket: tap it to put another in its place.
class _LineTile extends StatelessWidget {
  const _LineTile({required this.line, required this.replaced, required this.onTap});

  final TransportLine line;

  /// The ticket's line that [line] takes the place of; null while this
  /// place is as the ticket has it.
  final TransportLine? replaced;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final replaced = this.replaced;
    final changed = replaced != null;
    final kind = lineKind(l10n, line);
    // On the brand colour the fixed roles: primary would vanish there.
    final foreground = changed ? scheme.primaryFixed : scheme.onSurface;

    return Semantics(
      button: true,
      child: Material(
        color: changed ? scheme.primaryContainer : scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(28),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 152),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconTile(
                        lineIcon(line),
                        size: 40,
                        background: changed ? scheme.primaryFixed : scheme.surface,
                        foreground: changed ? scheme.onPrimaryFixed : scheme.primary,
                      ),
                      Icon(
                        changed ? Symbols.check_circle_rounded : Symbols.swap_horiz_rounded,
                        fill: changed ? 1 : 0,
                        color: changed ? scheme.primaryFixed : scheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${line.line ?? ''}',
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: foreground,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      Text(
                        changed ? l10n.lineReplaces(kind, '${replaced.line ?? ''}') : kind,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: changed ? FontWeight.w600 : FontWeight.w500,
                          color: changed ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
