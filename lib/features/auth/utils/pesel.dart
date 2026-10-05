/// PESEL — the Polish national identification number (11 digits).
abstract final class Pesel {
  static const _weights = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3];

  /// Whether [value] is 11 digits with a correct checksum and encodes a
  /// real calendar date.
  static bool isValid(String value) => birthDate(value) != null;

  /// The birth date encoded in [value], or null when it is not a valid
  /// PESEL.
  ///
  /// The century is folded into the month: 01–12 → 1900s, 21–32 → 2000s,
  /// 41–52 → 2100s, 61–72 → 2200s, 81–92 → 1800s.
  static DateTime? birthDate(String value) {
    if (value.length != 11) {
      return null;
    }
    final digits = <int>[];
    for (final unit in value.codeUnits) {
      final digit = unit - 0x30;
      if (digit < 0 || digit > 9) {
        return null;
      }
      digits.add(digit);
    }

    var sum = 0;
    for (var i = 0; i < 10; i++) {
      sum += digits[i] * _weights[i];
    }
    if ((10 - sum % 10) % 10 != digits[10]) {
      return null;
    }

    final yy = digits[0] * 10 + digits[1];
    final mm = digits[2] * 10 + digits[3];
    final dd = digits[4] * 10 + digits[5];
    final century = switch (mm ~/ 20) {
      0 => 1900,
      1 => 2000,
      2 => 2100,
      3 => 2200,
      4 => 1800,
      _ => null,
    };
    if (century == null) {
      return null;
    }
    final year = century + yy;
    final month = mm % 20;

    final date = DateTime(year, month, dd);
    // DateTime normalises overflow (e.g. 31 February), so compare back.
    if (date.year != year || date.month != month || date.day != dd) {
      return null;
    }
    return date;
  }
}
