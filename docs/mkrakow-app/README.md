# The mKraków super-app: teardown and comparison with mKKM

This folder describes the official **mKraków** app (Android package `pl.krakow.mobi`, store
name "mKraków") and, throughout, how it differs from the **mKKM** app (`pl.krakow.kkm.m`)
already torn down in [`../official-app/`](../official-app/README.md).

The short version: **mKraków is a different product on a different backend.** It is the City
of Kraków's multi-service "super-app" — news, waste collection, parking, defibrillator map,
timetables, social consultations, an e-wallet, Karta Krakowska, KKR3+ — and periodic transit
tickets are just one service inside it. The ticket flow is clearly descended from the same
system as mKKM (same purchase steps, the same encrypted `assign-e` / `contract-e` AZTEC
scheme), but it talks to `api.um.krakow.pl`, not `api.ekp.mpk.krakow.pl`, authenticates
completely differently, and uses different crypto key material.

It is **not** a newer version of mKKM. mKKM still exists as its own app. Treat anything here
as a *second*, independent implementation of the same ticketing domain, useful for
cross-checking `ekp_api` / `ekp_crypto` assumptions — not as a drop-in source of keys or
endpoints.

## Contents

| Document | Covers |
|---|---|
| [architecture.md](./architecture.md) | The stack, the service catalog, the OIDC app account, the per-domain `skk-*` gateway and its headers, token renewal, forced update |
| [tickets.md](./tickets.md) | The ticket list, card, control (AZTEC), details, purchase, payment, return — and what is new vs mKKM (extend, buy-similar) |
| [karta-krakowska.md](./karta-krakowska.md) | The Karta Krakowska account: login, status + discount code, mobile/plastic *mediums*, applications, children, KKR3+ |
| [crypto.md](./crypto.md) | The `assign-e` / `contract-e` encryption, how the AES secret is obfuscated in native code, the static extraction, and the confirmed comparison against `ekp_crypto` |

## Source and method

The source is the JavaScript bundle shipped inside the Android app (`.apks` split set in the
gitignored `.dumps/mkrakow/`), captured for **version 4.0.1 (versionCode 323)**. It is Hermes
bytecode **version 96** — the same engine version as the mKKM dump — extracted with
[`hermes-dec`](https://github.com/P1sec/hermes-dec) into three forms in `.dumps/mkrakow/react/`:

| File | What it is |
|---|---|
| `index.android.bundle` | The bundle as shipped (from `base.apk` `assets/`) |
| `index.android.hasm` | Its disassembly |
| `index.android.js` | A register-level decompilation (~1.5 M lines); the one worth reading |

As with mKKM, the decompilation keeps function names (`// Original name: …`), string and
object literals and property names, but not variable names or control structure — every
function is a `switch` over an instruction pointer. Everything here was read from it screen by
screen; branches that decide behaviour (the service gate, the ticket actions, the payment
return, the update check, the crypto) were checked against the raw control flow.

The native key material (see [crypto.md](./crypto.md)) was recovered from
`lib/arm64-v8a/libappmodules.so` with `objdump` (ARM64 disassembly) plus a static XOR of two
byte arrays — no device, no running code.

The same three-tier confidence applies as in the mKKM teardown: **stated plainly** (read
directly), **"appears to" / "probably"** (code present, surrounding condition unresolved), and
**not covered** (native code and server-side decisions).

### Finding things in the dump

The module layout is identical in spirit to mKKM's (Metro modules, each a function of seven
args followed by its numeric id and dependency id list). Application code sits in the high
module ids; the per-screen components carry an `// Original name: …Screen` comment. Useful
anchors in this dump (line numbers move if regenerated; module ids and names do not):

| Where | What |
|---|---|
| module 1383 (`~686139`) | `baseApi` / `staticUrl` endpoint maps built from `BASE_API_URL` |
| `~724164` | Per-service endpoint tables (`skk-tickets`, `skk-card`, `skk-zdmk-*`) and the `skk`/`kkr3plus` access groups |
| `~724155` | Bundled fallback service catalog (every service + `isLoginRequired`) |
| modules 3880–3883 | `useGetSKK` / `usePostSKK` mutation hooks: Bearer + 401→`token/recover`→retry |
| module 3882 | `axiosSkk` instance and the request headers it adds |
| module 3758 (`~1346611`) | `encryptJSON` (RSA) and `aesDecrypt` (contract) |
| module 3842/3843 | `getTicketDecryptionKey` → native `NativeSecretKeysModule` |
| `LoginScreen` / `SMSCodeScreen` (`~785848`, `~787392`) | The app's own OIDC phone+PESEL+SMS sign-in |
| `TicketsScreen` … `PaymentScreen` (`~1343978`–`~1378629`) | The whole ticket flow |
| `KKStatusScreen` … `KKDataConfirmationScreen` (`~1378629`–`~1400967`) | Karta Krakowska |

