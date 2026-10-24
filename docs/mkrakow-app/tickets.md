# mKraków: tickets

The ticket service (`bilety`, "Bilety okresowe — Dla posiadaczy Karty Krakowskiej" /
"periodic tickets — for Karta Krakowska holders") is gated on the `skk` group and a Karta
Krakowska **mobile medium**. Everything here is served by the `skk-tickets` gateway on
`api.um.krakow.pl`. The flow is clearly the same family as mKKM's but the surrounding identity
and a couple of actions differ.

All `skk-tickets` endpoints (exact paths from the endpoint table):

| Name | Method · path (under `skk-tickets`) |
|---|---|
| Account info (gate) | `account/info` |
| Ticket list | `tickets/list` |
| Kind dictionary | `dictionary/ticket-kind-list` |
| Lines-count dictionary | `dictionary/ticket-number-of-line-list` |
| Period dictionary | `dictionary/ticket-period-list` |
| Transport lines | `tickets/transport-line` |
| Sales configuration | `tickets/ticket-sales-configuration` |
| Calculate price | `tickets/calculate` |
| Buy | `tickets/buy` |
| Pay | `tickets/pay` |
| Payment banks | `payments/banks` |
| Payment result | `payments/result` |
| Payment check | `payments/check` |
| Assign to device | `tickets/assign-e` (encrypted) |
| Ticket code (contract) | `tickets/contract-e` (encrypted) |
| Calculate refund | `tickets/calculate-return-amount` |
| Return | `tickets/return` |

Compared with mKKM's eKP paths: `tickets/ticket-sales-configuration` here takes **no
`{customerCode}` path segment** (mKKM: `tickets/ticket-sales-configuration/{customerCode}`);
return is `tickets/return` + `tickets/calculate-return-amount` (mKKM: `ticket-returns` +
`ticket-returns/calculate`); the encrypted calls are `tickets/assign-e` / `tickets/contract-e`
(mKKM: `mkkm/tickets/assign-e` / `mkkm/tickets/contract-e`). There is **no line-change**
endpoint (mKKM has `tickets/line-change/edit`).

## Entering tickets

Tapping the tile checks the `skk` group. Without the group / login you get
`UnauthorizedTicketsScreen`: "activate Karta Krakowska in mKraków" with buttons to KK login,
KK application, or connect-with-app. With access, `TicketsScreen` loads the list.

## Ticket list

`TicketsScreen` fetches `tickets/list` (react-query, `refetchOnMount: 'always'`,
`refetchOnWindowFocus: 'always'`, 1-day gc) and splits the tickets client-side by `startDate`
vs now into two sections: **Bieżące** (current, `startDate ≤ now`) and **Nadchodzące**
(upcoming, `startDate > now`), each rendered by the shared `Ticket` card. Pull-to-refresh is
wired; a bottom "Kup bilet" (buy) button opens `KKTicketBuy`. Empty state: "Brak biletów".

There is **no local ticket database** — the list is react-query server state, re-fetched on
mount/focus. mKKM is the same: it keeps no local DB and re-fetches from its Redux store on
every visit.

### The ticket card

The `Ticket` component reads `status`, `startDate`, `endDate`, `lines`, `assigned`,
`canAssign`, and a bus/tram line list (`faBus` / `faTrainTram` icons). It shows a status chip
and, when assignable, triggers the device-assign before offering "Kontrola biletu" (control).
Tapping opens `TicketDetails`; a QR/control icon opens `TicketControl`.

### Status vocabulary

The list/detail code maps these `status` values: `active` (Aktywny), `pending` (Oczekuje na
płatność / waiting for payment), `canceled` (Anulowany), `deleted` (Usunięty), `moved`
(Przeniesiony), `returned` (Zwrócony), plus `unknown` (Niedostępny). This matches `ekp_api`'s
`MkkmTicketStatus` (`active`/`pending`/`returned`/unknown) and adds the explicit
`canceled`/`deleted`/`moved` labels the eKP model folds into "unknown".

