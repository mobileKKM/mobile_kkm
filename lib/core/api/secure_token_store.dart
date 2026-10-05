import 'dart:convert';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// [TokenStore] backed by the platform keystore (iOS Keychain / Android
/// Keystore-encrypted storage). Only the session tokens are stored — never
/// the password.
class SecureTokenStore implements TokenStore {
  SecureTokenStore(this._storage);

  static const _key = 'ekp.session';

  final FlutterSecureStorage _storage;

  // The auth interceptor reads the session on every request; the cache
  // keeps that off the (slow) keystore.
  AuthSession? _cached;
  bool _loaded = false;

  @override
  Future<AuthSession?> read() async {
    if (_loaded) return _cached;
    try {
      final raw = await _storage.read(key: _key);
      if (raw != null) {
        _cached = AuthSession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      }
    } catch (_) {
      // Undecryptable or malformed entry: treat as signed out.
      _cached = null;
      try {
        await _storage.delete(key: _key);
      } catch (_) {}
    }
    _loaded = true;
    return _cached;
  }

  @override
  Future<void> write(AuthSession session) async {
    _cached = session;
    _loaded = true;
    await _storage.write(key: _key, value: jsonEncode(session.toJson()));
  }

  @override
  Future<void> clear() async {
    _cached = null;
    _loaded = true;
    await _storage.delete(key: _key);
  }
}
