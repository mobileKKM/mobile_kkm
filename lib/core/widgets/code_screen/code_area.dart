import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_ring.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_state.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The code inside its draining ring, centred in the room it is given, with
/// a line under it saying what a tap does.
///
/// The code takes what there is, between [minSide] and [maxSide]: it is the
/// part of the screen that gives way when room is short.
class CodeArea extends StatelessWidget {
  const CodeArea({super.key, required this.state, required this.label, required this.onRetry, required this.onEnlarge});

  static const minSide = 176.0;
  static const maxSide = 340.0;

  /// The least height the area needs: the smallest code, the line under it
  /// and the space below.
  static const minHeight = minSide + _hintHeight + _bottom;

  static const _hintHeight = 32.0;
  static const _bottom = 12.0;

  // White in the dark theme too: a scanner needs the contrast.
  static const panelColor = Color(0xFFFFFFFF);

  final CodeState state;

  /// What a screen reader calls the code, given the time it has left.
  final String Function(String time) label;
  final VoidCallback onRetry;
  final VoidCallback onEnlarge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final state = this.state;
    final hint = switch (state) {
      CodeLoading() => (Symbols.hourglass_top_rounded, l10n.ticketControlGettingCode),
      CodeShown() => (Symbols.touch_app_rounded, l10n.ticketControlTapHint),
      CodeHidden() || CodeFailed() => null,
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: _bottom),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final room = constraints.maxHeight - _hintHeight;
          final side = (constraints.maxWidth < room ? constraints.maxWidth : room).clamp(minSide, maxSide);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox.square(
                dimension: side,
                child: switch (state) {
                  CodeFailed(:final message) => _Problem(message: message, onRetry: onRetry),
                  _ => _Box(state: state, side: side, label: label, onEnlarge: onEnlarge),
                },
              ),
              if (hint case (final icon, final text))
                SizedBox(
                  height: _hintHeight,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6,
                        children: [
                          Icon(icon, size: 18, color: scheme.onSurfaceVariant),
                          Text(
                            text,
                            maxLines: 1,
                            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// The ring and, inside it, the code or what stands in for it.
class _Box extends StatelessWidget {
  const _Box({required this.state, required this.side, required this.label, required this.onEnlarge});

  final CodeState state;
  final double side;
  final String Function(String time) label;
  final VoidCallback onEnlarge;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final state = this.state;
    // Drawn for the largest code; everything shrinks with it.
    final scale = side / CodeArea.maxSide;
    final running = state is CodeRunning ? state : null;

    final Widget panel = switch (state) {
      CodeShown(:final code) => Container(
        decoration: BoxDecoration(color: CodeArea.panelColor, borderRadius: BorderRadius.circular(20 * scale)),
        padding: EdgeInsets.all(18 * scale),
        child: code,
      ),
      CodeHidden() => Container(
        decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(20 * scale)),
        padding: EdgeInsets.all(24 * scale),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Icon(Symbols.visibility_off_rounded, size: 32, color: scheme.onSurfaceVariant),
              Text(l10n.ticketControlCaptureHidden, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ),
      _ => Container(
        decoration: BoxDecoration(color: CodeArea.panelColor, borderRadius: BorderRadius.circular(20 * scale)),
        alignment: Alignment.center,
        child: SizedBox.square(
          dimension: 48,
          // On white in both themes, so the brand colour in both.
          child: CircularProgressIndicator(strokeWidth: 4, color: scheme.primaryContainer),
        ),
      ),
    };

    final box = CodeRing(
      id: running?.id,
      left: running?.left ?? 0,
      leftNext: running?.leftNext ?? 0,
      since: running?.since,
      track: scheme.secondaryContainer,
      color: running != null && running.low ? scheme.error : scheme.primary,
      stroke: 10 * scale,
      radius: 34 * scale,
      child: Padding(padding: EdgeInsets.all(20 * scale), child: panel),
    );
    if (state is! CodeShown) {
      return box;
    }
    // One button for a screen reader; the time is only read out by itself
    // when little of it is left.
    return Semantics(
      container: true,
      button: true,
      liveRegion: state.low,
      label: label(state.time),
      onTap: onEnlarge,
      excludeSemantics: true,
      child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: onEnlarge, child: box),
    );
  }
}

/// In the code's place when there is none: why, and a way to try again.
/// Neither ring nor hint: there is nothing to count down.
class _Problem extends StatelessWidget {
  const _Problem({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(34)),
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Icon(Symbols.cloud_off_rounded, size: 32, color: scheme.onSurfaceVariant),
            Text(message, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
            FilledButton.tonalIcon(
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 40),
                padding: const EdgeInsetsDirectional.only(start: 16, end: 20),
                iconSize: 18,
                textStyle: theme.textTheme.labelLarge,
              ),
              onPressed: onRetry,
              icon: const Icon(Symbols.refresh_rounded),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
