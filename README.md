# mobileKKM

[![CI](https://github.com/mobileKKM/mobile_kkm/actions/workflows/ci.yml/badge.svg)](https://github.com/mobileKKM/mobile_kkm/actions/workflows/ci.yml)
[![Latest release](https://img.shields.io/github/v/release/mobileKKM/mobile_kkm?include_prereleases)](https://github.com/mobileKKM/mobile_kkm/releases)
[![License: GPL v3 or later](https://img.shields.io/badge/License-GPLv3%2B-blue.svg)](./LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.47-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS-3DDC84)](#status)

[<img src="https://raw.githubusercontent.com/ImranR98/Obtainium/main/assets/graphics/badge_obtainium.png" alt="Get it on Obtainium" height="56">](obtainium://app/%7B%22id%22%3A%22de.codebucket.mkkm%22%2C%22url%22%3A%22https%3A%2F%2Fgithub.com%2FmobileKKM%2Fmobile_kkm%22%2C%22author%22%3A%22David%20Sn%22%2C%22name%22%3A%22mobileKKM%22%2C%22preferredApkIndex%22%3A0%2C%22additionalSettings%22%3A%22%7B%5C%22includePrereleases%5C%22%3Atrue%2C%5C%22apkFilterRegEx%5C%22%3A%5C%22foss%5C%5C%5C%5C.apk%24%5C%22%7D%22%7D)

Unofficial, community-built **FOSS software for the mKKM / eKP system** of
ZTP / MPK Kraków — reverse-engineered from the official Android client,
with the long-term goal of a free and open replacement app.

> [!WARNING]
> This project is not affiliated with, endorsed by, or connected to
> ZTP Kraków, MPK Kraków, or the operators of the mKKM/eKP system. It is
> independent interoperability research. Use at your own risk; the
> backend can change or block unofficial clients at any time.

## Status

Version 2.0.0 is a pre-release rewrite of the old WebView app, as a native
Flutter client for Android and iOS. It is built on the
[`ekp_api`](./packages/ekp_api/README.md) and
[`ekp_crypto`](./packages/ekp_crypto/README.md) packages.

**Works today**

- Signed-out flows: login, registration, account activation, password reset
  (including the e-mail links), first start notice.
- mKKM card set-up for new and detached accounts.
- Home, Tickets, Map and Account tabs.
- Tickets: list, details, return, line change, ticket control (AZTEC code).
- Purchase with the sales rules read from the server, paid through tPay.
- Karta Krakowska status and code.
- Account: edit, photo, password, delete.
- Transit map (MapLibre / OpenFreeMap) with location on request.
- Polish and English, light and dark theme, Material 3 with the app's own
  design system.

**Not built yet**

- Vehicles, stops with departures and stop search (the map shows a preview
  notice until they arrive).
- 5+1 subscription (Home shows it greyed out).
- Reconnect detection after being offline.

**Known limitation:** a payment is not restored if the OS killed the app
while tPay was open. A return link on a cold start is still reported;
otherwise the start-up sync and the card cover it.

## Packages

| Package | What it does |
|---|---|
| [`ekp_api`](./packages/ekp_api/README.md) | Pure-Dart client for the eKP backend: auth with silent re-auth, tickets (incl. the encrypted `assign-e` / `contract-e` endpoints), payments, account, dictionaries, invoices, subscriptions — `dio`-based, `freezed` response models mirroring the observed wire format. |
| [`ekp_crypto`](./packages/ekp_crypto/README.md) | Crypto for the encrypted mKKM endpoints: RSA-2048-wrapped request payloads and AES-128-CBC contract decryption yielding the AZTEC ticket token, with a documented key-rotation procedure. |

## Repository layout

```
lib/                  Flutter application
  core/               shared code: api, crypto, database, platform, providers,
                      router, theme, widgets
  features/<name>/    one folder per feature, split by kind: screens/, providers/,
                      widgets/, models/, utils/, constants/, services/
android/, ios/        platform projects (payment browser channel, link handling)
fastlane/metadata/    store listing texts, changelogs and images (en-US, pl-PL)
test/                 app tests over a fake HTTP adapter and in-memory database
assets/branding/      icon and logo sources (SVG)
tool/                 render_branding.sh, which rasterises them into the Android/iOS
                      launcher icons, in-app logo and splash logo
packages/ekp_api/     Dart API client package
packages/ekp_crypto/  encrypted-endpoint crypto package
docs/official-app/    how the official app's screens and flows work, as a reference
                      for building or redesigning the same features
```

The raw network captures this project's knowledge derives from are
**intentionally not included** in this repository (they contain personal
data).

## Developing

The repository is a [pub workspace](https://dart.dev/tools/pub/workspaces):
the app and the packages under `packages/` share a single dependency
resolution — one `pub get`, one lockfile, one analysis context.

```bash
# resolve the whole workspace (app + packages), from the repo root
flutter pub get

# static analysis from the root; `dart analyze`, not `flutter analyze`,
# because only it runs the riverpod_lint plugin
dart analyze
dart format .

# tests — the app suite runs from the root, each package from its own
# directory (ekp_api's tests load fixtures relative to the package dir)
flutter test
(cd packages/ekp_api    && dart test)
(cd packages/ekp_crypto && dart test)
```

## Releases

The app keeps the application ID of the old WebView app,
`de.codebucket.mkkm`, so it updates over it. That app reached version
code 23; every release raises the `+N` in `pubspec.yaml` above the last
one uploaded anywhere.

```bash
flutter build apk --release --target-platform android-arm,android-arm64 \
  --split-debug-info=build/symbols   # GitHub releases and F-Droid
flutter build appbundle --release    # Google Play
```

Tags `v<version name>` run `release.yml`, which builds a Google-services
(`-gms.apk`) and a FOSS (`-foss.apk`) APK, checks the signer, and creates a
draft release with `SHA256SUMS`. The bundle is uploaded to Play by hand.

Both are signed with the release key from `android/key.properties`
(gitignored), the same key as the old app's.

- **Store texts and images:** `fastlane/metadata/android/<locale>/`,
  read by F-Droid and copied into the Play Console by hand (no fastlane
  needed). Each release adds `changelogs/<version code>.txt` in `en-US`
  and `pl-PL`. The icon and the feature graphic are the old
  app's, as on its Play listing; screenshots are still to come.
- **F-Droid:** `tool/fdroid/de.codebucket.mkkm.yml` is a draft of the
  build recipe for [fdroiddata](https://gitlab.com/fdroid/fdroiddata).
  F-Droid builds with Flutter 3.47.5 (its `srclibs`); keep that in step
  with the version a release is built with. `geolocator_android` and
  `maplibre_gl` pull in Google Play Services, which F-Droid does not
  allow, so the recipe runs `tool/fdroid/strip_gms.sh` on a fresh pub
  cache after `flutter pub get`. Both plugins then use Android's own
  location provider. The script fails when a plugin update moved what it
  patches, rather than letting GMS through.

## License

Copyright (C) 2026 David Sn

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version. See [LICENSE](./LICENSE) for the full text.

This project exists to keep client software for the mKKM/eKP system free
and open — per the GPL, any derivative of these packages must be
distributed under the same terms.