### Privacy

`.dumps/` is never committed. The bundle and native libraries contain Firebase/service
identifiers and an obfuscated crypto secret; **none of their values are reproduced in this
folder**. Endpoint paths, route names, request field names and user-facing strings are fine.

## The big picture: mKraków vs mKKM

| Aspect | mKKM (`pl.krakow.kkm.m`) | mKraków (`pl.krakow.mobi`) |
|---|---|---|
| Scope | Transit tickets only | City super-app; tickets are one of ~16 services |
| Backend host | `api.ekp.mpk.krakow.pl` (eKP) | `api.um.krakow.pl`, split into `skk-tickets`, `skk-card`, `skk-auth`, `skk-zdmk-*`, `mkrakow-*` gateways |
| App account | Email + password (eKP passenger account) | Phone number + PESEL + SMS OTP → OIDC (OAuth2) tokens |
| Karta Krakowska | An *attribute* of the eKP account (`inhabitant status`), one card | A **separate account** (email+password) linked into the app, with its own plastic/mobile *mediums*, child sub-accounts, applications |
| Where tickets live | The eKP `mkkm` card ("storage medium" code 8) | The Karta Krakowska mobile *medium* |
| Request auth | eKP JWT bearer + cookies; `x-*` device headers | OIDC bearer; gateway `apikey` from Remote Config; `X-Client-Version`/`X-Platform`/`x-device-*` headers |
| Token renewal | `POST auth/token/recover` (refresh token) | OIDC `mkrakow-oauth/token` refresh for the app; `skk-auth/auth/token/recover` for the KK session |
| Ticket crypto | RSA-wrap `assign-e`/`contract-e`, AES-CBC contract → AZTEC | **Same scheme**, different RSA key and different AES secret ([crypto.md](./crypto.md)) |
| Firebase project | `740950577746` | `mkrakow-5ff30` (sender `699259905974`) |
| Forced update | Asks the **store** (Google Play / App Store) for the latest published version and compares | Remote Config `latest_supported_version` → opens `update_url_android` |
| Stack | React Native, Redux, class components | React Native, **Zustand stores + TanStack Query**, function components |
| Languages | Polish only (English stubbed) | Polish, English, Ukrainian |

The ticket *domain model* (ticket type / kind / period / lines, the four-step purchase, tPay,
assign-before-control, return, the status vocabulary) is recognisably the same system. Almost
everything *around* it — identity, gating, transport, persistence, extra services — is
different. The following documents go flow by flow.

### Feature presence: mKKM vs mKraków (ticket area)

| mKKM feature | In mKraków? |
|---|---|
| Ticket list, card, control (AZTEC), details, purchase, payment, return | Yes |
| Device assign before control (max 2 devices) | Yes |
| Extend ticket / buy similar (prefilled purchase form) | Yes — mKKM has these too ("Przedłuż bilet" / "Kup podobny") |
| Line change (`tickets/line-change/edit`) | **Absent** in mKraków |
| 5+1 subscription (`subscriptions/*`, payment card, sign-up) | **Absent** — the "Bilet 5+1" button only opens a ZTP info webpage (`kkAboutInfo`); no backend call at all |
| Invoices (`invoices/*`) | **Absent** in mKraków |
| Stop departures (TTSS WebView) | Different — mKraków has native timetables via `otp-timetables` |
| Karta Krakowska (an attribute of the one eKP account) | **Expanded into a separate account** with plastic/mobile *mediums*, children, applications, plus KKR3+ |

Neither app keeps a local ticket database — mKKM re-fetches from its Redux store on every
visit, and mKraków uses react-query server state (`networkMode` + NetInfo online/offline
detection), re-fetched on mount/focus. Neither applies `FLAG_SECURE` screenshot blanking to the
code screens in its JS (mKraków only holds a keep-awake lock while a code is shown).

## Glossary (additions to the mKKM glossary)

| Term | Meaning |
|---|---|
| SKK | The `skk-*` API family on `api.um.krakow.pl` that backs the Karta Krakowska services (tickets, card, auth). Likely "System Karty Krakowskiej". |
| Service | A tile in mKraków (`bilety`, `kartaKrakowska`, `parkowanie`, …). Each has `isLoginRequired` and, when gated, an access `group` (`skk`, `kkr3plus`). |
| Medium (*nośnik*) | A Karta Krakowska carrier: **plastic** or **mobile** (`nośnik mobilny mKraków`). Tickets and the discount require a mobile medium. |
| KKR3+ | Krakowska Karta Rodzinna 3+, a large-family card program — its own service and free-ride ticket, parallel to Karta Krakowska. |
| App account vs KK account | The OIDC identity you create with phone+PESEL+SMS, vs the email/password Karta Krakowska account you *link* to it. |
