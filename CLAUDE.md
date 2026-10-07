# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

mobileKKM: an unofficial, GPL-3.0 Flutter client (Android + iOS) for the mKKM / EKP ticketing backend of ZTP / MPK Kraków, reverse-engineered from the official Android app. The repo is a [pub workspace](https://dart.dev/tools/pub/workspaces) with three members:

- `.` (`mobile_kkm`) — the Flutter app. So far: theme, splash, the signed-out flows (login, registration, password reset, e-mail link handling) and the signed-in shell with its four sections (Home, Tickets, Map, Account). The Map section is a MapLibre map of Kraków with a search-bar placeholder and a button for the user's position; vehicles, stops with live departures and stop search are not built yet. The Tickets section has the ticket's details, its return and the ticket control screen (AZTEC code). Also not built yet, and routed to `ComingSoonScreen`: the purchase flow (`/buy`, opened from the floating button on Tickets and from Home, and from a pending ticket's "Continue payment" and the details' "Extend" / "Buy similar"), edit account, Karta Krakowska, change password, account deletion, the 5+1 subscription.
- `packages/ekp_api` — pure-Dart `dio` client for the EKP backend. No Flutter dependency.
- `packages/ekp_crypto` — pure-Dart crypto for the encrypted `assign-e` / `contract-e` endpoints (RSA-wrapped requests, AES-128-CBC contract decryption → AZTEC token).

Dependency direction: app → `ekp_api` → `ekp_crypto`.

`docs/official-app/` describes the official client's screens and flows (navigation, every button's rule, the request behind each step), reconstructed from its decompiled bundle in `.dumps/react/`. Read the relevant document before building a feature the official app already has; its README has a module map for finding the original code.

## Commands

