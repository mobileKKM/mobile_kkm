# ekp_crypto

Crypto helpers for the **encrypted mKKM (EKP) endpoints** — the scheme the
official Android client (`pl.krakow.kkm.m` 1.6.10) uses to bind a purchased
ticket to a device (`POST mkkm/tickets/assign-e`) and to fetch the AZTEC
ticket code (`POST mkkm/tickets/contract-e`).

> Unofficial reverse-engineering project, not affiliated with or endorsed
> by the operators of mKKM/EKP. Everything below was recovered from the
> official app (Hermes bytecode decompilation, `libCppModule.so` string
> extraction, passive traffic observation) and verified against real
> traffic; the raw captures are not part of this repository. Pure Dart,
> no Flutter/dio dependency.

## The scheme

### Requests (`assign-e` / `contract-e`)

```
plaintext JSON  ──RSA-2048 PKCS#1 v1.5──▶  256-byte block
                                              │  base64 (Android Base64.DEFAULT:
                                              │  76-char \n lines + trailing \n)
                                              ▼
                                    body: {"message": "<b64>"}
```

* Plaintext payloads (serialized exactly like `JSON.stringify` — compact,
  insertion-ordered):
  * `assign-e`: `{"id":"<ticketGuid>","device_name":"<x-device-name>"}`
  * `contract-e`: `{"ticketGuid":"<ticketGuid>"}`
* Encryption: RSA-2048 PKCS#1 v1.5 (`RSA/NONE/PKCS1Padding` via
  react-native-rsa-native), UTF-8, randomized type-2 padding, single block.
* Public key: **PKCS#1** PEM (`-----BEGIN RSA PUBLIC KEY-----`) served by
  Firebase Remote Config (project `740950577746`) under the key `aztecKey`
  — see `lib/src/keys.dart` for the recovered value (companion Remote
  Config flag `fix: 20260924`).
* The base64 wrapper matters byte-for-byte: Android `Base64.DEFAULT` emits
  76-char lines joined by `\n` plus a trailing `\n` (344 chars of base64 +
  5 newlines for a 256-byte block). The JSON body then escapes each newline
  as `\n`, which is why request bodies are exactly 368 chars.

### Contracts (the AZTEC token)

```
response {"contract": "<b64>"}  ──base64 decode──▶  IV (16 B) ‖ AES-128-CBC ct
                                                        │  key = first 16 UTF-8
                                                        │  chars of the C++ secret
                                                        ▼
                                          512-char uppercase-hex token
                                          (rendered directly as AZTEC barcode,
                                          valid ~119 s)
```

* AES-128-CBC with PKCS#7 padding — the defaults of crypto-js in the app.
* Key material: the 32-char string returned by the native Nitro module
  `HybridCppModule::getString()` in `libCppModule.so` (string at vaddr
  `0x6962`). **Production builds use chars 0–16, development builds chars
  16–32** (`EkpCryptoEnvironment`).
* The plaintext is 512 chars of `[0-9A-F]` — the app passes the *string*
  itself to `react-native-barcode-creator` (it does not decode the hex).

## Usage

```dart
final crypto = EkpAztecCrypto(); // aztecKey + prod secret by default

// Request side (what TicketsApi.assign/contract send):
final message = crypto.encryptJson({
  'id': ticketGuid,
  'device_name': 'Google Pixel 8',
});

// Response side:
final hexToken = crypto.decryptContract(contractBase64); // null on failure
```

`encryptJson` throws `EkpCryptoException` on failure; `decryptContract`
returns `null` on any failure — deliberately mirroring the official client,
which catches decryption errors and shows a generic error.

## Key rotation

The RSA public key is served via Firebase Remote Config, so the operator can
rotate it server-side at any time. When `assign-e`/`contract-e` requests
start failing (or a new app bundle carries a changed `aztecKey`):

1. Capture the Remote Config fetch with mitmproxy:
   ```
   POST firebaseremoteconfig.googleapis.com/v1/projects/740950577746/namespaces/firebase:fetch
   headers: X-Goog-Api-Key AIzaSyB882w-5Zevx-ehGNvKnAXHxkddWJFgOnw
            X-Android-Package pl.krakow.kkm.m
            X-Android-Cert 35712691A1AE0A81B34D0CED581BE73B20FA2868
            X-Goog-Firebase-Installations-Auth <FID JWT>
   body:    {"appInstanceId":"<appInstanceId>",
             "appId":"1:740950577746:android:1efa6043e00cdbf826458b",
             "sdkVersion":"23.0.0","appBuild":"241061001"}
   ```
2. Copy the new `aztecKey` PEM into `lib/src/keys.dart` (or construct
   `EkpAztecCrypto(publicKeyPem: …)` at the call site — the constructor
   parameters are the override hooks).
3. If the C++ secret changes (app update swapped `libCppModule.so`), extract
   the new string (Nitro `HybridCppModule::getString()` / vaddr noted in the
   binary) and update `cppSecret` likewise.

There is intentionally **no** Firebase RC fetch client here — re-capturing
manually is the documented procedure.

## Testing

```
dart test
```

Line coverage of `lib/` is 100%:

```
dart test --coverage=coverage
dart run coverage:format_coverage --package . --report-on=lib --lcov \
    -i coverage -o coverage/lcov.info
```

The suite pins the reverse-engineered scheme with synthetic vectors: the
full contract round-trip (IV ‖ AES-128-CBC/PKCS7 blob → 512-char
uppercase-hex token), decryption failure modes (wrong key, malformed
base64, non-block-aligned blobs), the Android `Base64.DEFAULT` line
wrapping (`[76, 76, 76, 76, 40]` + trailing newline), the
`JSON.stringify`-exact payload serialization, randomized PKCS#1 padding,
a local-keypair round-trip, and dev/prod key slicing.

The original capture-derived golden vectors (real contract-e pairs whose
tokens were scan-verified against the official app's rendered AZTEC
codes) were removed before publishing — like the captures themselves,
they derive from a real account. `tool/make_synthetic_contract.dart`
regenerates the synthetic contract fixture used by ekp_api's tests.

## License

GPL-3.0-or-later — see the repository [LICENSE](../LICENSE).
Copyright (C) 2026 David Sn.
