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
class LineSearchScreen extends ConsumerStatefulWidget {
  const LineSearchScreen({super.key, required this.replacing, required this.onTicket});

  /// The number of the line that is given up.
  final int replacing;

  /// The numbers the ticket will have besides: those cannot be picked.
  final Set<int> onTicket;

  @override
  ConsumerState<LineSearchScreen> createState() => _LineSearchScreenState();
}

class _LineSearchScreenState extends ConsumerState<LineSearchScreen> {
  static const _pause = Duration(milliseconds: 300);

  final _query = TextEditingController();
  Timer? _debounce;

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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Container(
                  height: 32,
                  padding: const EdgeInsetsDirectional.only(start: 8, end: 12),
                  decoration: BoxDecoration(color: scheme.secondaryContainer, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Symbols.swap_horiz_rounded, size: 18, color: scheme.onSecondaryContainer),
                      const SizedBox(width: 6),
                      Text(
                        l10n.lineReplacing('${widget.replacing}'),
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
  });

  final TransportLine line;
  final bool first;
  final bool last;

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
    return Opacity(
      opacity: onTicket ? 0.5 : 1,
      child: Material(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.vertical(top: first ? outer : inner, bottom: last ? outer : inner),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTicket ? null : onTap,
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
                    child: Text(
                      lineKind(l10n, line),
                      style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                    ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
