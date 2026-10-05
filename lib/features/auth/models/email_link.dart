enum EmailLinkKind { activate, resetPassword }

/// An account link from an EKP e-mail:
/// `https://ekp.mpk.krakow.pl/konto-uzytkownika/activate,<token>.html` or
/// `.../konto-uzytkownika/reset,<token>.html`.
class EmailLink {
  const EmailLink(this.kind, this.token);

  final EmailLinkKind kind;
  final String token;

  static final _pattern = RegExp(r'^/konto-uzytkownika/(activate|reset),([^/,.]+)(?:\.html)?/?$');

  /// Parses [uri]'s path; the host is not checked because Flutter's deep
  /// linking only forwards path and query.
  static EmailLink? tryParse(Uri uri) {
    final match = _pattern.firstMatch(uri.path);
    if (match == null) return null;
    final kind = match.group(1) == 'activate' ? EmailLinkKind.activate : EmailLinkKind.resetPassword;
    return EmailLink(kind, Uri.decodeComponent(match.group(2)!));
  }
}
