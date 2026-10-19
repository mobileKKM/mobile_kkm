import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Where the last payment method is kept; overridden in `main()`.
final lastPaymentMethodStoreProvider = Provider<LastPaymentMethodStore>(
  (ref) => throw UnimplementedError('overridden in main()'),
);

/// The tPay group id of the payment method used last, preselected on the
/// next payment.
abstract class LastPaymentMethodStore {
  Future<String?> read();
  Future<void> write(String groupId);
  Future<void> clear();
}

/// [LastPaymentMethodStore] in the platform keystore, with the account's
/// other data, and cleared at sign-out with it.
class SecureLastPaymentMethodStore implements LastPaymentMethodStore {
  SecureLastPaymentMethodStore(this._storage);

  static const _key = 'ekp.last_payment_group';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read() async {
    try {
      return await _storage.read(key: _key);
    } catch (_) {
      // Undecryptable: as if nothing was stored.
      return null;
    }
  }

  @override
  Future<void> write(String groupId) => _storage.write(key: _key, value: groupId);

  @override
  Future<void> clear() => _storage.delete(key: _key);
}
