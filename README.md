# mobileKKM

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](./LICENSE)

Unofficial, community-built **FOSS software for the mKKM / EKP system** of
ZTP / MPK Kraków — reverse-engineered from the official Android client,
with the long-term goal of a free and open replacement app.

> [!WARNING]
> This project is not affiliated with, endorsed by, or connected to
> ZTP Kraków, MPK Kraków, or the operators of the mKKM/EKP system. It is
> independent interoperability research. Use at your own risk; the
> backend can change or block unofficial clients at any time.

## Status

**The app itself has not been started yet.** So far the project consists
of the [`ekp-dart`](./packages/README.md) foundation — a pure-Dart API
client for the EKP backend plus the crypto helpers for its encrypted
endpoints. The Flutter application that will sit on top of them is the
next step.

## Packages

| Package | What it does |
|---|---|
| [`ekp_api`](./packages/ekp_api/README.md) | Pure-Dart client for the EKP backend: auth with silent re-auth, tickets (incl. the encrypted `assign-e` / `contract-e` endpoints), payments, account, dictionaries, invoices, subscriptions — `dio`-based, `freezed` response models mirroring the observed wire format. |
| [`ekp_crypto`](./packages/ekp_crypto/README.md) | Crypto for the encrypted mKKM endpoints: RSA-2048-wrapped request payloads and AES-128-CBC contract decryption yielding the AZTEC ticket token, with a documented key-rotation procedure. |

## Repository layout

```
packages/ekp_api/     Dart API client package
packages/ekp_crypto/  encrypted-endpoint crypto package
```

The Flutter application will live at the repository root once its
development starts. The raw network captures this project's knowledge
derives from are **intentionally not included** in this repository (they
contain personal data).

## Developing

```bash
# package tests (pure Dart, no Flutter needed)
cd packages/ekp_api    && dart pub get && dart test
cd packages/ekp_crypto && dart pub get && dart test

# static analysis
cd packages/ekp_api    && dart analyze
cd packages/ekp_crypto && dart analyze
```

## License

Copyright (C) 2026 David Sn

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version. See [LICENSE](./LICENSE) for the full text.

This project exists to keep client software for the mKKM/EKP system free
and open — per the GPL, any derivative of these packages must be
distributed under the same terms.
