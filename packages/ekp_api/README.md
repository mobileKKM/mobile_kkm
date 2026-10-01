# ekp_api

Unofficial, community-built Dart client for the **EKP** (Elektroniczne Konto
Pasażera) backend that powers the mKKM mobile app of ZTP / MPK Kraków.

> **Disclaimer:** This is an unofficial project, not affiliated with or
> endorsed by ZTP Kraków / MPK Kraków, published for interoperability
> research. Use at your own risk. All endpoint knowledge was derived from
> passive observation of the official client; the raw captures are not
> part of this repository. Licensed GPL-3.0-or-later — see the repository
> LICENSE.

## Design

- Pure Dart (no Flutter dependency) — the host app supplies persistence
  (`TokenStore`) and device identity (`EkpDeviceIdentity`).
- `freezed` + `json_serializable` response models mirroring the observed wire
  format exactly (including its inconsistencies — polymorphic `code` fields,
  one epoch-millisecond date field, envelope/no-envelope mixes). Dates are
  plain ISO-8601 everywhere and parse with stock tooling.
- Requests are built as explicit maps inside typed service methods, keeping the
  wire format visible at a single place.
- Auth: JWT bearer token (45 min) + refresh token. Silent re-auth uses
  `POST auth/token/recover` (refresh token in the body) — the same endpoint
  the official app uses to renew an idle session. (`GET auth/token/refresh`
  exists but is never called by the app, so it is not implemented.)
  Recovery is single-flight under concurrency, retries the failed request
  exactly once and raises `EkpSessionExpiredException` when unrecoverable.
- One Dio pipeline for everything, including token recovery. The auth
  interceptor exempts the token endpoint from Bearer injection and from
  recovery recursion by path.
- Cookies via a **standard** `CookieJar` + dio_cookie_manager — no custom
  jar. The server itself defines the cookie lifecycle: login/recover
  responses store the auth cookie trio, and the logout response overwrites
  them with blank values (which the jar then replays, matching the official
  client). The jar is in-memory; cookies are functionally redundant (the
  Bearer header authenticates) and are sent purely for traffic parity.
- Encrypted endpoints (`assign-e` / `contract-e`) delegate their crypto to
  the sibling `ekp_crypto` package (RSA-wrapped request payloads, AES-128-CBC
  contract decryption). Keys live there, documented, with constructor-level
  override hooks.

## Usage

```dart
import 'package:ekp_api/ekp_api.dart';

final client = EkpClient(
  device: EkpDeviceIdentity(
    deviceId: '23a71d82a4f5a3e1',
    platform: 'android 34',
    deviceName: 'unknown Android SDK built for arm64',
  ),
  tokenStore: myTokenStore, // your persistence
);

final session = await client.auth.login('user@example.com', 'secret');
final userData = await client.account.userData();
final tickets = await client.tickets.mkkmTickets();

// Device-assign + AZTEC contract (crypto handled by ekp_crypto):
final assign = await client.tickets.assign(ticketGuid); // -> {assigned: true}
final contract = await client.tickets.contract(ticketGuid);
final aztecHex = contract.decodeAztec(); // 512-char token, null on failure

client.session.events.listen((event) { /* auth lifecycle */ });
```

## Not yet covered

- Subscription (5+1) ticket purchase (`buyTicket` action) and the
  automatic-renewal toggle (`isAutomaticSubscriptionEnabled`) — sign-in,
  card change and cancellation *are* implemented
- Inhabitant contract signing
- The tpay payment webview itself (the `payments/result` callback after a
  successful/rejected payment *is* implemented; rendering the webview is
  the host app's job)

## License

GPL-3.0-or-later — see the repository [LICENSE](../LICENSE).
Copyright (C) 2026 David Sn.
