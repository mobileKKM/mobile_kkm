# CLAUDE.md

Guidance for Claude Code (claude.ai/code) in this repository.

## What this is

mobileKKM: an unofficial GPL-3.0 Flutter client (Android + iOS) for the mKKM / EKP ticketing backend of ZTP / MPK Kraków, reverse-engineered from the official Android app. A [pub workspace](https://dart.dev/tools/pub/workspaces); dependency direction app → `ekp_api` → `ekp_crypto`:

- `.` (`mobile_kkm`) — the app. Built: signed-out flows, mKKM card set-up, the signed-in shell (Home, Tickets, Map, Account), ticket details / return / line change / control (AZTEC), purchase and tPay payment, Karta Krakowska, account edit / password / delete, MapLibre map, hidden debug menu.
  Not built: vehicles, stops with departures, stop search; reconnect detection (planned: `connectivity_plus` → `AppStatusController.check()`); 5+1 (`/subscription`, `ComingSoonScreen`); the first-start notice (11h).
- `packages/ekp_api` — pure-Dart `dio` client, no Flutter.
- `packages/ekp_crypto` — pure-Dart crypto for `assign-e` / `contract-e` (RSA-wrapped requests, AES-128-CBC contract → AZTEC token).

`docs/official-app/` reconstructs the official client's screens, rules and requests from its decompiled bundle (`.dumps/react/`). Read the relevant document before building a feature the official app has.

## Commands

```bash
flutter pub get        # at the root; resolves all members (one lockfile)
dart analyze           # from the root; not `flutter analyze`, which skips riverpod_lint
dart format .          # 120 columns; must leave nothing changed
dart fix --apply

flutter test                                    # app suite, from the root
flutter test --plain-name 'substring'
(cd packages/ekp_api    && dart test)           # from the package dir (fixtures load relatively)
(cd packages/ekp_crypto && dart test)
```

Code generation (commit outputs with the source change; `dart format .` after build_runner, which emits 80 columns):

```bash
(cd packages/ekp_api && dart run build_runner build --delete-conflicting-outputs)  # freezed / json
dart run build_runner build            # root: drift (lib/core/database/*.g.dart)
flutter gen-l10n
sh tool/render_branding.sh             # icons, logos, splash from the SVGs (Chrome, macOS sips)
dart run flutter_native_splash:create  # after render_branding; colours must match SplashScreen
```

## Release

Application ID `de.codebucket.mkkm`.

```bash
flutter build apk --release --target-platform android-arm,android-arm64 --split-debug-info=build/symbols
    # direct download / F-Droid; not --split-per-abi (adds 1000 × ABI to the version code)
flutter build appbundle --release   # Google Play, all three ABIs
```

- `build.gradle.kts` sets `abiFilters` from Flutter's `target-platform` (MapLibre's prebuilt libraries ignore it otherwise). `flutter symbolize` with `build/symbols` decodes stack traces.
- Aztec key relay: `--dart-define=AZTEC_KEY_RELAY_URL=https://…` (no path) replaces `relay.mobilekkm.app`; `AZTEC_KEY_RELAY_TOKEN` if the relay has `RELAY_API_TOKEN`.
- Signing: `android/key.properties` (gitignored). Without it the release uses the debug key — never publish that. Raise `+N` in `pubspec.yaml` for every upload (the old app under this ID reached 23). The APK omits `dependenciesInfo` (F-Droid); the bundle keeps it.
- CI (`ci.yml`): format, `dart analyze --fatal-infos`, generated code vs commit, three suites, release APK with and without GMS (`strip_gms.sh`, then `tool/ci/check_no_gms.sh`). Flutter is pinned in `.github/actions/setup-flutter/action.yml`; keep it equal to the F-Droid recipe's `srclibs`. Java 21.
- `release.yml` (tag `v<version name>`): checks, tag vs `pubspec.yaml`, `-gms.apk` / `-foss.apk` (same ID and key), `tool/ci/check_signer.sh` against `RELEASE_CERT_SHA256`, a **draft** release with `SHA256SUMS` and notes from `fastlane/metadata/android/en-US/changelogs/<versionCode>.txt`. The `.aab` is uploaded to Play by hand. Environment `release` holds the keystore secrets and optional relay settings; a missing secret stops the build.
- Store listing: `fastlane/metadata/android/{en-US,pl-PL}/` (read by F-Droid; Play filled by hand). Each release adds `changelogs/<versionCode>.txt` to both (≤ 500 chars); short description ≤ 80, title ≤ 30. Karta Krakowska only a note; 5+1 stays out until built.
- F-Droid: `tool/fdroid/de.codebucket.mkkm.yml`; its `prebuild` runs `strip_gms.sh` on `geolocator_android` and `maplibre_gl` (breaks when a plugin update moves the patched code; CI catches it).