## Device assign (before control)

Exactly mKKM's model: a ticket must be bound to this device before its AZTEC code can be
shown, max two devices per ticket. The card's activate handler:

1. If `!assigned && !canAssign` → show "ticket already bound to two devices" and stop.
2. Read the RSA `aztecKey` from encrypted storage.
3. `encryptJSON(JSON.stringify({id: ticketGuid, device_name: "<manufacturer> <model>"}),
   aztecKey)` → RSA-wrapped base64.
4. `POST tickets/assign-e` with body `{message: <wrapped>}`.

The payload shape `{id, device_name}` and the `{message}` envelope are identical to mKKM /
`ekp_api`'s `assign`. See [crypto.md](./crypto.md).

## Ticket control (the AZTEC code)

`TicketControlScreen.getAztecData()`:

1. Read `aztecKey` from encrypted storage (error "Wystąpił błąd pobierania kodu biletu" if
   missing).
2. `encryptJSON(JSON.stringify({ticketGuid}), aztecKey)` → `POST tickets/contract-e`
   `{message}`.
3. On success, `aesDecrypt(response.contract, <ticketDecryptionKey>)` → the token rendered as
   an AZTEC barcode (`AztecCode` component). On any failure it shows the generic AZTEC error
   (mirroring mKKM swallowing decryption errors).

The `{ticketGuid}` payload, the `{message}`/`{contract}` envelopes and the IV‖AES-CBC contract
format match mKKM. The AES key is obfuscated in native code and **differs** from mKKM's —
[crypto.md](./crypto.md) has the extraction and comparison.

The control screen keeps the code live via react-query refetch and holds a **keep-awake** lock
while shown. **No screenshot-blocking (`FLAG_SECURE` / secure-view) was found in the JS** — if
it is applied at all it would be native; the bundle only keeps the screen awake. An exact
refresh cadence was not pinned down here.

## Ticket details and actions

`TicketDetailsScreen` shows commodity name, type, kind, period, lines, zone, status, validity
and price (always formatted PLN; `pl-PL` with symbol in Polish). The action set depends on
`status` and server flags:

- **`pending`** (awaiting payment): a "manage" card with **Kontynuuj płatność** (continue
  payment → `TicketPaymentsList`) and **Sprawdź płatność** (check payment → `payments/check`
  with `{id: ticketGuid}`).
- **`active`**: a "manage" card with up to three actions —
  - **Zwróć bilet** (return) when `canReturn` → `RefundTicket`
  - **Przedłuż bilet** (extend) → `ExtendTicket`
  - **Kup taki sam** (buy similar) → `BuySimilarTicket`

**Extend** and **buy-similar** mirror mKKM, which also offers "Przedłuż bilet" / "Kup podobny"
from ticket details into a prefilled purchase form — they are **not** new to mKraków. Both
reuse the purchase machinery: `ExtendTicket` pre-fills the new validity from the current
ticket's
`endDate + 1 day` and recalculates via `tickets/calculate`; `BuySimilarTicket` re-opens the
same ticket's selection. Neither adds a new endpoint — they drive `calculate` → `buy` → `pay`.

## Purchase

`KKTicketBuyScreen` is a stepped form (a header of lettered steps A–E), backed by
`useTicketBuyDataStore`. Steps:

1. **TicketTypeStep** — the top-level type (network vs metropolitan, with/without KK discount),
   each as a `TicketTypeCard` with an info modal.
2. **TicketKindStep** — ticket kind from `dictionary/ticket-kind-list`; info modals for the
   "Aktywizujący" (activation) kind and the KK-discount vs no-discount network/metropolitan
   variants. A **Semestralny** kind (`{code: 14, isNetwork: true, isMetropolitan: true}`) is
   injected client-side.
