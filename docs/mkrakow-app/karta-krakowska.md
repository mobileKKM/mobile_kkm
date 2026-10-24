# mKraków: Karta Krakowska

This is the area that diverges most from mKKM. In mKKM, "Karta Krakowska" is an *attribute* of
the single eKP account (`inhabitant status`) and the discount simply applies. In mKraków it is
a **separate account** with its own login, its own physical/mobile *mediums*, child
sub-accounts, and application forms — all on the `skk-card` / `skk-auth` gateways.

Routes (the `KKFlow` navigator): `KartaKrakowska` (entry), `KKStatus`, `KKLogin`, `KKAccount`,
`KKCreateAccount`, `KKApplicationForm`, `KKAddMediumForm`, `KKChangeMediumForm`,
`KKAddChildrenForm`, `KKChildrenAccounts`, `KKChildrenAddMediumForm`,
`KKChildrenChangeMediumForm`, `KKDataConfirmation`.

Endpoints (`skk-card` unless noted):

| Name | Path |
|---|---|
| Account info | `account/info` |
| Children | `account/children` |
| Last active application | `application/last-active` |
| Create application | `application/create` |
| Upload photo | `application/{applicationId}/photo` |
| Add child to application | `application/{applicationId}/child` |
| Change medium | `application/change-form` |
| Add medium | `application/additional-form` |
| Discount/status code | `citizen/contract?generateAztecCode=false` |
| Deactivate in app | `mkrakow/deactivate` |
| KK login | `skk-auth/auth/login` |
| KK token recover | `skk-auth/auth/token/recover` |
| KK account info | `skk-auth/account/info` |
| Link to app | `skk-auth/mkrakow/activate` |
| Register KK account | `skk-auth/register` |
| Marketing consents | `skk-auth/auth/marketing-consents` |

## Linking a Karta Krakowska to the app

Two ways in, both ending at a link step:

- **Log in** (`KKLoginScreen`, email+password → `skk-auth/auth/login`
  `{username, password, rememberMe:true}`), then
- **KKDataConfirmation**: enter and confirm a phone number (`+48`), accept the regulations and
  privacy policy, and `POST skk-auth/mkrakow/activate` `{phoneNumber}`. An SMS to that number
  verifies and **connects** the Karta Krakowska to the mKraków app account ("Aby korzystać z
  Karty Krakowskiej dokończ proces i połącz się z mKraków"). After this the `skk` group appears
  in the app's id_token and tickets unlock.

If you have no Karta Krakowska yet, the entry screen routes you to create an account
(`KKCreateAccount` → `skk-auth/register` `{firstName, lastName, pesel, email, password,
repeatPassword, marketingConsents, registrationToken, recaptcha}`) and then to apply for the
card. The "in-app activation" variant (`cardInAppActivationButton`) and the website route both
exist.

## KKStatus — status and the discount code

`KKStatusScreen` fetches `skk-card/account/info` and shows the card holder's **customer code**,
`privilegeStartDate` / `privilegeEndDate`, and whether the privilege is currently valid
(`customerHasValidPrivilege`). If the privilege is lost it shows "Straciłeś uprawnienia Karty
Krakowskiej" with a link to the KK website to restore it; a partners-list link is also present.

A **show code** action fetches `skk-card/citizen/contract?generateAztecCode=false` and renders
the returned `contract` as the discount/identity code (the inspector-facing Karta Krakowska
code). Note `generateAztecCode=false` — unlike the ticket contract, this status code is not an
AZTEC; it is a `contract` value the component displays directly. This parallels mKKM's Karta
Krakowska status code (the server-rendered status PNG) but is reached through the `skk-card`
`citizen/contract` endpoint rather than eKP's `account/inhabitant-contract`.

## Mediums (nośniki)

A Karta Krakowska can exist as a **plastic** card and/or a **mobile** medium
(`nośnik mobilny mKraków`). `KKAccountScreen` reads `account/info.mediumList`; a medium named
`"KK"` counts as the mobile medium. **Tickets and the in-app discount require a mobile medium**
— without one the screen says "Nie posiadasz Karty Krakowskiej w formie mobilnej" and offers to
apply for one.

Actions on the account screen:

- **Add medium** (`KKAddMediumForm`, `mediumForm: 'plastic' | 'mobile'`) → `application/additional-form`
- **Change medium** (`KKChangeMediumForm`) → `application/change-form` (e.g. plastic → mobile,
  "Wymagana zmiana nośnika na mobilną Kartę Krakowską")
- **Apply for the card** (`KKApplicationForm`) → `application/create`
- **Add a child** (`KKAddChildrenForm`) → `application/{applicationId}/child`
- **Show children's entitlements** (`KKChildrenAccounts` + `account/children`)

### Application / medium form payloads

`application/create` (`KKApplicationForm`) sends: `mediums`, `firstName`, `lastName`,
`birthDate`, `pesel`, `city`, `postalCode`, `street`, `houseNumber`/`buildingNumber`,
`apartmentNumber`, `registeredAddress`, `isRegisteredInKrakow`, `createMkk`,
`createPlasticCard`, `deliveryCard`, `zikitAccepted`, `email`, `phoneNumber`, `consent`. The
photo is uploaded separately to `application/{applicationId}/photo` as `multipart/form-data`
(`photo`, `type`, `name`). `mobileCracowCardStatus` / `properties` describe the requested
medium(s).

`additional-form` / `change-form` send a reduced set (`firstName`, `lastName`, `birthDate`,
`pesel`, `createMkk`, `createPlasticCard`, `deliveryCard`, photo). The child form adds
`mediums`, `email`, `zikitAccepted` and its own photo.

A residence rule is surfaced in the form: to get a Karta Krakowska you must be registered in
Kraków or pay taxes there (otherwise email a PIT confirmation to `okazpit@kk.krakow.pl`).

## KKR3+ (Krakowska Karta Rodzinna 3+)

A parallel service (`KKR3Flow`, group `kkr3plus`) for the large-family card: its own
activation (`KKR3Activation` → consents → success), status screen (client code, active-from/to,
active/inactive), a **free-ride ticket** ("bilet wolnej jazdy", `showTicketKKR3`) shown as a
control code, and a partners list. It is activated and linked much like Karta Krakowska
(phone + SMS → connect with app) but on the `so-kkr3` / `so-kkr3-add` backends. mKKM has no
KKR3+ at all.

## Deactivation

`skk-card/mkrakow/deactivate` unlinks the Karta Krakowska from the app ("Czy na pewno chcesz
dezaktywować konto w aplikacji mKraków?"), after which the app's extra capabilities are
removed. This is lighter than mKKM's `account/anonymise` (which deletes the whole eKP account);
here it only severs the link, because the KK account lives independently of the app account.