## Privacy constraints

- `.dumps/` holds raw captures with real credentials and personal data: gitignored; never commit it or copy values from it into fixtures, tests, docs or commit messages.
- `packages/ekp_api/test/fixtures/` is sanitized; keep new fixtures synthetic. `packages/ekp_api/tool/` is deliberately gitignored.
- `ekp_crypto` tests use synthetic vectors; `packages/ekp_crypto/tool/make_synthetic_contract.dart` regenerates the contract fixture.

## Architecture

### `ekp_api`

- `EkpClient`: one `Dio` pipeline (cookie jar → `DeviceHeadersInterceptor` → `AuthInterceptor`), one API object per domain in `lib/src/<domain>/` (`<domain>_api.dart` + `<domain>_models.dart`).
- Services extend `EkpApiService` and wrap calls in `guard()`, mapping `DioException` to the sealed `EkpApiException`. Callers never see `DioException`.
- Request bodies are explicit maps; response models (`freezed`) mirror the wire format exactly, inconsistencies included. Don't tidy them.
- `EkpSessionManager` persists via the host's `TokenStore` and re-auths silently via `auth/token/recover` (single-flight, retries once, keeps the session on network failure).
- The host supplies `TokenStore` and `EkpDeviceIdentity`; no platform code in the package.

Read `packages/ekp_api/README.md` and `packages/ekp_crypto/README.md` before changing auth, cookies or the encrypted endpoints.

### App (`lib/`)

`core/` (api, crypto, platform, providers, router, theme, widgets) and `features/<name>/{screens,providers,widgets,models,utils,constants,services}/`. Riverpod 3 with hand-written providers (no generator); `go_router`.

Material widgets come from `package:material_ui/material_ui.dart`, not `package:flutter/material.dart`: go_router 18 only recognises its `MaterialApp` and otherwise drops page transitions and the iOS back swipe. For the same reason `MobileKkmApp` uses `material_ui`'s `GlobalMaterialLocalizations.delegates`.

