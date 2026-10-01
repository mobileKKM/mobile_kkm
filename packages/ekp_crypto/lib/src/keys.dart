/// Key material recovered from the official mKKM Android client.
///
/// Both constants are documented for interoperability; override hooks
/// exist on [EkpAztecCrypto] for rotated/recovered values.
library;

/// RSA-2048 public key (PKCS#1 `BEGIN RSA PUBLIC KEY` PEM) used to encrypt
/// `assign-e` / `contract-e` request payloads.
///
/// Served by Firebase Remote Config (project 740950577746) under the key
/// `aztecKey` (companion flag entry `fix: 20260924`). See the README for
/// the rotation procedure.
const String aztecKeyPem = '''
-----BEGIN RSA PUBLIC KEY-----
MIIBCgKCAQEA4NgeDRNowqtK1GC3UgDkTquMtb2P0SFNsi54OWcvYtihKuOsr+Ye
K9UmDmfK5xCRzBmwJ3uMrjVFnqNTW2eFIxB0rqS2qo0p7XrRJLQ7By96L7fYJn4g
j4/IUER4vu/wLYzQMlCKD2mTtM6M2AaJA/otrbwPIintebttEfZ3oEvTmeifTYNP
MI648Zte140yVa0sipEr4Tjb26+lFn6hBT5pK+g7tuRBToiWPD1db+ysOcQx0PwL
WAO5E/7EfJM0kveA8t+SxXPiA6JR95sm5l8NE2mdjP/cRCw4qIiz7AKJqUMduKDw
gwLOkQXwSjXHNDR0q/N4dvfb97/hyea8ZwIDAQAB
-----END RSA PUBLIC KEY-----
''';

/// The 32-char secret returned by the native `libCppModule.so` Nitro module
/// (`HybridCppModule::getString()`, string at vaddr 0x6962).
///
/// The AES-128 key is the UTF-8 bytes of the first 16 chars in production,
/// or chars 16–32 in development builds (see [EkpCryptoEnvironment]).
const String cppSecret = 'VoEVG4Yv/u1IFP6SPnsVGi1SWPnrwQfJ';

/// Backend flavour the official client was built for — selects which half
/// of [cppSecret] is the AES-128 key (`getEnv()` in the app's crypto module).
enum EkpCryptoEnvironment {
  /// AES key = [cppSecret] chars 0–16 (default).
  production,

  /// AES key = [cppSecret] chars 16–32.
  development;

  /// The 16 UTF-8 chars of [secret] used as the AES-128 key in this environment.
  String aesKeyOf(String secret) => switch (this) {
    EkpCryptoEnvironment.production => secret.substring(0, 16),
    EkpCryptoEnvironment.development => secret.substring(16),
  };
}
