/// Mixin for response models carrying the API's `{code, message}` envelope.
///
/// `code` is polymorphic across the API (int / String / null) and is even
/// non-null on some successful responses (ticket-sales-configuration returns
/// `code: 1` with HTTP 200), so no automatic "isError" semantics are attached
/// here — use HTTP status (via [EkpApiException]) as the error signal.
mixin EkpCodeMessage {
  /// Business status code: `int`, `String` or `null`.
  Object? get code;

  /// Server-provided human readable message, usually non-null on errors.
  String? get message;

  /// [code] as int when numeric, otherwise null.
  int? get codeAsInt => switch (code) {
    final int v => v,
    final num v => v.toInt(),
    _ => null,
  };

  /// [code] as String when it is a string, otherwise null.
  String? get codeAsString => switch (code) {
    final String v => v,
    _ => null,
  };
}
