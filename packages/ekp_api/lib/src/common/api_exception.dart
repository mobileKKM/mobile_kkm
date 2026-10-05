import 'package:dio/dio.dart';

/// Base type for all errors raised by this package.
sealed class EkpApiException implements Exception {
  const EkpApiException({this.message, this.statusCode, this.code, this.errorToken});

  /// Human readable message (server-provided when available).
  final String? message;

  /// HTTP status code, when a response was received.
  final int? statusCode;

  /// Polymorphic business error code returned in response bodies.
  ///
  /// The API is inconsistent here: some endpoints use numeric codes
  /// (`"code": 2`), others string codes (`"code": "PasswordInHistory"`),
  /// and at least one endpoint returns a non-null `code` on success
  /// (ticket-sales-configuration returns `code: 1` with HTTP 200).
  final Object? code;

  /// Support error token — present on 400s of `GET /tickets` history which
  /// use a different envelope: `{exceptionCode, message, errorToken}`.
  final String? errorToken;

  /// [code] as int when it is numeric, otherwise null.
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

  /// Translates a [DioException] into a typed exception.
  factory EkpApiException.fromDio(DioException e) {
    final embedded = e.error;
    if (embedded is EkpApiException) {
      return embedded;
    }

    final response = e.response;
    if (response == null) {
      return EkpNetworkException(message: e.message, cause: e);
    }

    final body = response.data;
    final fields = body is Map<String, dynamic> ? body : <String, dynamic>{};
    final message = fields['message'] is String ? fields['message'] as String : null;
    // /tickets history 400s use `exceptionCode` instead of `code`.
    final code = fields['code'] ?? fields['exceptionCode'];
    final errorToken = fields['errorToken'] is String ? fields['errorToken'] as String : null;

    if (response.statusCode == 401) {
      return EkpUnauthorizedException(message: message, statusCode: response.statusCode, code: code);
    }
    return EkpHttpException(message: message, statusCode: response.statusCode, code: code, errorToken: errorToken);
  }

  @override
  String toString() {
    final buffer = StringBuffer(runtimeType);
    if (statusCode != null) {
      buffer.write(' (HTTP $statusCode)');
    }
    if (code != null) {
      buffer.write(' code=$code');
    }
    if (message != null) {
      buffer.write(': $message');
    }
    if (errorToken != null) {
      buffer.write(' [token: $errorToken]');
    }
    return buffer.toString();
  }
}

/// Connection-level failure — no HTTP response (timeout, DNS, socket...).
class EkpNetworkException extends EkpApiException {
  const EkpNetworkException({super.message, this.cause});

  /// The original [DioException], for programmatic inspection.
  final Object? cause;
}

/// HTTP 401 — invalid credentials or an unrecoverable session.
class EkpUnauthorizedException extends EkpApiException {
  const EkpUnauthorizedException({super.message, super.statusCode, super.code});
}

/// Any non-2xx response other than 401.
class EkpHttpException extends EkpApiException {
  const EkpHttpException({super.message, super.statusCode, super.code, super.errorToken});
}

/// The stored session could not be recovered (both recover and refresh
/// failed) — the user must log in again.
class EkpSessionExpiredException extends EkpApiException {
  const EkpSessionExpiredException({super.message});
}
