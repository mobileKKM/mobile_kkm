import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_ring.dart';

Widget _ring({required double left, required double leftNext, required DateTime since}) => Center(
  child: SizedBox.square(
    dimension: 200,
    child: CodeRing(
      id: 'code',
      left: left,
      leftNext: leftNext,
      since: since,
      track: Colors.grey,
      color: Colors.indigo,
      stroke: 8,
      radius: 34,
    ),
  ),
);

/// The share of the outline the ring draws.
double _drawn(WidgetTester tester) {
  final paint = tester.widget<CustomPaint>(
    find.descendant(of: find.byType(CodeRing), matching: find.byType(CustomPaint)),
  );
  // The painter is the ring's own; its share is all the test needs of it.
  return (paint.painter! as dynamic).left as double;
}

void main() {
  testWidgets('a ring built part-way through a second starts where the second has got to', (tester) async {
    await tester.pumpWidget(
      _ring(left: 0.5, leftNext: 0.4, since: clock.now().subtract(const Duration(milliseconds: 500))),
    );
    expect(_drawn(tester), closeTo(0.45, 0.001));

    // Where the next second starts, so that it does not make the ring jump.
    await tester.pump(const Duration(milliseconds: 500));
    expect(_drawn(tester), closeTo(0.4, 0.001));
  });

  testWidgets('each second starts from where the time is', (tester) async {
    await tester.pumpWidget(_ring(left: 0.5, leftNext: 0.4, since: clock.now()));
    expect(_drawn(tester), closeTo(0.5, 0.001));

    await tester.pump(const Duration(milliseconds: 300));
    // The next second, counted a little while ago.
    await tester.pumpWidget(
      _ring(left: 0.4, leftNext: 0.3, since: clock.now().subtract(const Duration(milliseconds: 200))),
    );
    expect(_drawn(tester), closeTo(0.38, 0.001));

    await tester.pump(const Duration(milliseconds: 800));
    expect(_drawn(tester), closeTo(0.3, 0.001));
  });

  testWidgets('a second that is long over leaves the ring where it was heading', (tester) async {
    await tester.pumpWidget(_ring(left: 0.5, leftNext: 0.4, since: clock.now().subtract(const Duration(seconds: 5))));
    expect(_drawn(tester), closeTo(0.4, 0.001));
  });
}