- **Injection seam:** host providers (`deviceIdentityProvider`, `tokenStoreProvider`, `appDatabaseProvider`, caches and stores) throw by default and are overridden in `main()`. Platform side effects are providers too (`urlOpenerProvider`, `paymentBrowserProvider`, `mapViewProvider`, `screenSecurityProvider`, …) so tests can fake them.
- **Start-up:** `appStartupProvider` (behind the splash) runs `service-status`, then the config (8 s cap). `appStatusProvider` holds `AppMode`: `offline`, `unavailable`, `outdated`, `online`; only `outdated` blocks (`UpdateRequiredScreen`). **Load nothing else behind the splash**: user data, tickets and the relay key go independently afterwards. `AppStatusBanner` reports the mode, below the app bar.
- **Auth:** `AuthController` mirrors the session stream into `AuthStatus` (`unknown` / `authenticated` / `unauthenticated`); `SignOutReason` feeds the login banner.
- **Routing:** the pure `redirectFor(uri, status)` (`core/router/app_router.dart`) holds all gating. Register every new screen in `Routes.isSignedIn` or `Routes.isPublic`. A `CardGate` other than `open` confines signed-in users to `/card-setup`. The four tabs are `StatefulShellRoute.indexedStack` branches; other signed-in screens are top-level routes.
- **Aztec key:** fetched from the relay (`AztecKeyRelay`, own `Dio`, `User-Agent` must be `mobileKKM/<version>` or Cloudflare blocks it), never behind the splash. The client reads the key from `aztecKeyInUseProvider`, a plain holder — not from `AztecKeyController` and not watched (that would rebuild the client and replay the splash). A refused encrypted call asks the relay's `refresh` and retries once if the key changed.
- **User data:** `userDataProvider`: cached copy at once, revalidated in the background, cleared on sign-out; without a cache the first load's failure ends the session. Store an answer only for the session that asked: take the `ref` before the request (`ref.mounted` after an `await` misses a sign-out).
- **Card set-up:** `cardGateOf()` on the user data (`setUp` / `detached` / `open`; `checking` without data, never `open`). The first load is waited for in place (8 s, then local sign-out). The server creates the card after answering, so `CardSetupController` polls the user data. Known gap: deleting an account needs a detached card, which shuts the gate (`TODO(card-gate)` in `redirectFor`).
- **Ticket store:** mobile tickets live in drift (`core/database/app_database.dart`, `Tickets` with the JSON as `payload`). Screens read only the database. `TicketSyncController` fetches when signed in, started and `online`, on foreground (≤ 1/min) and pull-to-refresh; it empties the store on sign-out. History is live, not stored.
- **Ticket display:** `MkkmTicketCard` is the one card for list, Home and details; tone via `toneOf()`, actions via `actionOf()`, order via `listRankOf()` (`utils/ticket_format.dart`). What a ticket is comes from the dictionaries only, never `productName`. Prices are always Polish (`formatPrice`). First loads show skeletons, never a spinner.
- **Ticket actions / details:** `TicketActionsController` runs `assign-e` and `payments/check`, then refreshes. "Continue payment" waits for the details and hands them to `TicketPayScreen` as `extra`. Ticket details are live (`ticketDetailProvider`); return and line change follow the server's flags. Line change sends every line with the picks in place; never assume how many lines (only one-line tickets were captured).
- **Purchase** (`features/purchase/`): no sales rule is hard-coded; `SalesRules` derives everything from `tickets/ticket-sales-configuration`. The two configurations are "privileged" / "not privileged" (`hasCracovCardPrivilege`), never "resident". Payment method tiles by tPay group id in a fixed order (`PaymentMethods.tileOrder`); other groups go to the bank sheet. `salesConfigurationProvider` caches by timestamp, not a timer (a pending timer fails widget tests).
- **Payment** (`services/payment_session.dart`): tPay opens through `PaymentBrowser` (channel `de.codebucket.mkkm/payment`, our own code: Custom Tab + `PaymentReturnActivity` on Android, `SFSafariViewController` on iOS). `PaymentSessionController` pushes `PaymentScreen` (`/payment`) and shows every outcome there in place. A return link posts `payments/result`; success marks the ticket in drift `Payments`; a browser closed without a link triggers `payments/check` (now, 5 s, 10 s). Every exit is the Tickets tab. `PaymentWatcher` syncs every 10 s while marks exist. Payment is not restored after the OS killed the app while tPay was open (28c dropped, decided): a cold-start return link is still reported, otherwise the start-up sync and the card cover it. Unverified on devices: tPay redirects reaching the app link from Chrome; `payments/result` on iOS.
- **Codes** (ticket control, Karta Krakowska): `CodeScreen` (`core/widgets/code_screen/`) with a `CodeState` notifier. `ScreenSecurity` blanks screenshots; Android keeps `FLAG_SECURE` (no overlay: Samsung's recents leaked the code). Ticket control renews the contract 10 s early and stops fetching while hidden (`AppLifecycleListener` `onHide` / `onShow`). Time is `clock.now()`.
- **Karta Krakowska:** `mkkmData.hasInhabitantPrivilege` alone decides the status; dates shown as sent. The status code is the server's PNG until `expirationDate`.
- **Account:** buttons off unless `online`. Edit sends every field in one `account/user-data`, as the official client does; the photo saves separately. Delete: any card leads to the website; only an empty card list gets `account/anonymise`, then a local sign-out.
- **Dictionaries:** one JSON file each via `FileDictionaryCache`; 24 h max age set by the app (the server sends no validators). New dictionary = a `Dictionary` constant + its provider.
- **Map:** `MapScreen` drives `TransitMap` (`maplibre_gl`, OpenFreeMap) through `MapViewController`, never MapLibre directly. Location permission asked on tap.
- **Debug menu** (`/debug`): 11 taps on Account's version line or the login logo, release builds too. It changes real values.
- **E-mail links:** `https://ekp.mpk.krakow.pl/konto-uzytkownika/{activate|reset},<token>.html` map to `/activate/:token` / `/reset-password/:token` via `EmailLink.tryParse` + `redirectFor`. Android uses an unverified intent filter (`LinkSettings` checks "Open supported links").
- **Password managers:** login e-mail fields use `[AutofillHints.username, AutofillHints.email]` (`username` first, iOS reads only the first); new passwords `newPassword`; call `TextInput.finishAutofillContext()` once the server accepted.
- **Orientation:** portrait only, tablets too (Dart, manifest and `Info.plist`).
- **Minors:** under 16 never goes to `auth/register`; `websiteRegistrationUri()` opens the website's form.
- **Errors:** UI text for a failed call goes through `describeError()` (`core/api/error_messages.dart`); server messages are shown verbatim (always Polish).
- **l10n:** `lib/l10n/app_en.arb` is the template, `app_pl.arb` the translation; add to both.

### App tests

`pumpApp()` (`test/support/harness.dart`) pumps the real `MobileKkmApp` over a real `EkpClient` with `FakeAdapter` (replies keyed by method + path suffix, unmatched → 404), an in-memory drift database and platform fakes. `session: signedInSession` starts signed in. Assert on `adapter.requests` / `requestTo()` and `app.router`; use `tapVisible()` and `field(label)` for forms. Sample data in `test/support/sample_data.dart` (`userDataJson()`, `ticketDetailJson()`, `apiFixture(name)`).

Gotchas:
- Only `account/user-data` has a default reply (an account with a card); a signed-in app without user data signs out. A 404 at start-up counts as "online, no config".
- A test resting on a held first load disables animations (the skeleton pulse never settles); leave Home with `pump`, not `pumpAndSettle`.
- With a code on screen use `pumpWithCode()`, never `pumpAndSettle` (fake clock).
- Never `await app.router.push(...)` (completes on pop); `unawaited` it.
- Read drift with `select(...).get()`, not `watch().first` (never emits under the fake clock). Clear a leftover `Payments` row at the end (the watcher's timer stays pending).
- `tall: true` for a whole lazy list; `settle: false` keeps the splash up.

`ekp_api` has its own `MockAdapter` (`packages/ekp_api/test/mock_adapter.dart`): method + path fragment, FIFO queue, throws on unregistered routes.

## Design

The design handoff lives in `AppTheme` (`lib/core/theme/app_theme.dart`) and `lib/core/widgets/`; screens style through them, not locally. Fidelity scheme of `#303F9F`, Montserrat (display / headline / title) + Inter (body / label), 56 dp pill buttons, radius-28 cards and sheets.

Use the shared widgets:
- `RowGroup` / `GroupRow` + `IconTile` for every list of rows; `CheckRow` for a checkbox with its label.
- `MessageBanner` for server messages at the top of a form; `AppStatusBanner` for offline / unavailable.
- `FormCard` only for multi-section forms; `LeadHeader` + `AuthPage` for lead screens.
- `BottomActionBar` for a pinned bottom button; `SystemBarScrim` for content scrolling under the navigation bar.
- `EmptyStateCard` / `LoadProblem` for missing or failed content; `SkeletonBox` in `SkeletonPulse` for first loads; `StatusChip` (icon + word, never colour alone).
- `showAppSnackBar()` for every snackbar; `SubmitButton` for busy buttons.
- `CodeScreen` for any code shown to someone else; `PhotoPreview`, `BulletCard`, `Perforation` as named.
- On the brand surface use `primaryFixed` / `onPrimaryFixed`, never `primary`. Filled buttons in dialogs use `AppTheme.dialogAction` (40 dp).

## Conventions

- Icons: `Symbols.<name>_rounded` (`material_symbols_icons`), not `Icons.*`; `fill: 1` for filled.
- App imports are `package:mobile_kkm/...`; packages use relative imports in `lib/src/`.
- Keep `dart format` and `dart analyze` clean. `riverpod_lint` runs as an analyzer plugin (app only). Every control body needs braces; wrap fire-and-forget futures in `unawaited(...)`.
- Conventional Commits with a member scope: `feat(app): …`, `fix(ekp_api): …`, `chore: …`.
