# mKraków: architecture, identity and the SKK gateway

This covers the parts shared by every screen: how the app is built, how it signs in, how it
reaches the backend, and how it renews and force-updates. Ticket and Karta Krakowska specifics
are in [tickets.md](./tickets.md) and [karta-krakowska.md](./karta-krakowska.md).

## The stack

React Native, but a more modern build than mKKM's:

- **Function components with hooks**, not class components.
- **Zustand** stores instead of a single Redux reducer: `useApplicationStore`,
  `useUserInformationStore`, `useKkDataStore`, `useTicketBuyDataStore`,
  `useFavouriteServicesStore`, `useJunkScheduleStore`, `useMapFilterStore`,
  `useNotificationTopicsStore`, and more. State is sliced per concern, not global.
- **TanStack Query (react-query)** for all server state — `useMutation` / `useQuery` with
  per-call `staleTime` / `gcTime`, `refetchOnWindowFocus`, `networkMode: 'always'`. There is
  no single global "loading" flag driving every screen (one of mKKM's quirks).
- **MMKV** (encrypted) for fast local storage; **react-native-encrypted-storage** for secrets
  (session, the RSA `aztecKey`, the OIDC client credentials).
- **React Navigation 7**: a root native stack, a bottom tab bar, one native stack per service
  ("flow navigators").
- **i18next** with Polish, English and Ukrainian (mKKM is Polish-only). Strings live in big
  `{pl, en, uk}` modules.
- **Firebase** (Analytics, Crashlytics, Messaging, Remote Config) on project `mkrakow-5ff30`.

## Navigation

Three bottom tabs:

| Tab | Route | Contents |
|---|---|---|
| Home | `Home` | A personalised dashboard of service tiles |
| Services | `ServiceCatalog` | The full catalog of services to open or add |
| Settings | `Settings` | "More options": language, notifications, analytics consent, about |

Each service pushes its own flow navigator (`TicketsFlow`, `KKFlow`, `KKR3Flow`,
`ParkingFlow`, `EWalletFlow`, `NewsFlow`, `TimeTableFlow`, `JunkScheduleFlow`, …). The app's
own account sign-in is `AuthFlow` (`Login` → `SMSCode` → `Success`).

### The service catalog

A service is described by `serviceId`, `serviceEnabled`, name/description, an optional
`serviceAPI` map of URLs, and gating fields. The live catalog comes from
`GET …/mkrakow-menu/v1/services`; a full fallback list is bundled. Gating:

- `isLoginRequired` — needs the app (OIDC) account.
- When login-required, an access `group` claim decides authorisation: **`skk`** for tickets
  and Karta Krakowska, **`kkr3plus`** for KKR3+. `checkAccess(groups, group)` returns
  `youMustLogInToUseThisService` / `youAreNotAuthorizedToUseThisService` / ok.
- A `logoutRedirection` route is where an unauthorised tap lands (e.g. tickets →
  `UnauthorizedTickets`, Karta Krakowska → `KartaKrakowska`).

The `group` list comes from the OIDC **id_token** (`groups` claim). So the backend decides,
per account, which of tickets / KK / KKR3+ you may use — gating is claim-driven, not a local
card check as in mKKM.

Transit services that mKKM lacks or does differently: `rozkladJazdy` (timetables, via
`otp-timetables` — an OpenTripPlanner backend: routes, directions, stops, departures, trip
planning), plus `parkowanie` (paid-parking zones, `skk-zdmk-spp`), an e-wallet
(`skk-zdmk-pojazdy`/parking balance), waste schedules, AED map, news, consultations, etc.
None of those touch the ticketing backend and are out of scope here.

## Two identities

This is the biggest structural difference from mKKM, which has a single email/password eKP
account that *also* carries the Karta Krakowska entitlement.

### 1. The app account (OIDC, phone + PESEL + SMS)

`LoginScreen` collects a **PESEL** (labelled, confusingly, "PESEL") and a **mobile number**
(`+48` prefix), posts them to `POST …/mkrakow-sms/login` as `{url, username, password, state,
appId}` where `username`=PESEL, `password`=phone, `state`=a random uuid-v4 (dashes stripped),
`appId`=the install id. On success it navigates to `SMSCode`.

`SMSCodeScreen` posts `POST …/mkrakow-sms/validate-sms` as `{state, appId, transactionId,
smsOTP}`. The response **is the session** — the client calls `saveSession(data)` with an OIDC
token set (`access_token`, `refresh_token`, `id_token`, `scope`, `expires_in`) and writes it to
encrypted storage. "Resend code" re-posts `mkrakow-sms/login` and is locked for 15 s. On
success the stack resets to `TabStack` → `Home`.

So the app account has **no password** — it is phone-ownership + PESEL, verified by SMS,
exchanged for OIDC tokens. Compare mKKM's plain email+password eKP login.

### 2. The Karta Krakowska account (email + password, linked)

Separately, `KKLoginScreen` signs in to the Karta Krakowska system with **email + password**
via `POST …/skk-auth/auth/login` `{username, password, rememberMe:true}`. This is the account
that owns the card, its mediums and the entitlement. It is *linked* to the app account during
activation (`skk-auth/mkrakow/activate`, see [karta-krakowska.md](./karta-krakowska.md)), after
which the KK session rides along in its own token store (`useKkDataStore`). mKKM has no
equivalent split — the eKP account is the KK account.

## Reaching the backend

`BASE_API_URL` (`https://api.um.krakow.pl`, from native `react-native-config`; `api-test` in
the test flavour) plus a per-domain path prefix. The gateways:

| Prefix | Purpose |
|---|---|
| `mkrakow-oauth` / `mkrakow-sms` | The app's own OIDC: `token`, `revoke`, `userinfo`; SMS login/validate |
| `mkrakow-menu` | Service catalog |
| `mkrakow-notifications` | Push device registration |
| `skk-auth` | Karta Krakowska login, register, `token/recover`, `account/info`, `mkrakow/activate`, marketing consents |
| `skk-tickets` | Everything ticket-related (list, dictionaries, calculate, buy, pay, banks, assign-e, contract-e, return, payment result/check) |
| `skk-card` | Karta Krakowska account/info, children, applications, mediums, discount code (`citizen/contract`), `mkrakow/deactivate` |
| `skk-zdmk-spp` / `skk-zdmk-pojazdy` / `hub-zdmk` | Parking and vehicles |
| `otp-timetables`, `mpo-schedules`, `kck-atmosfera`, `magazyn-krakow-pl`, `css-slowniki` | Timetables, waste, air quality, magazine, dictionaries |

### Request headers (the `skk` gateway)

The `axiosSkk` instance adds on every request:

- `Content-Type: application/json`
- `X-Client-Version: <appName> <version>`
- `X-Platform: <systemName> <systemVersion>`
- `x-device-name: <manufacturer> <model>`
- `x-device-id: <appId>` (the app's own install id, from `AppId.getAppId()`)
- `apikey: <Remote Config "mKrakowApiKey">` — a gateway key fetched from Firebase Remote
  Config and copied into encrypted storage at startup
- `Authorization: Bearer <token>` — added by the per-call hook, not the base instance

The `x-*` family echoes mKKM's device headers, but mKraków adds the Remote-Config `apikey`
gateway key and an OAuth bearer, and does **not** rely on cookies.

### Auth + silent renewal

Two layers, because there are two identities:

- **App (OIDC)**: a refresh controller (`refreshAuthLogic` / `doActualRefresh` /
  `requestTokens`) posts `grant_type=refresh_token` (form-url-encoded, HTTP Basic client auth)
  to `mkrakow-oauth/token`, single-flight with a watchdog, resets on foreground, and does an
  emergency logout + token revoke on an unrecoverable `invalid_grant` / `invalid_client`. The
  OIDC **client_id / client_secret are per-session** (stored with the session), not baked in.
- **KK session**: every `skk-*` call goes through a `useGetSKKMutation` /
  `usePostSKKMutation` wrapper that attaches the KK bearer and, on a `401`, calls
  `skk-auth/auth/token/recover` **once** (body `{token: <refresh>, deviceId, deviceName}`),
  stores the new `{token, refresh}`, and retries the original request. On refresh failure it
  clears the KK session. This is the same single-flight-recover-once-then-retry shape `ekp_api`
  implements for mKKM, just on a different endpoint and token store.

### Startup, service status, forced update

- At startup the app fetches all Firebase Remote Config values and copies each into encrypted
  storage (this is how `aztecKey`, `mKrakowApiKey` and gateway tokens arrive).
- **Forced update** (`useUpdateGuard`): compares the app version to Remote Config
  `latest_supported_version`; if behind, it blocks and opens `update_url_android`. (mKKM
  instead asks the Google Play / App Store for the latest published version and compares — a
  store check, not a server version gate.)
- **`VCSSystem`** is a *soft* "new services since your last update" notice (per-service
  `minimumAppVersion`/`minimumAppBuild`/`platform`), not a gate.
- A `useSessionValidation` hook periodically hits the OIDC `userinfo` endpoint to confirm the
  app session is still valid.

## Deep links

Scheme `mkrakow://`. Two payment returns are handled: `mkrakow://ticket-payment` (opens the
tickets flow's `Payment` screen) and `mkrakow://parking-payment`. tPay redirects back through
these. There is also an `https`/PDF intent filter and the custom scheme in the manifest.
