import 'dart:convert';

/// Base64 exactly as Android's `Base64.encodeToString(.., Base64.DEFAULT)`
/// (flag 0) produces it: lines of 76 characters separated by `\n`, plus a
/// trailing `\n`. Equivalent to Python's `base64.encodebytes`.
///
/// This byte-for-byte shape matters: the official client embeds the wrapped
/// string in the JSON body (`{"message": "<b64>"}`), where each newline is
/// escaped to `\n` — an assign-e body is exactly 368 chars that way
/// (12 + 344 b64 + 5×2 escaped newlines + 2).
String encodeAndroidDefault(List<int> bytes) {
  final b64 = base64Encode(bytes);
  final buffer = StringBuffer();
  for (var i = 0; i < b64.length; i += 76) {
    final end = i + 76 < b64.length ? i + 76 : b64.length;
    buffer
      ..write(b64.substring(i, end))
      ..write('\n');
  }
  return buffer.toString();
}
