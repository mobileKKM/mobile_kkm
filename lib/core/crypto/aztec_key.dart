import 'package:ekp_crypto/ekp_crypto.dart';

/// The RSA public key the `assign-e` / `contract-e` requests are encrypted
/// with. The operator can replace it at any time.
class AztecKey {
  const AztecKey({required this.pem, this.fingerprint, this.version, this.fetchedAt});

  /// As the relay sends it, and as [toJson] stores it.
  factory AztecKey.fromJson(Map<String, dynamic> json) => AztecKey(
    pem: json['pem'] as String,
    fingerprint: json['fingerprint_sha256'] as String,
    version: (json['version'] as num?)?.toInt(),
    fetchedAt: DateTime.tryParse(json['fetched_at'] as String? ?? ''),
  );

  /// The key the app was built with: used until the relay has been heard.
  static const bundled = AztecKey(pem: aztecKeyPem);

  final String pem;

  /// SHA-256 over the key's SPKI encoding, by the relay. `null` for
  /// [bundled].
  final String? fingerprint;

  /// The relay's count of the keys it has seen.
  final int? version;

  /// When the relay last got the key from its source.
  final DateTime? fetchedAt;

  bool get isBundled => fingerprint == null;

  /// RSA with at least 2048 bits, in a form the requests can be encrypted
  /// with.
  bool get isUsable {
    try {
      return (parseRsaPublicKey(pem).modulus?.bitLength ?? 0) >= 2048;
    } catch (_) {
      return false;
    }
  }

  /// Whether [other] is the same key, whatever its envelope.
  bool sameKeyAs(AztecKey other) {
    if (pem == other.pem) {
      return true;
    }
    try {
      final own = parseRsaPublicKey(pem);
      final theirs = parseRsaPublicKey(other.pem);
      return own.modulus == theirs.modulus && own.exponent == theirs.exponent;
    } catch (_) {
      return false;
    }
  }

  Map<String, dynamic> toJson() => {
    'pem': pem,
    'fingerprint_sha256': fingerprint,
    'version': version,
    'fetched_at': fetchedAt?.toUtc().toIso8601String(),
  };
}
