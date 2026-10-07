# The official mKKM app: UI and UX teardown

This folder describes how the official mKKM client (Android package `pl.krakow.kkm.m`) behaves from
the user's side: which screens exist, how they connect, what each control does and which request
stands behind it. It is a reference for building the same features in mobileKKM or for redesigning
them without losing a rule the backend depends on.

It describes the official app, not mobileKKM. Where mobileKKM already differs on purpose, the
[table at the end](#where-each-flow-stands-in-mobilekkm) says so.

## Contents

| Document | Covers |
|---|---|
| [navigation.md](./navigation.md) | Navigator tree, every route, the tab bar and its gating, transitions, back behaviour |
| [startup-and-session.md](./startup-and-session.md) | Splash, service status, token renewal, the error screen, forced updates, sign-out |
| [auth.md](./auth.md) | Login, registration, password reset, e-mail links, accessibility declaration |
| [home-and-status.md](./home-and-status.md) | Home tiles, Karta Krakowska status and its control code, stop departures |
| [tickets.md](./tickets.md) | Ticket list, the ticket card and its actions, ticket control, details, return, line change |
| [purchase.md](./purchase.md) | The four-step purchase form, summary, payment method, tPay, pending payments |
| [cards.md](./cards.md) | The mKKM card: creating, reattaching, tickets stored on a card |
| [subscription-5plus1.md](./subscription-5plus1.md) | The 5+1 subscription: sign-up, payment card, buying and paying its tickets |
| [account.md](./account.md) | The "More" menu, profile, password, contact, regulations, invoices, account deletion |
| [ui-kit.md](./ui-kit.md) | Colours, fonts, the shared header, dialogs, buttons, form fields, validation, icons |

## Source and method

The source is the JavaScript bundle shipped inside the official Android app, captured on
2026-09-30. It is Hermes bytecode (version 96), kept in the gitignored `.dumps/react/` in three forms:

| File | What it is |
|---|---|
| `index.android.bundle` | The bundle as shipped |
| `index.android.hasm` | Its disassembly |
| `index.android.js` | A register-level decompilation (about 765,000 lines); the one worth reading |

The decompilation keeps function names, string literals, object literals and property names, but
not variable names or control structure: every function is a `switch` over an instruction pointer.
Everything here was read from it screen by screen. Branches that decide what the user sees (the
ticket card's action, the tab gate, the payment branch, the Home tiles, the update check) were
checked against the raw control flow. The rest is reconstructed from names, strings and the order of
calls.

That leaves three kinds of statement in these documents:

- **Stated plainly**: read directly from the code (route names, labels, request names, field lists).
- **"Appears to" / "probably"**: the code is there but the condition around it could not be
  resolved with confidence.
- **Not covered**: anything implemented in native code (the RSA encryption, the string the AES key
  is derived from) and anything the server decides. For those, see the `ekp_api` and `ekp_crypto`
  READMEs.

Nothing here was observed on a running device. Layout descriptions come from style objects, not
screenshots.

### Privacy

`.dumps/` is never committed. The bundle contains service keys (crash reporting, Firebase, the app's
store identifiers). None of them are reproduced here, and they must not be copied into this folder.
User-facing strings, route names and endpoint paths are fine.

### Finding something in the decompiled bundle

The bundle is a list of Metro modules. Each one is a function taking seven arguments, followed by
its numeric id and its dependency list:

```
r7 = function(a0, a1, a2, a3, a4, a5, a6) { ... };
r6 = 1480;            // module id
r5 = [1, 356, ...];   // ids of the modules it imports
```

Inside a module, `rN = a6[i]` followed by a call is `require(dependencies[i])`, and
`_closure1_slotN` are the module-level variables. Named functions carry a comment:

```sh
grep -n "Original name: TicketElement" .dumps/react/index.android.js
```

The application's own code sits in two places: the shared layer in modules 675–745 and the screens in
modules 1479–2035, with third-party libraries in between. Line numbers below are for the current
dump and will move if it is regenerated; module ids and function names will not.

| Module | Line | Contents |
|---|---|---|
| 675 | 284868 | `InitApp`: providers, crash reporting, Firebase, the global `Message` |
| 678 | 285360 | Redux: action types, the single reducer, all thunks (`getTickets`, `getUserData`, …) |
| 679 | 287426 | API service: endpoint table, `get` / `post` / `put`, token renewal, error routing, sign-out, downloads |
| 689, 690 | 292851 | API base URL by environment; environment from the application id suffix |
| 721 | 308411 | `AsyncStorage` helpers and the "payment in progress" ticket list |
| 745 | 318488 | `Message`, the modal used for nearly all feedback |
| 1479 | 549047 | Root navigator (`AppContainer`) and the signed-out stack |
| 1480, 1483 | 549516 | `LoginScreen` and its strings |
| 1482 | 550967 | Colour and font variables |
| 1484 | 551016 | `ParallaxHeader`, the page scaffold of almost every screen |
| 1486–1499, 1519, 1525, 1526, 1530 | 552432 | Form components, `ButtonForm`, `DropFile`, `Address`, `TicketDates`, `WarningDialog` |
| 1494 | 557239 | Field validation (PESEL, NIP, e-mail, postcode, password policy) |
| 1647, 1669 | 624962 | Update dialog and the version comparison |
| 1670, 1689, 1690 | 633266 | `RegisterScreen`, its strings, `PasswordPolicy` |
| 1691, 1692 | 638226 | `ResetPasswordScreen` and its strings |
| 1693–1696 | 639257 | `SplashScreen`, the service status checker, `ErrorScreen` and its strings |
| 1697, 1698 | 641629 | `Accessibility` and the HTML-in-WebView component it uses |
| 1761 | 663041 | Signed-in navigators: the four tab stacks and the "More" route table |
| 1762, 1763 | 663967 | `TabBar` and the shell's strings |
| 1766–1768 | 666497 | `DashboardScreen` (Home), its strings, the tile component |
| 1769–1771 | 667954 | Stop departures and its WebView modal |
| 1772–1774 | 669136 | `TicketsScreen`, the ticket strings (shared by all ticket screens), `TicketElement` |
| 1775 | 671285 | Remote Config key, encryption and decryption wrappers for `assign-e` / `contract-e` |
| 1832, 1833 | 687859 | The two "buy a ticket" call-to-action tiles |
| 1834 | 688479 | `TicketBuy`, the purchase form |
| 1835 | 692278 | `ControlComponents`, the ticket control screen |
| 1837 | 693356 | `SummaryBuy` |
| 1838 | 694235 | `DetailsComponent`, ticket details |
| 1839 | 695879 | `TicketRefundScreen` |
| 1840, 1841 | 696898 | `CardTicketReturnScreen` and the card strings |
| 1842–1845 | 697828 | 5+1: `BuyTicket51Screen`, `Payment51`, strings, `SubscriptionStatus51Screen` |
| 1846, 1847 | 703896 | The "More" menu and the account strings |
| 1859, 1860 | 707430 | `MyProfile` and its strings |
| 1861, 1862 | 708946 | `ContactScreen`, `RegulationScreen` |
| 1863, 1864 | 709733 | `StatusScreen` (Karta Krakowska) and its strings |
| 1866–1869 | 711340 | `CardsScreen`, `CardItem`, `CreateMkkmCardScreen`, `CardTicketsScreen` |
| 1870, 1871 | 714324 | `BanksListScreen` and the tPay WebView (`Payment`) |
| 1874 | 717359 | `LineChangeScreen` |
| 1875–1880 | 718405 | Invoices: list, PDF preview, strings, `BasePage` |
| 1907, 1912, 2029–2034 | 730232 | Invoice creation form, its strings and its parts |
| 2035 | 758392 | `DeleteAccountScreen` |

Strings live in small modules next to the screen that uses them, as `{pl: {...}, en: {...}}`. The
English half is a two-entry stub everywhere and the language is fixed to `pl` at start-up: the
official app is Polish only.

## How the app is built

Knowing the stack explains several of its habits.

- **React Native with class components and Redux.** One reducer, action types prefixed `app/`,
  thunks for every fetch. A single `loading` flag in the store drives the header spinner of most
  screens, so unrelated requests make each other's screens show "loading".
- **React Navigation 7**: a native stack at the root, bottom tabs, one native stack per tab. See
  [navigation.md](./navigation.md).
- **No local database.** Tickets, user data and dictionaries live in the Redux store and are fetched
  again on every start and on most screen visits. The only things persisted are the session token,
  the "remember me" flag and the RSA key (secure storage), plus two `AsyncStorage` entries: the
  sales configuration (five minutes) and the list of tickets whose payment was just made.
- **Feedback is modal.** Success and failure are reported by a full-screen dimmed dialog with one
  button (`Message`), not by inline text or a snackbar. Field-level errors exist only on forms.
- **Server text is shown as it comes.** Where a response has a `message`, the app shows it verbatim.
  The strings in the bundle cover only what the client decides itself.
- **Times are Kraków times.** Every date is converted to `Europe/Warsaw` before display.
- **Double submission is blocked by a busy flag** on each form (`isBusy`, `loading`,
  `paymentLoading`), which also puts the spinner on the button.

## Glossary

| Term | Meaning |
|---|---|
| eKP | *Elektroniczne konto pasażera*, the passenger account. The app and the website `ekp.mpk.krakow.pl` share it. |
| mKKM | *Mobilna Krakowska Karta Miejska*, the virtual card that mobile tickets are stored on. In the API it is a "storage medium" with `cityCardCode` 8. |
| `mkkmData` | The part of the user data that describes the user's mKKM card. Absent when none was created; `detached: true` when it was disconnected from the account. Most ticket features are gated on it. |
| Customer code | *Numer klienta*, the number of the mKKM card, shown on Home and during ticket control. |
| Karta Krakowska | The resident's discount entitlement. "Inhabitant status" in the API. |
| Storage medium | *Nośnik*: any card that can hold tickets, plastic or mobile. |
| Assign (*powiąż*) | Binding a ticket to this device so that it can show the control code. At most two devices per ticket. |
| Ticket control | *Kontrola biletów*: the screen with the AZTEC code an inspector scans. |
| Network / metropolitan ticket | *Sieciowy* (all lines) / *Metropolitalny*: the ticket "type", chosen first when buying. |
| 5+1 | A subscription: six monthly tickets, the sixth free, paid monthly by card. |
| tPay | The payment provider. The app only ever opens its pages. |

## Where each flow stands in mobileKKM

As of October 2026. "Placeholder" means the route exists and shows `ComingSoonScreen`.

| Official flow | mobileKKM | Notes |
|---|---|---|
| Splash, service status, session renewal | Built | Differs on purpose: an `offline` / `unavailable` mode with a banner instead of a blocking error screen, and the forced update comes from the server's `minAppVersion`, not the store. |
| Login, registration, password reset, e-mail links | Built | |
| Accessibility declaration | Not present | |
| Home | Built | Shows the pinned ticket; the official Home is a grid of tiles with no ticket on it. |
| Tickets list, ticket card | Built | Backed by a local database, so it works offline. |
| Ticket control | Built | |
| Ticket details, return | Built | The return adds a confirmation step the official app does not have. |
| Line change | Not present | |
| Purchase, payment, pending payment | Placeholder (`/buy`) | |
| Karta Krakowska status and control code | Placeholder (`/karta-krakowska`) | |
| mKKM card: create, reattach, card tickets | Not present | An attached card is assumed; onboarding is meant to cover the rest. |
| 5+1 subscription | Placeholder (`/subscription`) | |
| Profile, change password, delete account | Placeholder | |
| Contact, regulations, invoices | Not present | |
| Stop departures | Different approach | The official app opens the TTSS website in a WebView. mobileKKM has a native map tab; departures on it are not built yet. |
