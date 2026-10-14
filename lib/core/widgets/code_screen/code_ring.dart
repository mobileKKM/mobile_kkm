import 'dart:async';

import 'package:material_ui/material_ui.dart';

/// The outline of a code's box as its timer: full at the start, its end
/// drawing back towards twelve o'clock.
class CodeRing extends StatefulWidget {
  const CodeRing({
    super.key,
    required this.id,
    required this.left,
    required this.leftNext,
    required this.track,
    required this.color,
    required this.stroke,
    required this.radius,
    this.child,
  });

  /// The code the ring counts for.
  final Object? id;

  /// The share of the code's time still ahead.
  final double left;

  /// What [left] will be a second from now. The ring spends the second on
  /// its way there, so that it is empty when the time is, not a second late.
  final double leftNext;
  final Color track;
  final Color color;
  final double stroke;

  /// The corner of the box the ring runs around.
  final double radius;
  final Widget? child;

  @override
  State<CodeRing> createState() => _CodeRingState();
}

class _CodeRingState extends State<CodeRing> with SingleTickerProviderStateMixin {
  static const _sweepTime = Duration(milliseconds: 300);

  late final AnimationController _shown = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    _run();
  }

  @override
  void didUpdateWidget(CodeRing old) {
    super.didUpdateWidget(old);
    // Not on every rebuild: one in the middle of a second leaves the ring
    // on its way.
    if (widget.id != old.id || widget.left != old.left || widget.leftNext != old.leftNext) {
      // A renewed code fills the ring in from empty; the first one, after
      // loading, starts full at once.
      _run(sweepIn: old.id != null && widget.id != null && widget.id != old.id);
    }
  }

  /// Starts the second over: from where the time is, to where it will be.
  ///
  /// From where the time is, not from where the ring happens to stand. The
  /// two are the same while the ring runs. They are not after it stood
  /// still, under another route or with the app in the background, and
  /// then the ring is where it belongs at once instead of hurrying there.
  /// A new code starts at its own share the same way.
  void _run({bool sweepIn = false}) {
    final run = ++_runs;
    if (sweepIn) {
      _shown.value = 0;
      unawaited(_sweep(run));
      return;
    }
    _drain();
  }

  /// Which start-over is the latest, for a sweep that was overtaken.
  int _runs = 0;

  Future<void> _sweep(int run) async {
    await _shown.animateTo(widget.left, duration: _sweepTime, curve: Curves.easeOut);
    // Another second began meanwhile and has taken over.
    if (mounted && run == _runs) {
      // The rest of the second, so it still ends where the next one starts.
      _drain(const Duration(seconds: 1) - _sweepTime);
    }
  }

  void _drain([Duration duration = const Duration(seconds: 1)]) {
    _shown.value = widget.left;
    // A second per second: the ring moves evenly, not in jumps.
    unawaited(_shown.animateTo(widget.leftNext, duration: duration));
  }

  @override
  void dispose() {
    _shown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shown,
      builder: (context, child) => CustomPaint(
        painter: _RingPainter(
          left: _shown.value,
          track: widget.track,
          color: widget.color,
          stroke: widget.stroke,
          radius: widget.radius,
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.left,
    required this.track,
    required this.color,
    required this.stroke,
    required this.radius,
  });

  final double left;
  final Color track;
  final Color color;
  final double stroke;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(stroke / 2);
    // The box's own corner, less half the stroke.
    final corner = Radius.circular(radius - stroke / 2);
    // From twelve o'clock, clockwise: what is left of the time is what is
    // left of the outline, counted from its start.
    final outline = Path()
      ..moveTo(rect.center.dx, rect.top)
      ..lineTo(rect.right - corner.x, rect.top)
      ..arcToPoint(Offset(rect.right, rect.top + corner.y), radius: corner)
      ..lineTo(rect.right, rect.bottom - corner.y)
      ..arcToPoint(Offset(rect.right - corner.x, rect.bottom), radius: corner)
      ..lineTo(rect.left + corner.x, rect.bottom)
      ..arcToPoint(Offset(rect.left, rect.bottom - corner.y), radius: corner)
      ..lineTo(rect.left, rect.top + corner.y)
      ..arcToPoint(Offset(rect.left + corner.x, rect.top), radius: corner)
      ..close();
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(outline, paint..color = track);
    if (left <= 0) {
      return;
    }
    final metric = outline.computeMetrics().first;
    canvas.drawPath(metric.extractPath(0, metric.length * left.clamp(0, 1)), paint..color = color);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.left != left || old.track != track || old.color != color || old.stroke != stroke || old.radius != radius;
}
