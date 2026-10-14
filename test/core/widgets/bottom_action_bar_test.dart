import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/bottom_action_bar.dart';

void main() {
  for (final inset in [0.0, 24.0, 48.0]) {
    testWidgets('the button is 12 dp above a bottom inset of $inset', (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(
            size: const Size(400, 800),
            padding: EdgeInsets.only(bottom: inset),
            viewPadding: EdgeInsets.only(bottom: inset),
          ),
          child: const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  Expanded(child: SizedBox()),
                  BottomActionBar(child: SizedBox(key: Key('button'), height: 56)),
                ],
              ),
            ),
          ),
        ),
      );

      expect(tester.getBottomLeft(find.byKey(const Key('button'))).dy, 800 - inset - 12);
    });
  }
}
