import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/router/routes.dart';

/// Opens the debug menu once [child] was tapped [taps] times in a row, no
/// more than [pause] apart. Nothing shows that it can be tapped.
class DebugMenuTrigger extends StatefulWidget {
  const DebugMenuTrigger({super.key, required this.child});

  static const taps = 11;

  /// A longer wait between two taps starts the count over.
  static const pause = Duration(seconds: 2);

  final Widget child;

  @override
  State<DebugMenuTrigger> createState() => _DebugMenuTriggerState();
}

class _DebugMenuTriggerState extends State<DebugMenuTrigger> {
  int _taps = 0;
  Timer? _reset;

  void _onTap() {
    _reset?.cancel();
    if (++_taps < DebugMenuTrigger.taps) {
      _reset = Timer(DebugMenuTrigger.pause, () => _taps = 0);
      return;
    }
    _taps = 0;
    unawaited(context.push(Routes.debug));
  }

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: _onTap, child: widget.child);
  }
}
