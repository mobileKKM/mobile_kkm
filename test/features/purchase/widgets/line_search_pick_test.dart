import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/features/tickets/screens/line_search_screen.dart';

import '../../../support/fake_adapter.dart';
import '../../../support/harness.dart';

Future<Future<List<TransportLine>?>> _open(
  WidgetTester tester, {
  int max = 1,
  List<TransportLine> picked = const [],
}) async {
  final navigator = Navigator.of(tester.element(find.byType(Scaffold).first));
  final result = navigator.push<List<TransportLine>>(
    MaterialPageRoute(
      builder: (_) => LineSearchScreen.pick(max: max, picked: picked),
    ),
  );
  await tester.pumpAndSettle();
  return result;
}

Future<void> _search(WidgetTester tester, String number) async {
  await tester.enterText(find.byType(TextField), number);
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pumpAndSettle();
}

void main() {
  late FakeAdapter adapter;

  setUp(() {
    adapter = FakeAdapter()
      ..reply('GET', '/dictionary/transport-line', 200, {
        'lines': [
          {'line': 5, 'second_zone': false, 'is_tram': true, 'is_bus': false},
          {'line': 52, 'second_zone': false, 'is_tram': true, 'is_bus': false},
          {'line': 502, 'second_zone': true, 'is_tram': false, 'is_bus': true},
        ],
      });
  });

  testWidgets('picks up to the limit and hands them back on Done', (tester) async {
    await pumpApp(tester, adapter, session: signedInSession);
    final result = await _open(tester);
    expect(find.text('Chosen 0 of 1'), findsOneWidget);

    await _search(tester, '5');
    expect(find.text('Tram · Strefa I'), findsNWidgets(2));
    expect(find.text('Bus · also Strefa II'), findsOneWidget);

    await tester.tap(find.text('52'));
    await tester.pump();
    expect(find.text('Chosen 1 of 1'), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox).at(1)).value, isTrue);
    // The limit is reached: the others wait until one is removed.
    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).onChanged, isNull);
    await tester.tap(find.text('5').last);
    await tester.pump();
    expect(find.text('Chosen 1 of 1'), findsOneWidget);

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect((await result)?.map((line) => line.line), [52]);
  });

  testWidgets('a picked line can be removed from its chip', (tester) async {
    await pumpApp(tester, adapter, session: signedInSession);
    final result = await _open(tester, picked: const [TransportLine(line: 52, isTram: true)]);
    expect(find.text('Chosen 1 of 1'), findsOneWidget);

    await tester.tap(find.byTooltip('Remove line 52'));
    await tester.pump();
    expect(find.text('Chosen 0 of 1'), findsOneWidget);

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(await result, isEmpty);
  });

  testWidgets('back leaves without a result', (tester) async {
    await pumpApp(tester, adapter, session: signedInSession);
    final result = await _open(tester);
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(await result, isNull);
  });
}
