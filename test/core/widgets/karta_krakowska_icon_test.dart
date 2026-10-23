import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/karta_krakowska_icon.dart';

void main() {
  testWidgets('follows the icon theme inside an IconTile.glyph', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: IconTile.glyph(KartaKrakowskaIcon(), iconSize: 24, foreground: Color(0xFF123456))),
      ),
    );
    await tester.pump();

    expect(tester.getSize(find.byType(KartaKrakowskaIcon)), const Size.square(24));
    final picture = tester.widget<SvgPicture>(find.byType(SvgPicture));
    expect(picture.colorFilter, const ColorFilter.mode(Color(0xFF123456), BlendMode.srcIn));
  });
}
