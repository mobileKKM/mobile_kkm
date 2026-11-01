final _wordBreak = RegExp(r'[\s.\-]+');

/// The server's streets for [query], those starting with it first, then
/// those with a word starting with it, then the rest; each group keeps the
/// server's order. Nothing is dropped: the server decided what matches,
/// letter for letter ("sla" finds no "ŚLĄSKA"), so case is all that differs.
List<String> rankStreets(List<String> streets, String query) {
  final typed = query.trim().toLowerCase();
  int rank(String street) {
    final name = street.toLowerCase();
    if (name.startsWith(typed)) {
      return 0;
    }
    if (name.split(_wordBreak).any((word) => word.startsWith(typed))) {
      return 1;
    }
    return 2;
  }

  final ranked = [for (final (index, street) in streets.indexed) (rank(street), index, street)]
    ..sort((a, b) => a.$1 != b.$1 ? a.$1.compareTo(b.$1) : a.$2.compareTo(b.$2));
  return [for (final (_, _, street) in ranked) street];
}
