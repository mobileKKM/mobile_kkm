# UI kit

Source: the style variables (module 1482), `ParallaxHeader` (1484), `BasePage` (1879), `Message`
(745), `WarningDialog` (1530), the form components (1486–1499, 1519, 1525), `TicketDates` (1526),
the tiles (1768, 1832, 1833), validation (1494).

This is what the official app looks like, for comparison. mobileKKM has its own theme and does not
copy it.

## Colours

Defined once as stylesheet variables and referenced by name.

| Variable | Value | Used for |
|---|---|---|
| `$blue` | `#0D48AF` | Brand colour: headers, the full blue pages, links, icons, the selected tab |
| `$btnColor` | `#0f4880` | Unselected option buttons on blue pages |
| `$blueInput` | `#165985` | Avatar placeholder background |
| `$blueAlert` | `#3268c7` | Notice boxes on blue pages |
| `$blueDark` | `#185a86` | |
| `$blueLight` | `#5873e2` | |
| `$orange` | `#CA4916` | Selected option, the "buy a ticket" tile |
| `$orangeLight` | `#e6c59b` | Subtitle on the orange tile |
| `$zest` | `#dd881d` | Accent icons |
| `$green` | `#547A38` | Success |
| `$error` | `#d91e18` | Errors, negative status |
| `$textBoldColor`, `$trout` | `#47495b` | Headings, line chips, unselected tabs |
| `$gray`, `$grayText` | `#757575` | Secondary text |
| `$grayIcon`, `$btnDisable` | `#696969` | Disabled buttons, placeholder icons |
| `$grayMessage` | `#666666` | Error screen text |
| `$grayBorder` | `#e7e7e7` | Dividers |
| `$grayLight` | `#ededed` | Info boxes on white |
| `$grayBackground` | `#dde5ee` | |
| `$bgColor` | `#f5f5f5` | Page background |
| `$primaryColor` | `#FFF` | |

There is no dark theme. The status bar is always translucent with light content.

## Type

One family, PT Sans, in regular and bold. Typical sizes: page title 20, card headings 20, body
14–18, small print 10–12, the name on control screens 35.

The header title shrinks with the system font scale (17 down to 14 above a scale of 1.7), one of the
few places the app reacts to it.

## Page scaffolds

### `ParallaxHeader`

Almost every screen is wrapped in it. It provides the header, the scroll view, pull-to-refresh and
the loading overlay.

| Property | Default | Effect |
|---|---|---|
| `title` | | Header title |
| `target` | none | `'back'` shows a back arrow that goes back; a route name shows one that navigates there; none shows the logo |
| `image` | `top_header` | Header image; `'bg'` is the full photo used on signed-out and form screens; `null` for none |
| `headerHeight` | 220 | Expanded height |
| `upContent` | 75 | How far the content overlaps the header |
| `fully` | off | Blue background for the whole page (purchase, details, 5+1) |
| `showBottomBackImage` | off | A decorative image pinned to the bottom of blue pages |
| `showProfile` | on | The user's avatar on the right, opening `MyProfile` |
| `userView` | off | Replaces the title with "Witaj, name" |
| `header` | on | Off removes the bar (login, status) |
| `animatedHeader` | on | Off keeps the header from collapsing (ticket control) |
| `loading` | off | Full-screen spinner overlay |
| `onRefresh` | none | Enables pull-to-refresh |
| `scrollTo` | | Hands the screen a function to scroll to an offset (forms scroll to their first error) |

As the content scrolls up, the header image fades and slides away and the header collapses to a
plain blue bar (60 pt on Android, 73 on iOS) holding the back arrow, the title and the avatar.

Three recurring looks follow from the properties:

| Look | Used by |
|---|---|
| Photo background with a white rounded card | Login, registration, reset, profile, create card |
| Short blue header, grey page, white cards | Ticket list, cards, contact, regulations, delete account |
| Fully blue page, white text | Home, purchase, summary, bank list, details, return, 5+1 |

### `BasePage`

A newer, plain scaffold: a fixed blue header with the photo behind it, a back arrow and a title,
content below. Only the invoice list and the PDF preview use it.

## Feedback

### `Message`

The app's one way of saying that something worked or failed.

```
┌──────────────────────────────┐
│             (✓)              │   green tick or red cross, 30 pt
│   HASŁO ZOSTAŁO ZMIENIONE    │   title, upper-cased
│   optional body text         │
│  [ secondary ]  [ ZAMKNIJ ]  │
└──────────────────────────────┘
        on a 60 % black scrim
```

- Types: `success` and `error`.
- One button, "ZAMKNIJ" unless the caller names it. An optional secondary button.
- The close button can be hidden to make the dialog blocking (the forced update).
- It fades in, and the system back button closes it.
- A single instance mounted at the app root can be called from anywhere:
  `getMessenger().showError({title})`, `showSuccess`, `show`, with an optional delay and a close
  callback. Screens also embed their own instance when they need to react to its closing.

