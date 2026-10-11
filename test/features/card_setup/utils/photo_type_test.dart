import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/card_setup/utils/photo_type.dart';

void main() {
  test('a photo is known by how the file begins', () {
    expect(photoTypeOf([0xFF, 0xD8, 0xFF, 0xE0, 0, 0]), PhotoType.jpeg);
    expect(photoTypeOf([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0]), PhotoType.png);
    expect(photoTypeOf([...'RIFF'.codeUnits, 1, 2, 3, 4, ...'WEBP'.codeUnits]), PhotoType.webp);
  });

  test('anything else is refused', () {
    expect(photoTypeOf([]), isNull);
    expect(photoTypeOf([0xFF, 0xD8]), isNull);
    // A sound file is RIFF too.
    expect(photoTypeOf([...'RIFF'.codeUnits, 1, 2, 3, 4, ...'WAVE'.codeUnits]), isNull);
    expect(photoTypeOf('GIF89a'.codeUnits), isNull);
  });
}
