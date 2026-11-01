import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/card_setup/utils/street_rank.dart';

void main() {
  test('streets starting with the query come first, then a word starting with it, then the rest', () {
    // The server's order: alphabetical, any street containing the query.
    const streets = [
      '6 SIERPNIA',
      'BŁOGOS. FRANCISZKI SIEDLISKIEJ',
      'BOŻEGO MIŁOSIERDZIA',
      'CIESIELSKA',
      'SIEDLECKA',
      'SIENKIEWICZA',
    ];
    expect(rankStreets(streets, 'sie'), [
      'SIEDLECKA',
      'SIENKIEWICZA',
      '6 SIERPNIA',
      'BŁOGOS. FRANCISZKI SIEDLISKIEJ',
      'BOŻEGO MIŁOSIERDZIA',
      'CIESIELSKA',
    ]);
  });

  test('Polish capitals match as typed in lower case', () {
    expect(rankStreets(['GÓRNIKÓW ŚLĄSKICH', 'ŚLĄSKA'], 'śl'), ['ŚLĄSKA', 'GÓRNIKÓW ŚLĄSKICH']);
  });

  test('words after a dot or a dash count as words', () {
    expect(rankStreets(['ABC', 'GEN. KLEEBERGA', 'BIAŁO-KLE'], 'kle'), ['GEN. KLEEBERGA', 'BIAŁO-KLE', 'ABC']);
  });

  test('nothing in, nothing out', () {
    expect(rankStreets([], 'sie'), isEmpty);
  });
}
