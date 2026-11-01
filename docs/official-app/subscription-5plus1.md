# The 5+1 subscription

Source: `SubscriptionStatus51Screen` (module 1845), `BuyTicket51Screen` (1842), `Payment51` (1843),
the 5+1 strings (1844).

5+1 is a six-month cycle of monthly tickets, paid one month at a time from a saved payment card, the
sixth month free. It is offered on Home to users with an attached mKKM card who have the resident's
privilege or already have a subscription (see [home-and-status.md](./home-and-status.md)).

Both screens use the full blue page with the title "BILET 5+1".

```mermaid
flowchart TD
    Tile([Home: BILET 5+1]) --> Signed{Signed up?}
    Signed -- no --> Form[Sign-up form] -- subscriptions/sign-in --> Status
    Signed -- yes --> Status[Subscription status]
    Status -- KUP BILET --> Buy[BuyTicket51] -- subscriptions/tickets/buy --> Created[Ticket created,<br/>'Zapłać']
    Created --> Tpay[tPay WebView]
    Status -- Zapłać on a ticket --> Tpay
    Status -- add / change card --> Tpay
    Tpay --> Status
```

## What the status screen loads

On opening, and again every time it regains focus:

- `subscriptions/details`, `dictionary/city-card-types` and `subscriptions/available-actions`
  together,
- the storage media,
- `subscriptions/marketing-consents`.

`details.isSubscriptionSignedIn` decides which of the two states below is shown.

## Not signed up: the sign-up form

Heading "Zapisz się na subskrypcję biletu".

1. **Identity.** PESEL, or the birth date (`YYYY-MM-DD`) for accounts without one, and the e-mail.
   Each is prefilled from the user data and locked when the account already has a value.
2. **"Wybierz nośnik".** The user's cards as selectable panels: type name, owner's name, "Numer
   klienta", and for cards with the resident's status "Status Karty Krakowskiej:" with its dates.
   Cards without the status carry a red line "Ten nośnik nie posiada aktywnego statusu mieszkańca!".
   Only an mKKM card with an active resident's status can be chosen. Tapping any other gives the
   dialog "W aplikacji mobilnej można kupować bilety tylko dla nośników mKKM z aktywnym statusem
   mieszkańca". The first card of the list is preselected when it qualifies; otherwise nothing is.
3. **"Automatyczne odnawianie subskrypcji:"** with one checkbox: "Automatycznie ponawiaj subskrypcję
   po zakończonym cyklu 6-miesięcznym".
4. **Consents** from the server, as checkboxes. Required ones left empty show "Pole wymagane" after
   the first attempt.
5. **"ZAPISZ SIĘ"** → `POST subscriptions/sign-in` with `firstName`, `lastName` and `ccCustomerId`
   of the chosen card (as the storage-media list has them, upper case), `email` and `pesel` or
   `birthDate` from step 1, the consents (with their `content`) and the renewal choice. Not choosing a card gives "Wybierz nośnik". Server errors appear as a dialog
   and under the affected fields. Success reloads the screen into the signed-up state.

## Signed up: the status

**A white card with the subscription's data**, each line a label and a bold value:

| Label | Value |
|---|---|
| (first line) | First and last name |
| Data urodzenia / Pesel: | Whichever the account has |
| Email: | |
| Numer klienta: | |
| Rodzaj karty: | The card type's name, from the dictionary |
| Numer karty płatniczej: | Masked number, when a payment card is saved |
| Początek subskrypcji: | Date and time |
| Automatyczne odnowienie subskrypcji: | Tak / Nie |
| Comiesięczne obciążenie karty: | Tak / Nie |

**Buttons under the data**, each shown only when `available-actions` or the details allow it:

| Button | Does |
|---|---|
| Odnawiaj automatycznie subskrypcję / Nie odnawiaj automatycznie subskrypcji | Opens a confirmation explaining the consequence (below), then `PUT subscriptions/edit` |
| DODAJ KARTĘ PŁATNICZĄ | `POST payments/add-payment-card` (body `null`), then the returned `tPayRedirectUrl` in a WebView; any status but 200 shows the server's `message`. The code is a copy of the card change below. |
| ZMIEŃ DANE KARTY PŁATNICZEJ | `POST payments/change-payment-card`, then the tPay page |
| ANULUJ SUBSKRYPCJĘ | Confirmation "Czy na pewno chcesz anulować subskrypcję 5plus1 ?" (Tak / Nie), then `POST subscriptions/cancel`; success dialog "Subskrypcja została pomyślnie anulowana." |