3. **TicketPeriodStep** — month count or a `TicketDates` activation-date picker, with a
   secondary **"Bilet 5+1"** button (external-link `faShareSquare` icon). That button is
   **purely informational**: its handler is `Linking.openURL(staticUrl.kkAboutInfo)`, which
   opens a ZTP marketing webpage about the 5+1 ticket (`ztp.krakow.pl/…/z-biletem-51-…`). It
   does **not** buy or subscribe, and makes **no backend call of any kind** — neither to
   `skk-tickets` nor to eKP. So mKraków has **no 5+1 functionality**: there are no
   `subscriptions/*` endpoints, no sign-up, no payment card and no renewal. Contrast mKKM,
   where 5+1 is a full card-based subscription (`subscriptions/*`). In mKraków it is a link
   that explains the product and sends you elsewhere.
4. **LinesStep** — for line-scoped tickets: one line or several, chosen via an autocomplete
   over `tickets/transport-line` (each line carries `second_zone` / `has_second_zone` /
   `is_tram` / `is_bus`).
5. **TicketPriceStep** — calls `tickets/calculate` with `{validFrom, ticketNumberOfLineCode,
   lines, specialTransportLine, ticketPeriodCode, ticketKindCode}`, shows the price, and
   "Zapłać" proceeds to payment-method selection.

The `calculate` request fields match `ekp_api.TicketsApi.calculate` almost exactly (same
`validFrom` / `ticketNumberOfLineCode` / `lines` / `specialTransportLine` / `ticketPeriodCode`
/ `ticketKindCode`); mKKM additionally sends `customerCode` in the body, which mKraków does not
(identity is the bearer, not a customer code).

Sales rules come from `tickets/ticket-sales-configuration` (no customer-code path segment) —
nothing is hard-coded, the same way mKKM derives them from that endpoint.

## Payment

`TicketPaymentsListScreen` lists tPay payment methods from `payments/banks` (each a
`{id, …}` with a logo image), laid out in a grid. Choosing one and paying:

- `POST tickets/buy` `{id, tPayPaymentGroupId}` — for a fresh purchase, or
- `POST tickets/pay` `{id, tPayPaymentGroupId, ignoreWarnings}` — to pay an existing
  (`pending`) ticket. A "repayment warning" (`ignoreWarnings`) confirmation guards paying a
  ticket whose previous payment may still be settling.

The response carries a `paymentUrl`. `PaymentScreen` opens it in the in-app browser
(`openBrowser`, a Custom Tab / `SFSafariViewController`-style wrapper). On return:

- The browser hands back a URL whose `success` query param is read (`'true'` / `'false'`).
- The app posts `payments/result` `{id, result: 'Success' | 'Error'}` and refetches the list.
- Outcomes are shown in place: success ("Płatność się powiodła", "find your ticket under
  Bilety okresowe", "the ticket must be bound to your device before first control"), or error
  ("Płatność została zakończona niepowodzeniem").
- A payment that must continue outside the app shows "Wybrana płatność musi być kontynuowana
  poza aplikacją, w przeglądarce" and a "Przejdź do przeglądarki" button.
- tPay also redirects back via the `mkrakow://ticket-payment` deep link, which re-opens
  `Payment`.

The `buy` / `pay` bodies (`{id, tPayPaymentGroupId}`, plus `ignoreWarnings` on pay) and the
`payments/result` `{id, result}` and `payments/check` `{id}` shapes match `ekp_api`'s
`payments` and `tickets` services. mKraków detects the outcome from the **browser return URL's
`success` flag** (and the `mkrakow://ticket-payment` deep link), then posts `payments/result`
with `Success` or `Error`.

## Not ticket-related

The `rozkladJazdy` (timetables) service uses a separate OpenTripPlanner backend
(`otp-timetables`: routes → directions → stops → departures, plus a trip planner) rather than
mKKM's TTSS WebView. It does not touch the ticketing backend and is out of scope for this
teardown.
