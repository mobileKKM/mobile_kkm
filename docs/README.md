# Documentation

Reference material for people building or redesigning features of mobileKKM.

| Section | What it is |
|---|---|
| [`official-app/`](./official-app/README.md) | Teardown of the official mKKM client's UI: every screen, the navigation between them, the rules behind each button, and the requests each step makes. Read it before building a feature the official app already has. |

Protocol-level documentation (endpoints, models, cookies, the encrypted `assign-e` / `contract-e`
calls) lives next to the code, in [`packages/ekp_api/README.md`](../packages/ekp_api/README.md) and
[`packages/ekp_crypto/README.md`](../packages/ekp_crypto/README.md). How the Flutter app itself is
put together is described in [`CLAUDE.md`](../CLAUDE.md).