The renewal confirmation spells out what the switch means:

- Turning it on: further tickets will be bought in a new 5+1 cycle when the current one ends.
  Button "Udziel zgodę".
- Turning it off: the subscription ends after the last ticket of the current cycle, and buying more
  needs a new sign-up. Button "Odwołaj zgodę".

Afterwards: "Zmieniono ustawienie automatycznej subskrypcji", or the server's message.

**Tickets.** Up to two ticket cards, the active one and the pending (future) one (the values in
the sketch are made up):

```
┌───────────────────────────────────────────┐
│ Aktywny bilet                             │   or "Przyszły bilet"
│ Ważny od          01.10.2026 00:00        │
│ Ważny do          31.10.2026 23:59        │
│ Bilet miesięczny sieciowy                 │   product name
│ Ilość miesięcy                 1          │
│ Cena                       80 zł          │
│ Obowiązuje        7 dni w tygodniu        │
│                              więcej →     │   → TicketDetails
│ [ USUŃ BILET ]            [ Zapłać ]      │
└───────────────────────────────────────────┘
```

| Button | Shown when | Does |
|---|---|---|
| USUŃ BILET | `canRemove` | Confirmation "Czy na pewno chcesz usunąć bilet?" (Tak / Nie), then `POST subscriptions/tickets/{ticketGuid}/remove` |
| Zapłać | `canBePaid`, and no payment was just made in this session | `POST subscriptions/tickets/pay` with `{ticketGuid, ignoreWarnings}` (the guid of `pendingTicket`, else of `activeTicket`), then `tpayRedirectUrl` |

"Zapłać" has the same repeat-payment guard as the normal purchase: when the server answers that an
earlier payment is still awaiting confirmation, the "Ponowienie płatności" warning appears and
"Zapłać" there repeats the request with `ignoreWarnings`. Success needs HTTP 200 **and** a
`tpayRedirectUrl`; otherwise `code: 2` (at any status) opens the warning, and anything else shows the
server's `message`.

With no tickets at all: "Brak aktywnych lub przyszłych biletów" and, when the action is available,
"KUP BILET" → `BuyTicket51`.

## Buying a subscription ticket (`BuyTicket51`)

Much simpler than the normal purchase form: the subscription fixes the zone and the period.

**Form:**

- A box: "Nie posiadasz jeszcze biletu w ramach subskrypcji. Wybierz rodzaj biletu oraz czas jego
  aktywacji."
- A warning when the card already holds a valid or future ticket: "Na karcie znajduje się ważny
  bilet lub bilet rozpoczynający ważność w przyszłości. Bilet od … do ….". The dates are
  `ticketSavedOnCard.dateStart` / `dateEnd`, shown in Europe/Warsaw time as `HH:mm DD.MM.YYYY`.
- Two kind buttons: **N** NORMALNY and **U** ULGOWY. Changing the kind reloads
  `subscriptions/tickets/buying-ticket-details` for that kind.
- "Aktywny od:" with tomorrow at midnight in the device's time zone (`moment().add(1, 'day').startOf('day')`). The date cannot be changed, and a note says so: "Bilet
  zakupiony w ramach subskrypcji 5 plus 1 rozpoczyna swoją ważność od dnia jutrzejszego."
- "Nazwa:" with the product name and "Cena" with the price, both from the server.
- A checkbox: "Wyrażam zgodę na comiesięczne obciążanie mojej karty do końca trwania subskrypcji".
- "POTWIERDŹ" → `POST subscriptions/tickets/buy` with the kind (`normal` / `halfPrice`, `normal` at
  first), the consent and the start date (`toISOString()`). The form checks only that a kind is
  chosen; the consent is left to the server, which refuses `false` with a 422. A reply with `errors`
  shows them under the fields, any other failure the server's `message`; success needs HTTP 200 and
  no `code`.

**After the ticket is created** the form is replaced by its result: "Bilet:", "Cena:", "Aktywny od:",
"Aktywny do:", and two buttons: "Zapłać" (opens the returned tPay page) and "WRÓĆ DO LISTY".

