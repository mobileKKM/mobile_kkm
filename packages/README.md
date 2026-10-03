# ekp-dart

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](./LICENSE)

Unofficial, community-built **FOSS tooling for the mKKM / EKP system** of
ZTP / MPK Kraków — a Dart API client and the crypto helpers for its
encrypted endpoints, reverse-engineered from the official Android client
with the long-term goal of an FOSS replacement app.

> **Disclaimer:** This project is not affiliated with, endorsed by, or
> connected to ZTP Kraków, MPK Kraków, or the operators of the mKKM/EKP
> system. It is independent interoperability research. Use at your own
> risk; the backend can change or block unofficial clients at any time.

## Packages

| Package | What it does |
|---|---|
| [`ekp_api`](./ekp_api/README.md) | Pure-Dart client for the EKP backend (auth with silent re-auth, tickets, payments, account, dictionaries, …), `dio`-based, `freezed` response models mirroring the observed wire format. |
| [`ekp_crypto`](./ekp_crypto/README.md) | Crypto for the encrypted mKKM endpoints: RSA-2048-wrapped request payloads (`assign-e` / `contract-e`) and AES-128-CBC contract decryption yielding the AZTEC ticket token. |

## Repository layout

```
ekp_api/     Dart API client package
ekp_crypto/  encrypted-endpoint crypto package
LICENSE      GPL-3.0-or-later
```

The raw network captures this project's knowledge derives from are
**intentionally not included** in this repository (they contain personal
data). A companion Flutter application built on these packages lives in
the parent repository (scaffold so far) and has not been published yet.

## Developing

Inside the repository the packages are members of the root
[pub workspace](https://dart.dev/tools/pub/workspaces): run
`flutter pub get` once at the repository root — there is no per-package
`pub get`, lockfile, or `.dart_tool` directory anymore.

```bash
# tests (pure Dart, no Flutter needed) — run from each package directory
# (ekp_api's tests load fixtures relative to the package dir)
cd ekp_api    && dart test
cd ekp_crypto && dart test

# static analysis — the repo root analyze covers every workspace member
cd ../.. && flutter analyze
```

To resolve a package outside the workspace (e.g. to validate its own
dependency constraints standalone), put a `pubspec_overrides.yaml` next
to its `pubspec.yaml` containing only `resolution:` — see
[the workspace docs](https://dart.dev/tools/pub/workspaces#temporarily-resolving-a-package-outside-its-workspace).

## License

Copyright (C) 2026 David Sn

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version. See [LICENSE](./LICENSE) for the full text.

This project exists to keep client software for the mKKM/EKP system free
and open — per the GPL, any derivative of these packages must be
distributed under the same terms.
