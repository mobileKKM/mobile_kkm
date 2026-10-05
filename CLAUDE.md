# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

mobileKKM: an unofficial, GPL-3.0 Flutter client (Android + iOS) for the mKKM / EKP ticketing backend of ZTP / MPK Kraków, reverse-engineered from the official Android app. The repo is a [pub workspace](https://dart.dev/tools/pub/workspaces) with three members:

- `.` (`mobile_kkm`) — the Flutter app. So far: theme, splash, and the signed-out flows (login, registration, password reset, e-mail link handling). `HomeScreen` is a placeholder.
- `packages/ekp_api` — pure-Dart `dio` client for the EKP backend. No Flutter dependency.
- `packages/ekp_crypto` — pure-Dart crypto for the encrypted `assign-e` / `contract-e` endpoints (RSA-wrapped requests, AES-128-CBC contract decryption → AZTEC token).

Dependency direction: app → `ekp_api` → `ekp_crypto`.

## Commands

```bash
flutter pub get        # once, at the repo root — resolves all three members (single lockfile)
dart analyze           # from the root — covers every workspace member; use this, not `flutter analyze`,
                       # which does not run the riverpod_lint analyzer plugin
dart format .          # 120 columns (`formatter.page_width` in each analysis_options.yaml); must leave nothing changed
dart fix --apply       # auto-fixes most lint findings

flutter test                                           # app suite, from the root
flutter test test/features/auth/screens/login_test.dart
flutter test --plain-name 'substring of test name'

(cd packages/ekp_api    && dart test)                  # must run from the package dir
(cd packages/ekp_api    && dart test test/auth_flow_test.dart -n 'substring')
(cd packages/ekp_crypto && dart test)
```

`ekp_api` tests load fixtures via the relative path `test/fixtures/<name>.json`, so they fail when run from the repo root.

Code generation (outputs are committed — regenerate and commit them with the source change):

```bash
(cd packages/ekp_api && dart run build_runner build --delete-conflicting-outputs)  # *.freezed.dart / *.g.dart
dart format .                                          # required after build_runner: it emits *.g.dart at 80 columns
flutter gen-l10n                                       # lib/l10n/app_localizations*.dart from the .arb files
sh assets/branding/render.sh && dart run flutter_launcher_icons   # icons from SVG (needs Google Chrome, macOS sips)
dart run flutter_native_splash:create                  # native splash; colours must match SplashScreen
```

## Privacy constraints

- `.dumps/` holds raw network captures with real credentials and personal data. It is gitignored; never commit it, and never copy values from it into fixtures, tests, docs or commit messages.
- Fixtures in `packages/ekp_api/test/fixtures/` are sanitized. Keep new ones synthetic/scrubbed. `packages/ekp_api/tool/` (fixture extraction) is deliberately gitignored and maintainer-local.
- `ekp_crypto` tests use synthetic vectors only; `packages/ekp_crypto/tool/make_synthetic_contract.dart` regenerates the synthetic contract fixture used by `ekp_api`'s tests.

## Architecture

### `ekp_api`

- `EkpClient` (`lib/src/ekp_client.dart`) is the facade: it builds one `Dio` pipeline (cookie jar → `DeviceHeadersInterceptor` → `AuthInterceptor`) and exposes one API object per domain (`auth`, `account`, `tickets`, `payments`, `subscriptions`, `dictionaries`, `storageMediums`, `invoices`, `misc`). Each domain lives in `lib/src/<domain>/` as `<domain>_api.dart` + `<domain>_models.dart`.
- API classes extend `EkpApiService` and wrap calls in `guard()`, which converts `DioException` into the sealed `EkpApiException` hierarchy (`EkpNetworkException`, `EkpUnauthorizedException`, `EkpHttpException`, `EkpSessionExpiredException`). Callers never see `DioException`.
- Request bodies are built as explicit maps inside the typed service methods; response models are `freezed` + `json_serializable` and mirror the observed wire format exactly, inconsistencies included (e.g. `code` is `Object?` because it is numeric on some endpoints and a string on others). Don't "tidy" models away from the wire format.
- `EkpSessionManager` owns the session: persistence through the host-supplied `TokenStore`, a lifecycle event stream (`EkpSessionAuthenticated` / `Updated` / `Expired` / `LoggedOut`), and silent re-auth via `POST auth/token/recover`. Recovery is single-flight, retries the failed request once, and a network failure during recovery keeps the session rather than expiring it. The token endpoint is exempted from Bearer injection and recovery by path in `AuthInterceptor`.
- The host supplies `TokenStore` and `EkpDeviceIdentity`; the package itself stays free of platform code.

Design rationale and the reverse-engineered protocol details are in `packages/ekp_api/README.md` and `packages/ekp_crypto/README.md` (including the RSA key rotation procedure) — read them before changing auth, cookies or the encrypted endpoints.

### App (`lib/`)

Layout: `core/` for shared code (api, platform, providers, router, theme, widgets) and `features/<name>/` split by kind (`screens/`, `providers/`, `widgets/`, `models/`, `utils/`, `constants/`, `services/`).

State is Riverpod 3 with hand-written providers (no `riverpod_generator`); routing is `go_router`.

- **Injection seam:** `deviceIdentityProvider`, `tokenStoreProvider` and `userDataCacheProvider` throw by default and are overridden in `main()` with `flutter_secure_storage`-backed implementations. `ekpClientProvider` builds the `EkpClient` from them. Platform side effects are also providers (`urlOpenerProvider`, `linkSettingsProvider`) so tests can replace them.
- **Auth state:** `AuthController` mirrors `EkpSessionManager`'s event stream into `AuthStatus` (`unknown` → `authenticated` / `unauthenticated`). On startup it renews an expired stored session (10 s cap) before leaving `unknown`.
- **Routing:** `routerProvider` re-runs its redirect whenever `AuthStatus` changes. The pure function `redirectFor(uri, status)` in `core/router/app_router.dart` holds all the gating logic: `unknown` → splash, `authenticated` → home, `unauthenticated` → login unless `Routes.isPublic`. A new signed-out screen must be added to `Routes.isPublic`.
- **E-mail deep links:** activation / reset links point at `https://ekp.mpk.krakow.pl/konto-uzytkownika/{activate|reset},<token>.html` — a domain the app cannot verify. `EmailLink.tryParse` recognises the path and `redirectFor` maps it to `/activate/:token` or `/reset-password/:token`, which are reachable in every auth state. Android has an unverified intent filter, and `LinkSettings` talks to `MainActivity` over the `de.codebucket.mobile_kkm/links` method channel to check/open the per-app "Open supported links" setting; on iOS these links always open in the browser.
- **User data:** `userDataProvider` is keyed on `AuthStatus`: cached copy served immediately and revalidated in the background, cache cleared on sign-out.
- **Errors:** UI text for a failed call goes through `describeError()` (`core/api/error_messages.dart`). Server messages are shown verbatim — the API only returns Polish.
- **l10n:** `lib/l10n/app_en.arb` is the template, `app_pl.arb` the Polish translation; add strings to both. Getter is non-nullable (`AppLocalizations.of(context)`).

### App tests

Widget tests pump the real `MobileKkmApp` through `pumpApp()` in `test/support/harness.dart`: a real `EkpClient` on top of `FakeAdapter` (canned replies keyed by method + path suffix, unmatched requests return 404), an `InMemoryTokenStore`, and fakes for the platform providers. Pass `session: signedInSession` to start signed in. Tests assert on `adapter.requests` / `requestTo()` and on `app.router`. Use `tapVisible()` and `field(label)` from the harness for form interaction.

`ekp_api` has its own, separate `MockAdapter` (`packages/ekp_api/test/mock_adapter.dart`): routes match by method + path *fragment* and serve replies as a FIFO queue, and an unregistered route throws.

## Conventions

- `always_use_package_imports` is enforced in the app: import as `package:mobile_kkm/...`, never relatively. (The packages use relative imports inside `lib/src/`.)
- Code is `dart format`-clean and `dart analyze` reports no issues; keep both that way.
- Generated files (`*.g.dart`, `*.freezed.dart`, `lib/l10n/app_localizations*.dart`) are excluded from analysis but not from `dart format`.
- `riverpod_lint` runs as an analyzer plugin (`plugins:` in the root `analysis_options.yaml`), for the app only.
- Lints are deliberately minimal: `flutter_lints` (app) / `lints/recommended` (packages) plus `directives_ordering`, `sort_pub_dependencies`, and in the app `always_use_package_imports` and three widget-performance rules. Don't grow the list without being asked.
- Commits follow Conventional Commits with a member scope: `feat(app): …`, `fix(ekp_api): …`, `chore: …`.
