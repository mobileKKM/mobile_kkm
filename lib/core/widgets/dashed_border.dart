import 'package:material_ui/material_ui.dart';

/// A dashed rounded outline, for a place where something is missing.
class DashedBorder extends StatelessWidget {
  const DashedBorder({super.key, required this.child, this.radius = 28, this.color, this.background});

  final Widget child;
  final double radius;

  /// outlineVariant unless given.
  final Color? color;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CustomPaint(
      painter: _DashedBorderPainter(
        radius: radius,
        color: color ?? scheme.outlineVariant,
        background: background ?? scheme.surfaceContainerLow,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.radius, required this.color, required this.background});

  final double radius;
  final Color color;
  final Color background;

  static const _width = 2.0;
  static const _dash = 6.0;
  static const _gap = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    final shape = RRect.fromRectAndRadius((Offset.zero & size).deflate(_width / 2), Radius.circular(radius));
    canvas.drawRRect(shape, Paint()..color = background);
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _width;
    for (final metric in (Path()..addRRect(shape)).computeMetrics()) {
      for (var at = 0.0; at < metric.length; at += _dash + _gap) {
        canvas.drawPath(metric.extractPath(at, at + _dash), stroke);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.radius != radius || old.color != color || old.background != background;
}
