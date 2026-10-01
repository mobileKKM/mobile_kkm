import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

/// An authenticated EKP session as returned by `auth/login`,
/// `auth/token/recover` and `auth/token/refresh`.
@freezed
abstract class AuthSession with _$AuthSession {
  const AuthSession._();

  const factory AuthSession({
    /// Full JWT (header.payload.signature) — `token` in the response body.
    required String token,

    /// Refresh token (32 hex chars) — `refresh` in the response body.
    required String refresh,

    /// Access token expiry (the JWT lives ~45 minutes).
    DateTime? expires,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);

  /// Whether the access token is past its expiry.
  ///
  /// Expired does not mean unusable — the server is the source of truth —
  /// but it is a good hint to trigger a proactive recovery.
  bool get isExpired =>
      expires != null && DateTime.now().toUtc().isAfter(expires!.toUtc());
}
