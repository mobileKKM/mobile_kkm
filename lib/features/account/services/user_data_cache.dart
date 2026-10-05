import 'dart:convert';

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// On-device copy of the signed-in user's `account/user-data`, so the
/// profile is available immediately at start-up and without a connection.
abstract class UserDataCache {
  Future<UserDataResponse?> read();
  Future<void> write(UserDataResponse data);
  Future<void> clear();
}

/// [UserDataCache] in the platform keystore — the payload is personal data
/// (name, PESEL, address), so it gets the same protection as the session.
class SecureUserDataCache implements UserDataCache {
  SecureUserDataCache(this._storage);

  static const _key = 'ekp.user_data';

  final FlutterSecureStorage _storage;

  @override
  Future<UserDataResponse?> read() async {
    try {
      final raw = await _storage.read(key: _key);
      if (raw == null) return null;
      return UserDataResponse.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      // Undecryptable or from an older model shape: behave as a cache miss.
      return null;
    }
  }

  @override
  Future<void> write(UserDataResponse data) => _storage.write(key: _key, value: jsonEncode(data.toJson()));

  @override
  Future<void> clear() => _storage.delete(key: _key);
}