## Payment

The 5+1 screens use their own copy of the tPay WebView. It differs from the normal one in how it
recognises the end: it matches the page's address against the success and error return addresses
from the app configuration (falling back to `payment/success` and `payment/rejected` under the
customer website), not against URLs sent with the payment. The outcome is posted to
`payments/result` in the same way.

| Outcome | Buying or paying a ticket | Adding or changing the card |
|---|---|---|
| Success | Płatność została zrealizowana. Dziękujemy | Karta płatnicza została zmieniona |
| Error | Wystąpił błąd, płatność została anulowana | Wystąpił błąd, podczas zmiany carty płatniczej |
| Cancelled | Płatność została anulowana | Proces zmiana karty został anulowany |

After a success the subscription is reloaded 1.5 seconds later, and the purchase screen goes back to
the status screen. Until that reload shows the new state, the "Zapłać" button on the ticket stays
hidden so that the same ticket is not paid twice.

## Seen on the wire

A capture of the official app (2026-11-01) going through sign-up, a card change, buying, removing
and paying tickets and the renewal switch. Shapes only; the values here are illustrative.

**Sign-up.** `subscriptions/sign-in` answers 200 with an empty body. An account whose payment card
the server already knows comes back with `maskedCardNumber` set and `newCard: false`, so "DODAJ
KARTĘ PŁATNICZĄ" never appears for it. `available-actions` then offers `changeCard` and `buyTicket`.

**Buying.** `buying-ticket-details?ticketKind=normal` gives the name and price (`ticketSavedOnCard`
null). `tickets/buy` sends `validFrom` as tomorrow 00:00 local time in UTC. The monthly-charge
consent is required by the server, not only by the form: `isAutomaticSubscriptionEnabled: false`
is refused with HTTP 422 and `{"errors": {"isAutomaticSubscriptionEnabled": ["To pole jest
wymagane"]}}`. The answer adds `kind`, the ticket kind code (21 for a resident's normal ticket).
While the ticket is pending, `available-actions.buyTicket` is false; removing it (`tickets/{guid}/remove`,
body `null`, empty 200) makes it true again.

**The pending ticket's states** in `subscriptions/details`:

| Moment | `status` | `paymentStatus` | `canBePaid` / `canRemove` | `counter` |
|---|---|---|---|---|
| Just bought | 1 | 0 | true / true | 0 |
| tPay done, `payments/result` posted | 1 | 4 | **true** / true | 0 |
| Payment booked | 3 | 2 | false / false | 1 |

The middle row is why the official app hides "Zapłać" after a payment until the reload shows the
booked state. A paid ticket starting tomorrow stays `pendingTicket` (`activeTicket` null).
`user-data.mkkmData.hasActiveSubscription` was true by the time a ticket had been bought.

**Payment return.** Paying a 5+1 ticket and changing the card both end on
`https://ekp.mpk.krakow.pl/payment/success?id=<payment id>&type=1` — the same address as a ticket
purchase, with `type=1` instead of `2`. The `id` matches neither the subscription's nor the mKKM
ticket's `ticketGuid`. `payments/result` is posted with `type: "1"`. After a card change the details
show the new card's masked number. A card change left on tPay's page ends on
`payment/rejected?id=<payment id>&type=1` (a fresh id); the app posts `result: "Error"` with
`type: "1"`, the server answers 200 with an empty body, and the saved card stays as it was.

**The ticket elsewhere.** Once paid, the ticket appears in `mkkm/tickets/list` as `active` with no
5+1 marker, under a different `ticketGuid`; the `transactionCode` is shared. Its details
(`tickets/{transactionCode}`) carry `ticket.promotionName: "5+1"`, `ticketEkp.fivePlusOneTicket:
true` and the payment "ePłatność - cykliczne obciążanie karty płatniczej". It is returnable like any
other ticket (`canReturn`, `minExpireReturnDate`, and `ticket-returns/calculate` answered).

Not captured: `subscriptions/tickets/pay`, `payments/add-payment-card`, a sign-up with a birth date,
the reduced (`halfPrice`) kind and a non-null `ticketSavedOnCard`; what the client does with each is
described in the sections above. `subscriptions/is_signed_in` and `subscriptions/tickets/return`
are defined in the client but never called.