```bash
flutter pub get        # once, at the repo root — resolves all three members (single lockfile)
dart analyze           # from the root — covers every workspace member; use this, not `flutter analyze`,
                       # which does not run the riverpod_lint analyzer plugin
dart format .          # 120 columns (`formatter.page_width` in analysis_options_shared.yaml); must leave nothing changed
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
dart run build_runner build                            # from the root: the app's drift database (lib/core/database/*.g.dart)
dart format .                                          # required after build_runner: it emits *.g.dart at 80 columns
flutter gen-l10n                                       # lib/l10n/app_localizations*.dart from the .arb files
sh tool/render_branding.sh                             # launcher icons, in-app logo and splash logo from the SVGs
                                                       # (needs Google Chrome, macOS sips); run the next line after it
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

Material widgets come from `package:material_ui/material_ui.dart`, not `package:flutter/material.dart`: go_router 18 only recognises `material_ui`'s `MaterialApp` and silently drops page transitions and the iOS back swipe otherwise. For the same reason `MobileKkmApp` uses `GlobalMaterialLocalizations.delegates` from `material_ui` rather than the generated `AppLocalizations.localizationsDelegates`.

- **Injection seam:** `deviceIdentityProvider`, `tokenStoreProvider`, `userDataCacheProvider`, `appDatabaseProvider` and `dictionaryCacheProvider` throw by default and are overridden in `main()` (`flutter_secure_storage`-backed implementations, the drift database, and JSON files in the application support directory). `ekpClientProvider` builds the `EkpClient` from them. Platform side effects are also providers (`urlOpenerProvider`, `linkSettingsProvider`, `appVersionProvider`, `photoCacheProvider`, `mapViewProvider`, `locationServiceProvider`) so tests can replace them. The profile photo is public (no token): it is loaded with `cached_network_image` behind `PhotoCache` and wiped on sign-out.
- **Auth state:** `AuthController` mirrors `EkpSessionManager`'s event stream into `AuthStatus` (`unknown` → `authenticated` / `unauthenticated`). On startup it renews an expired stored session (10 s cap) before leaving `unknown`.
- **Start-up and app mode:** `appStartupProvider` (`core/providers/app_startup_provider.dart`) runs behind the splash: `service-status`, then the app config (8 s cap). `appStatusProvider` holds the result as `AppMode`: `offline` when the server is unreachable (config skipped), `unavailable` with the server's message when it reports `isAvailable: false` (config still loaded, as in the official client), `outdated` when the config's `minAppVersion` is above `EkpDefaults.clientVersion` (`MobileAppConfig.supportsClient()`), else `online`. `outdated` is the one blocking state: `redirectFor(..., outdated: true)` sends everything to `UpdateRequiredScreen`. The splash waits for exactly this and the session (read, and renewed if expired); nothing else may be loaded behind it. Request order at start: `service-status` → config → `account/user-data` and `mkkm/tickets/list`, the last two independently of each other; `UserDataController` does not ask the server before start-up is through, or at all when outdated. Nothing blocks the UI: `AppStatusBanner` reports the mode and the screens show stored data. `mobileAppConfigProvider` is loaded once per run; only a failed load is repeated (`AppStatusController.check()`).
- **Routing:** `routerProvider` re-runs its redirect whenever `AuthStatus` changes or start-up finishes; until then it passes `AuthStatus.unknown`. The pure function `redirectFor(uri, status)` in `core/router/app_router.dart` holds all the gating logic: `unknown` → splash, `authenticated` → home unless `Routes.isSignedIn`, `unauthenticated` → login unless `Routes.isPublic`. A new signed-out screen must be added to `Routes.isPublic`, a new signed-in one to `Routes.isSignedIn`. The four sections are branches of a `StatefulShellRoute.indexedStack` (`MainShell`); other signed-in screens are top-level routes above the navigation bar.
- **Tickets:** the mobile tickets (`mkkm/tickets/list`) live in a drift database (`core/database/app_database.dart`, table `Tickets`: a few query columns plus the `MkkmTicket` JSON as `payload`, and the user's home-screen `pinned` flag). Screens read only the database (`mkkmTicketsProvider`, `homeTicketProvider`); `TicketSyncController` (`features/tickets/services/ticket_sync.dart`) fills it, and only asks for the list once the user is signed in, start-up is through and the mode is `online` (it does not wait for the user data): as soon as those hold, on return to the foreground (at most once a minute) and on pull-to-refresh. It empties the store on sign-out. It is kept alive from `MobileKkmApp` for that reason. The purchase history (`ticketHistoryProvider`) is a live request and is not stored.
- **Ticket screens:** `MkkmTicketCard` (a `TicketCard` for a mobile ticket) is the one card of the list, Home and the details. Its buttons are `TicketActions`, chosen by `actionOf()` in `utils/ticket_format.dart` in the official client's order: assigned → ticket control (disabled before the start), `processing` → nothing to do, `pending` → continue / check payment, `canAssign` → assign to this device, otherwise a note that other devices hold it. `TicketActionsController` (`services/ticket_actions.dart`) runs `assign-e` and `payments/check` and then refreshes the sync and the open details. A card opens `TicketDetailsScreen` (`/ticket/:transactionCode`, `ticketDetailProvider`, a live request), which leads to `TicketReturnScreen` (`…/return`: a date within `returnDateBounds()`, the server's preview, then the return behind a confirmation). `TicketControlScreen` (`/ticket-control/:ticketGuid`) fetches the contract once, draws the token with `barcode_widget` and closes itself after `codeLifetime` (119 s). The three routes are top-level, above the navigation bar; `Routes.isSignedIn` knows them by prefix.
- **E-mail deep links:** activation / reset links point at `https://ekp.mpk.krakow.pl/konto-uzytkownika/{activate|reset},<token>.html` — a domain the app cannot verify. `EmailLink.tryParse` recognises the path and `redirectFor` maps it to `/activate/:token` or `/reset-password/:token`, which are reachable in every auth state. Android has an unverified intent filter, and `LinkSettings` talks to `MainActivity` over the `de.codebucket.mobile_kkm/links` method channel to check/open the per-app "Open supported links" setting; on iOS these links always open in the browser.
- **Map:** `features/map/`. `MapScreen` puts a search-bar placeholder over the view built by `mapViewProvider`: `TransitMap`, a `maplibre_gl` platform view with OpenFreeMap vector styles (`MapDefaults`, light and dark by theme; no API key). The branch is built on first visit, so the native view only exists once the tab was opened. The screen moves the map through a `MapViewController` that the view attaches to, so it never touches MapLibre itself. The location button asks for the permission on tap (`LocationService`, `geolocator`), then draws the position, moves there and follows it (MapLibre's tracking mode) until the user drags the map away; with the permission from an earlier run it does the same by itself when the tab is opened. The map has no compass (rotation and tilt are off) and its own attribution button is hidden; the (i) button on the screen lists the credits instead (`MapCredits`). The filter button under the location button is a placeholder. Tests get a keyed `SizedBox` instead (`fakeMapKey`, `FakeMapView` as `app.map`, and `FakeLocationService` via `pumpApp(location:)` in the harness).
- **User data:** `userDataProvider` is keyed on `AuthStatus`: cached copy served immediately and revalidated in the background, cache cleared on sign-out.
- **Dictionaries:** the `dictionary/*` lists that give type codes their names (`ticketKindsProvider`, `ticketLineScopesProvider`, `ticketPeriodsProvider`, `cityCardTypesProvider` in `core/providers/dictionary_providers.dart`) are kept as one JSON file each by `FileDictionaryCache` (`core/dictionaries/`). The server marks them `no-cache` and sends no `ETag` or `Last-Modified`, so the age rule is the app's own (`DictionaryController.maxAge`, 24 h): a stored copy is used as it is until then, an older one is returned at once and replaced in the background, and only a missing one makes the caller wait or can fail. The providers are lazy (nothing is requested until a screen watches one), ask the server only while signed in and after start-up, and their files stay across sign-out (public reference data). `transport-line` is a search and is not stored. A new dictionary is one more `Dictionary` constant plus its provider.
- **Errors:** UI text for a failed call goes through `describeError()` (`core/api/error_messages.dart`). Server messages are shown verbatim — the API only returns Polish.
- **l10n:** `lib/l10n/app_en.arb` is the template, `app_pl.arb` the Polish translation; add strings to both. Getter is non-nullable (`AppLocalizations.of(context)`).

### App tests

Widget tests pump the real `MobileKkmApp` through `pumpApp()` in `test/support/harness.dart`: a real `EkpClient` on top of `FakeAdapter` (canned replies keyed by method + path suffix, unmatched requests return 404), an `InMemoryTokenStore`, and fakes for the platform providers. Pass `session: signedInSession` to start signed in. Tests assert on `adapter.requests` / `requestTo()` and on `app.router`. Use `tapVisible()` and `field(label)` from the harness for form interaction.

The harness owns the `ProviderContainer` (`UncontrolledProviderScope`) and gives each test an in-memory drift database: disposing providers together with the widget tree would cancel drift's stream queries, whose clean-up timer the test framework reports as pending. Pass `database:` to seed one or to keep it across two `pumpApp` calls, and `settle: false` when the splash is meant to stay up. A request without a canned reply (404) counts as "online, no config" for start-up. `openTab()`, `pullToRefresh()` and `app.location` cover the shell; `app.container` reads providers no screen shows, and `dictionaryCache:` seeds the dictionaries (`InMemoryDictionaryCache`); `test/support/sample_data.dart` has synthetic tickets (also `ticketDetailJson()` for their details) and user data. The ticket control test reads `ekp_api`'s synthetic contract fixture straight from `packages/ekp_api/test/fixtures/`.

`ekp_api` has its own, separate `MockAdapter` (`packages/ekp_api/test/mock_adapter.dart`): routes match by method + path *fragment* and serve replies as a FIFO queue, and an unregistered route throws.

## Conventions

- Icons are Material Symbols Rounded: `Symbols.<name>_rounded` from `package:material_symbols_icons/symbols.dart`, not `Icons.*`. They are outlined by default (`iconTheme` in `AppTheme`); pass `fill: 1` for a filled one, e.g. the selected navigation destination.
- `always_use_package_imports` is enforced in the app: import as `package:mobile_kkm/...`, never relatively. (The packages use relative imports inside `lib/src/`.)
- Code is `dart format`-clean and `dart analyze` reports no issues; keep both that way.
- Generated files (`*.g.dart`, `*.freezed.dart`, `lib/l10n/app_localizations*.dart`) are excluded from analysis but not from `dart format`.
- `riverpod_lint` runs as an analyzer plugin (`plugins:` in the root `analysis_options.yaml`), for the app only.
- Lint rules shared by all members (correctness, performance, style) and the formatter width live in `analysis_options_shared.yaml`; each member's `analysis_options.yaml` includes it on top of `flutter_lints` (app) or `lints/recommended` (packages). Flutter-only rules and `always_use_package_imports` stay in the root file. Two rules shape everyday code: `always_put_control_body_on_new_line` — the formatter joins a brace-less `if (x) return;` back onto one line, so every control body needs braces — and `discarded_futures` — wrap intentional fire-and-forget calls in `unawaited(...)`.
- Commits follow Conventional Commits with a member scope: `feat(app): …`, `fix(ekp_api): …`, `chore: …`.