### `WarningDialog` and `Modal`

`Modal` is a general dialog with custom content. `WarningDialog` is its two-button form: a title, a
text, a filled positive button and an outlined negative one, with a spinner on the positive button.
It is used for the repeat-payment warning.

Yes/no confirmations (cancel the subscription, remove a ticket) are a `Modal` with a sentence and two
buttons labelled "Tak" and "Nie".

### Inline notices

Coloured boxes inside the page: lighter blue with white text on blue pages (sales announcement,
similar-ticket warning, return rule), light grey italic on white (photo requirements).

## Buttons

`Button`, with these variations:

| Property | Effect |
|---|---|
| (default) | Filled |
| `empty_style` | Outlined |
| `type: 'small'` | Compact, for rows of actions |
| `disable` | Grey, no reaction |
| `loading` | Spinner in place of the label, no reaction |
| `icon` | Leading icon |

Labels are written in capitals in the strings themselves ("KONTROLA BILETÓW", "ZAPISZ ZMIANY"), with
a few sentence-case exceptions ("Zapłać", "Pobierz").

`ButtonForm` is the option button of the purchase form: a large letter or symbol over a small label,
dark blue when idle, orange when selected, grey when disabled, optionally with an "Info" link that
opens an alert.

## Form fields

| Component | Notes |
|---|---|
| `Input` | Text field. Properties: `placeholder`, `required`, `validate`, `textInvalid` (the message under the field), `secure`, `keyboard`, `disable`, `maxLength`, `error` (a server-side message for this field), `valueReplacer` (transforms input as typed, for example to lower case). |
| `MaskedInput` | The same with an input mask: digits only, `99-999`, dates as `YYYY-MM-DD`. |
| `Checkbox` | A label that may contain a link. Has a `light` variant for blue pages. |
| `RadioButton` | Used in the invoice form. |
| `Select` | Dropdown in a modal (the country). |
| `Autocomplete` | A full-screen search: a field at the top, results below, single or multiple choice with a maximum, a custom row renderer, a "close" control. Used for streets and lines. |
| `DropFile` | Photo picker button: camera or library, JPG / PNG / WebP up to 5 MB, with its own permission alerts. |
| `Address` | The five address fields as one block with three validation modes: required, disabled, or "valid if all empty". |
| `Collapse` | Expandable section. |

Forms validate on submit, not while typing. Each field registers a check function with its form; the
submit handler runs them all, marks the failing fields red with their `textInvalid`, and stops.
Server-side field errors come back as a map and are passed to the matching fields as `error`.

Date fields never use the keyboard. Focusing one opens the platform date picker in Polish (`pl-PL`),
with "Wróć" and "Wybierz" on iOS.

The rules behind `validate` are listed in [auth.md](./auth.md#validation-rules).

## Ticket components

| Component | What it is |
|---|---|
| `TicketElement` | The card of the ticket list, see [tickets.md](./tickets.md#ticket-card) |
| `TicketDates` | A read-only ticket card for details, summary and return: line chips, the product name, "WAŻNY OD" and "WAŻNY DO" rows |
| `ShortTicketLineGray` | One line chip: a vehicle icon (45 pt, grey) and the number in white on a dark rounded rectangle |
| `TicketEmptyElement` | The grey "no tickets" placeholder with a 150 pt icon |
| `ApplicationTypeLink` | The large orange call-to-action tile with a watermark icon |
| `NavElement` | The white Home tile |
| `CardItem` | The mKKM card panel |

Ticket-shaped cards share one motif: white, with the left and right edges drawn as perforations (an
image mirrored for the right side) over a faint shadow. The login card repeats it with a dotted line
and two half circles.

## Icons

A custom icon font (generated with IcoMoon) carries nearly all icons, referenced by name. Two menu
rows use FontAwesome 5 instead.

| Names seen | Where |
|---|---|
| `home`, `card`, `id`, `more` | Tab bar |
| `back`, `next`, `next_arrow` | Navigation, chevrons, the details button |
| `user`, `circle_user` | Avatar placeholders |
| `document`, `switch`, `wallet`, `book`, `edit`, `query` | Tiles and buttons |
| `train`, `train2` | The two vehicle icons, bus and tram |
| `no_ticket` | Empty ticket list |
| `check`, `circle_exit`, `exit` | Dialog states, remove |
| `logout`, `list_file` | Menu |
| `file-contract`, `envelope` (FontAwesome) | Menu: regulations, contact |

## Formats

| Thing | Format |
|---|---|
| Date and time on tickets | `DD.MM.YYYY, H:mm` on the list card, `DD.MM.YYYY HH:mm` elsewhere, always in `Europe/Warsaw` |
| Date in forms | `YYYY-MM-DD` |
| Countdown | `mm : ss` |
| Money | Decimal comma, then " zł": `42,50 zł` |
| Line 1000 | "wszystkie linie" / "Wszystkie linie" |
| Yes / no | "Tak" / "Nie", or "TAK" / "NIE" in ticket details |
