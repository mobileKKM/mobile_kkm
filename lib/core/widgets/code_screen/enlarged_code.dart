import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_area.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_ring.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_state.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Shows the code of a `CodeScreen` as large as the phone allows, on white,
/// with the name and customer number so that it is still clear whose it is.
///
/// It is the same code with the same timer: [state] is the screen's own,
/// and nothing is fetched. The screen stays open underneath, and with it
/// whatever it does to the display.
Future<void> showEnlargedCode(
  BuildContext context, {
  required ValueListenable<CodeState> state,
  required String name,
  required String? customerCode,
}) => Navigator.of(context).push<void>(
  PageRouteBuilder(
    fullscreenDialog: true,
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 150),
    pageBuilder: (context, _, _) => _EnlargedCode(state: state, name: name, customerCode: customerCode),
    transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
  ),
);

// White in both themes, so nothing here follows the theme.
const _ink = Color(0xFF1B1B21);
const _quietInk = Color(0xFF454652);
const _track = Color(0xFFCDD1FF);
const _progress = Color(0xFF303F9F);
const _warning = Color(0xFFBA1A1A);

class _EnlargedCode extends StatefulWidget {
  const _EnlargedCode({required this.state, required this.name, required this.customerCode});

  final ValueListenable<CodeState> state;
  final String name;
  final String? customerCode;

  @override
  State<_EnlargedCode> createState() => _EnlargedCodeState();
}

class _EnlargedCodeState extends State<_EnlargedCode> {
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onState);
  }

  @override
  void dispose() {
    widget.state.removeListener(_onState);
    super.dispose();
  }

  /// Without a code to show there is nothing to enlarge: back to the screen
  /// that says why.
  void _onState() {
    if (widget.state.value is! CodeShown) {
      _close();
    }
  }

  void _close() {
    if (_closing || !mounted) {
      return;
    }
    _closing = true;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final customerCode = widget.customerCode;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        // The navigation bar's buttons too: in the dark theme they are
        // light, and would vanish on the white.
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: CodeArea.panelColor,
        // Anywhere at all closes it, and so does a swipe down.
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _close,
          onVerticalDragEnd: (details) {
            if ((details.primaryVelocity ?? 0) > 0) {
              _close();
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 64),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        IconButton(
                          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                          color: _ink,
                          icon: const Icon(Symbols.close_fullscreen_rounded),
                          onPressed: _close,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 18,
                                  height: 24 / 18,
                                  color: _ink,
                                ),
                              ),
                              if (customerCode != null)
                                Text(
                                  l10n.homeCustomerCode(customerCode),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: 13,
                                    height: 18 / 13,
                                    color: _quietInk,
                                    fontFeatures: const [FontFeature.tabularFigures()],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // As wide as the phone, unless that is taller than
                        // the room there is.
                        final side = math.max(0.0, math.min(constraints.maxWidth, constraints.maxHeight - _below));
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox.square(
                              dimension: side,
                              child: ValueListenableBuilder(
                                valueListenable: widget.state,
                                builder: (context, state, _) => _code(state, side),
                              ),
                            ),
                            SizedBox(
                              height: _below,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  l10n.ticketControlTapClose,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(color: _quietInk),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// The gap under the code and the line that follows it.
  static const _below = 40.0;

  Widget _code(CodeState state, double side) {
    // On its way out: see _onState.
    if (state is! CodeShown) {
      return const SizedBox.shrink();
    }
    final scale = side / CodeArea.maxSide;
    return CodeRing(
      id: state.id,
      left: state.left,
      leftNext: state.leftNext,
      track: _track,
      color: state.low ? _warning : _progress,
      stroke: 8 * scale,
      radius: 34 * scale,
      child: Padding(
        // The white around a code is part of it: a scanner needs it.
        padding: EdgeInsets.all((20 + 0.04 * (CodeArea.maxSide - 40)) * scale),
        child: ExcludeSemantics(child: state.code),
      ),
    );
  }
}
