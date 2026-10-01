import 'auth_session.dart';

/// Emitted by [EkpSessionManager.events] describing the auth lifecycle.
sealed class EkpSessionEvent {
  const EkpSessionEvent();
}

/// A fresh login succeeded.
class EkpSessionAuthenticated extends EkpSessionEvent {
  const EkpSessionAuthenticated(this.session);
  final AuthSession session;
}

/// The session tokens were rotated (recover/refresh).
class EkpSessionUpdated extends EkpSessionEvent {
  const EkpSessionUpdated(this.session);
  final AuthSession session;
}

/// Recovery failed — no valid session remains; user must log in again.
class EkpSessionExpired extends EkpSessionEvent {
  const EkpSessionExpired();
}

/// User-initiated logout completed (local session cleared).
class EkpSessionLoggedOut extends EkpSessionEvent {
  const EkpSessionLoggedOut();
}
