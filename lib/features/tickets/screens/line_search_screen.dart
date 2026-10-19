import 'dart:async';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The icon of a line's vehicle.
IconData lineIcon(TransportLine line) => (line.isTram ?? false) ? Symbols.tram_rounded : Symbols.directions_bus_rounded;

/// The word for a line's vehicle.
String lineKind(AppLocalizations l10n, TransportLine line) => (line.isTram ?? false) ? l10n.lineTram : l10n.lineBus;

/// Finds a line by its number, to take the place of [replacing] on a ticket.
/// Pops with the line that was picked.
///
/// [LineSearchScreen.pick] picks up to [max] lines for a new ticket instead,
/// and pops with all of them on Done.
class LineSearchScreen extends ConsumerStatefulWidget {
  const LineSearchScreen({super.key, required int this.replacing, required this.onTicket})
    : max = null,
      picked = const [];

  const LineSearchScreen.pick({super.key, required int this.max, this.picked = const [], this.onTicket = const {}})
    : replacing = null;

  /// The number of the line that is given up.
  final int? replacing;

  /// The numbers the ticket will have besides: those cannot be picked.
  final Set<int> onTicket;

  /// How many lines can be picked; null when replacing one.
  final int? max;

  /// The lines picked so far.
  final List<TransportLine> picked;

  @override
  ConsumerState<LineSearchScreen> createState() => _LineSearchScreenState();
}

class _LineSearchScreenState extends ConsumerState<LineSearchScreen> {
  static const _pause = Duration(milliseconds: 300);

  final _query = TextEditingController();
  Timer? _debounce;
  late final List<TransportLine> _picked = [...widget.picked];

