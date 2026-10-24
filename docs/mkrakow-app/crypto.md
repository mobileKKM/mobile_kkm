# mKraków: ticket crypto, and how it compares to `ekp_crypto`

The headline question: **does mKraków use the same encrypted-ticket scheme and keys as mKKM,
so that `ekp_crypto` applies?** Answer: the *scheme* is the same; the *keys* are different.
This document shows the scheme as implemented in mKraków, how its AES secret is hidden in
native code, how it was extracted statically, and the confirmed comparison against
`packages/ekp_crypto`.

## The scheme (identical in shape to mKKM)

### Requests — `tickets/assign-e` and `tickets/contract-e`

```
plaintext JSON  ──RSA (react-native-rsa-native)──▶  base64  ──▶  body {"message": "<b64>"}
```

- Plaintext payloads (from `JSON.stringify`, insertion-ordered):
  - `assign-e`: `{"id": "<ticketGuid>", "device_name": "<manufacturer> <model>"}`
  - `contract-e`: `{"ticketGuid": "<ticketGuid>"}`
- Encryption: `encryptJSON(json, aztecKey)` → `RSA.encrypt(json, aztecKey)` via
  `react-native-rsa-native` (native `RNRSA`), the public key being `aztecKey`.
- The request body is `{"message": "<base64>"}`.

This matches `ekp_crypto`'s documented `assign-e` / `contract-e` request side exactly —
including the `{"id","device_name"}` / `{"ticketGuid"}` payload shapes and the `{"message"}`
envelope. (The decompiled JS does not let us confirm the Android `Base64.DEFAULT` 76-char line
wrapping byte-for-byte, since that happens inside the native RSA module, but the construction
is the same library mKKM uses.)

### Contract — the AZTEC token

```
response {"contract": "<b64>"}
   │ base64 decode
   ▼
IV (16 B) ‖ AES-CBC ciphertext  ──AES/PKCS7, key = secret──▶  hex token  ──▶  AztecCode
```

`aesDecrypt(contractBase64, key)` in the bundle:

1. base64-decode the `contract`.
2. Split: first 16 bytes = IV, remainder = ciphertext (crypto-js `CipherParams`).
3. **Key selection by build**: `APP_CONFIG === 'production'` → `key.slice(0, 16)`; otherwise
   `key.slice(16, 32)`. So the production AES-128 key is the first 16 UTF-8 chars of a 32-char
   secret — the **same prod/dev slicing mKKM uses**.
4. `AES.decrypt(cipherParams, Utf8.parse(keySlice), {iv})` → UTF-8 → the token, rendered
   directly by the `AztecCode` component (the hex string itself is the barcode payload, not
   decoded first — as in mKKM).

Decryption failures are swallowed (`aesDecrypt` catches and returns null, the screen shows a
generic error), matching `ekp_crypto`'s `decryptContract` returning `null`.

## Where the AES secret lives, and why `grep` fails

In mKKM the 32-char secret is a plain string in `libCppModule.so`
(`HybridCppModule::getString()`), so string extraction finds it. In mKraków it is **not** a
plain string — a `grep` for the mKKM value, or for any obvious secret, comes up empty. That is
because it is **compile-time obfuscated**.

- JS side: `getTicketDecryptionKey()` is a native turbo module —
  `TurboModuleRegistry.getEnforcing('NativeSecretKeysModule')` → module 3842/3843.
- Native side (`lib/arm64-v8a/libappmodules.so`):
  `facebook::react::NativeSecretKeysModule::getTicketDecryptionKey(jsi::Runtime&)`.
- The symbol table shows the key is built from an `ay::obfuscated_data<33, …>` — the
  header-only `ay` / "obfusheader" XOR string obfuscator. The 32-char secret (plus a null) is
  stored XOR-masked and is only reconstructed at runtime, so it never appears in cleartext in
  the binary.

## Static extraction (no device)

Disassembling `getTicketDecryptionKey` (ARM64, via `objdump`) shows the deobfuscation inline:

- an obfuscated 32-byte payload is loaded from one `.rodata` address,
- XORed, in two 16-byte halves, against a fixed 16-byte mask loaded from another `.rodata`
  address,
- a trailing length byte XORs to the null terminator,

leaving a 32-char ASCII string. Reproducing it statically is just:

```
key = payload[0..32]  XOR  (mask[0..16] repeated twice)
```

Reading the two byte arrays out of the ELF (map virtual address → file offset via the section
headers) and applying that XOR yields a **32-character, fully printable, mixed-case
alphanumeric** string — the probability of that happening by chance from a wrong offset is
negligible, so the extraction is sound. The production AES key is its first 16 chars.

The concrete addresses, byte arrays and the resulting value are intentionally **not written
here** (the same way `ekp_crypto`'s `cppSecret`/`aztecKey` values are kept in code, not in
docs, and `.dumps/` secrets are never reproduced). The extraction is reproducible from the
`getTicketDecryptionKey` disassembly with `objdump` alone.

## The comparison with `ekp_crypto`

Extracted mKraków secret vs `packages/ekp_crypto/lib/src/keys.dart` `cppSecret`:

| Check | Result |
|---|---|
| Length | both 32 chars |
| Shape | both mixed-case alphanumeric (printable ASCII) |
| Full 32-char value equal | **no** (SHA-256 differs) |
| Production half (chars 0–16) equal | **no** |

So **mKraków's ticket-decryption secret is not `ekp_crypto`'s**. The two apps use the same
AES-128-CBC / prod-first-16-chars construction, but different key material.

The RSA side (`aztecKey`) cannot be compared statically: mKraków, like mKKM, fetches it from
Firebase Remote Config under the key name `aztecKey` and stores it in encrypted storage — there
is **no bundled PEM** in the app. Only the Remote Config *key name* is shared. The two apps
live in different Firebase projects (mKraków `mkrakow-5ff30` / sender `699259905974`; mKKM
`740950577746`), so there is no reason to assume the served PEM is the same, and it would take
a live Remote Config fetch against mKraków's project to confirm the value either way.

## Consequence for this repository

`ekp_crypto` targets the **eKP / mKKM** backend. Its `cppSecret` and `aztecKey` are specific
to that app and backend. Do **not** reuse them for mKraków: the backend host, the AES secret,
and (almost certainly) the RSA key differ. If mKraków were ever a target, it would need its own
key material — the AES secret extracted as above, and the RSA `aztecKey` captured from
mKraków's Remote Config — kept separate from the mKKM values.
