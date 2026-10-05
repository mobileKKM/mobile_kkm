import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_kkm/features/auth/utils/pesel.dart';

void main() {
  test('derives a 1900s birth date', () {
    expect(Pesel.birthDate('44051401359'), DateTime(1944, 5, 14));
  });

  test('month + 20 means the 2000s', () {
    expect(Pesel.birthDate('02270803624'), DateTime(2002, 7, 8));
  });

  test('month + 80 means the 1800s', () {
    expect(Pesel.birthDate('99923100007'), DateTime(1899, 12, 31));
  });

  test('rejects a wrong checksum', () {
    expect(Pesel.isValid('44051401358'), isFalse);
  });

  test('rejects an impossible date despite a correct checksum', () {
    // 31 February 1999.
    expect(Pesel.isValid('99023100000'), isFalse);
  });

  test('rejects wrong length and non-digits', () {
    expect(Pesel.isValid(''), isFalse);
    expect(Pesel.isValid('4405140135'), isFalse);
    expect(Pesel.isValid('440514013599'), isFalse);
    expect(Pesel.isValid('4405140135a'), isFalse);
  });
}
