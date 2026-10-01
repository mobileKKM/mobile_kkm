import 'auth_session.dart';

/// Persistence for [AuthSession], implemented by the host app
/// (e.g. backed by flutter_secure_storage).
abstract class TokenStore {
  Future<AuthSession?> read();
  Future<void> write(AuthSession session);
  Future<void> clear();
}

/// Trivial in-memory [TokenStore] — default in tests and ephemeral sessions.
class InMemoryTokenStore implements TokenStore {
  AuthSession? _session;

  @override
  Future<AuthSession?> read() async => _session;

  @override
  Future<void> write(AuthSession session) async => _session = session;

  @override
  Future<void> clear() async => _session = null;
}
