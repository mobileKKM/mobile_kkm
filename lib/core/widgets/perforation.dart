import 'package:material_ui/material_ui.dart';

/// The tear-off line between a ticket and its stub: a notch at either edge
/// and a dashed line between them.
class Perforation extends StatelessWidget {
  const Perforation({super.key, required this.line, required this.notch, this.height = 24});

  final Color line;

  /// The colour of what the card lies on.
  final Color notch;

  /// Also the notches' diameter.
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: CustomPaint(
      painter: _PerforationPainter(line: line, notch: notch),
    ),
  );
}

class _PerforationPainter extends CustomPainter {
  const _PerforationPainter({required this.line, required this.notch});

  final Color line;
  final Color notch;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;
    final radius = size.height / 2;
    final fill = Paint()..color = notch;
    canvas
      ..drawCircle(Offset(0, y), radius, fill)
      ..drawCircle(Offset(size.width, y), radius, fill);
    final stroke = Paint()
      ..color = line
      ..strokeWidth = 2;
    final inset = radius + 10;
    for (var x = inset; x < size.width - inset; x += 10) {
      canvas.drawLine(Offset(x, y), Offset(x + 6 > size.width - inset ? size.width - inset : x + 6, y), stroke);
    }
  }

  @override
  bool shouldRepaint(_PerforationPainter old) => old.line != line || old.notch != notch;
}