  /// What the server found for the number as it stands; null before the
  /// first answer and while the field is empty.
  List<TransportLine>? _lines;
  bool _searching = false;
  bool _failed = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _query.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    final number = value.trim();
    if (number.isEmpty) {
      setState(() {
        _lines = null;
        _searching = false;
        _failed = false;
      });
      return;
    }
    setState(() => _searching = true);
    _debounce = Timer(_pause, () => unawaited(_search(number)));
  }

  Future<void> _search(String number) async {
    List<TransportLine>? lines;
    try {
      lines = (await ref.read(ekpClientProvider).dictionaries.transportLines(number)).lines;
    } catch (_) {
      // Said under the field; typing on asks again.
    }
    // Typed on in the meantime: the next answer is the one that counts.
    if (!mounted || _query.text.trim() != number) {
      return;
    }
    setState(() {
      _lines = lines;
      _searching = false;
      _failed = lines == null;
    });
  }

  void _clear() {
    _query.clear();
    _onChanged('');
  }

  bool _isPicked(TransportLine line) => _picked.any((picked) => picked.line == line.line);

  void _toggle(TransportLine line) {
    setState(() {
      if (_isPicked(line)) {
        _picked.removeWhere((picked) => picked.line == line.line);
      } else if (_picked.length < widget.max!) {
        _picked.add(line);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final lines = _lines;
    final quiet = theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Material(
                color: scheme.surfaceContainerHigh,
                shape: const StadiumBorder(),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      IconButton(
                        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                        icon: const Icon(Symbols.arrow_back_rounded),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          controller: _query,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.search,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                            height: 28 / 20,
                            fontWeight: FontWeight.w500,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                          decoration: InputDecoration(
                            hintText: l10n.lineSearchHint,
                            hintStyle: theme.textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isCollapsed: true,
                          ),
                          onChanged: _onChanged,
                        ),
                      ),
                      if (_query.text.isNotEmpty)
                        IconButton(
                          tooltip: l10n.lineSearchClear,
                          color: scheme.onSurfaceVariant,
                          icon: const Icon(Symbols.close_rounded),
                          onPressed: _clear,
                        ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.max case final max?)
              _PickedBar(
                picked: _picked,
                max: max,
                onRemove: (line) => setState(() => _picked.removeWhere((p) => p.line == line.line)),
                onDone: () => Navigator.of(context).pop(List<TransportLine>.unmodifiable(_picked)),
              )
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    height: 32,
                    padding: const EdgeInsetsDirectional.only(start: 8, end: 12),
                    decoration: BoxDecoration(
                      color: scheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Symbols.swap_horiz_rounded, size: 18, color: scheme.onSecondaryContainer),
                        const SizedBox(width: 6),
                        Text(
                          l10n.lineReplacing('${widget.replacing ?? ''}'),
                          style: theme.textTheme.labelLarge?.copyWith(color: scheme.onSecondaryContainer),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // Only before the first answer: after it the rows stay until the next.
            if (_searching && lines == null)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: LinearProgressIndicator(minHeight: 4, borderRadius: BorderRadius.all(Radius.circular(2))),
              ),
            Expanded(
              child: lines == null
                  ? _failed
                        ? _Note(l10n.lineSearchFailed, style: quiet)
                        : const SizedBox.shrink()
                  : lines.isEmpty
                  ? _Note(l10n.lineSearchNone(_query.text.trim()), style: quiet)
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: lines.length,
                      separatorBuilder: (context, _) => const SizedBox(height: 2),
                      itemBuilder: (context, index) {
                        final line = lines[index];
                        final max = widget.max;
                        if (max != null) {
                          final picked = _isPicked(line);
                          return _LineRow(
                            line: line,
                            first: index == 0,
                            last: index == lines.length - 1,
                            onTicket: widget.onTicket.contains(line.line),
                            picked: picked,
                            full: !picked && _picked.length >= max,
                            onTap: () => _toggle(line),
                          );
                        }
                        return _LineRow(
                          line: line,
                          first: index == 0,
                          last: index == lines.length - 1,
                          onTicket: widget.onTicket.contains(line.line),
                          onTap: () => Navigator.of(context).pop(line),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text, {required this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        child: Text(text, textAlign: TextAlign.center, style: style),
      ),
    );
  }
}

/// One line the search found.
class _LineRow extends StatelessWidget {
  const _LineRow({
    required this.line,
    required this.first,
    required this.last,
    required this.onTicket,
    required this.onTap,
    this.picked,
    this.full = false,
  });

  final TransportLine line;
  final bool first;
  final bool last;

  /// Picking several: whether this one is among them (a checkbox shows).
  final bool? picked;

  /// Picking several: as many as allowed are picked, and not this one.
  final bool full;

  /// Already on the ticket: shown, so that it is not looked for, but not
  /// to be picked.
  final bool onTicket;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    const inner = Radius.circular(6);
    const outer = Radius.circular(20);
    final picked = this.picked;
    final enabled = !onTicket && !full;
    final kind = picked == null
        ? lineKind(l10n, line)
        : '${lineKind(l10n, line)} · ${(line.secondZone ?? false) ? l10n.lineAlsoZoneII : l10n.lineZoneI}';
    return Opacity(
      opacity: onTicket || full ? 0.5 : 1,
      child: Material(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.vertical(top: first ? outer : inner, bottom: last ? outer : inner),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 64),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 12, end: 16),
              child: Row(
                children: [
                  IconTile(lineIcon(line), size: 40),
                  const SizedBox(width: 14),
                  SizedBox(
                    width: 56,
                    child: Text(
                      '${line.line ?? ''}',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                      style: theme.textTheme.titleLarge?.copyWith(fontFeatures: const [FontFeature.tabularFigures()]),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(kind, style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant)),
                  ),
                  if (onTicket) ...[
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        l10n.lineOnTicket,
                        textAlign: TextAlign.end,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 13,
                          height: 18 / 13,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                  if (picked != null) ...[
                    const SizedBox(width: 8),
                    ExcludeSemantics(
                      child: Checkbox(value: picked, onChanged: enabled ? (_) => onTap() : null),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Picking several lines: how many are picked, their chips and Done.
class _PickedBar extends StatelessWidget {
  const _PickedBar({required this.picked, required this.max, required this.onRemove, required this.onDone});

  final List<TransportLine> picked;
  final int max;
  final ValueChanged<TransportLine> onRemove;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Semantics(
                  liveRegion: true,
                  child: Text(
                    l10n.lineChosen(picked.length, max),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 13,
                      height: 18 / 13,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                for (final line in picked)
                  Container(
                    height: 32,
                    padding: const EdgeInsetsDirectional.only(start: 12, end: 2),
                    decoration: BoxDecoration(color: scheme.secondaryContainer, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${line.line ?? ''}',
                          style: theme.textTheme.labelLarge?.copyWith(color: scheme.onSecondaryContainer),
                        ),
                        IconButton(
                          tooltip: l10n.lineRemove('${line.line ?? ''}'),
                          iconSize: 18,
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints.tightFor(width: 28, height: 28),
                          color: scheme.onSecondaryContainer,
                          icon: const Icon(Symbols.close_rounded),
                          onPressed: () => onRemove(line),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, 40),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              textStyle: theme.textTheme.labelLarge,
            ),
            onPressed: onDone,
            child: Text(l10n.lineDone),
          ),
        ],
      ),
    );
  }
}
