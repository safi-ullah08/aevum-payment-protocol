# UML: Aevum Payment Protocol

Aevum Builder Challenge #1. One channel type with two funding modes (escrow, allowance), one payment pipeline that mints claim tokens, settled after a configurable dispute window.

These diagrams are the source of truth for names, structs, function signatures and relationships in this repo. Where they are unclear or inconsistent, see "Open questions" in the [root README](../../README.md#open-questions).

| File | What it is |
|---|---|
| [`aevum-payment-protocol-uml.html`](./aevum-payment-protocol-uml.html) | Original document (class diagram, sequence diagram, invariants). Open it in a browser. |
| [`class-diagram.md`](./class-diagram.md) | Class diagram, rendered by GitHub |
| [`sequence-diagram.md`](./sequence-diagram.md) | Payment flow sequence diagram, rendered by GitHub |
| [`class-diagram.mmd`](./class-diagram.mmd), [`sequence-diagram.mmd`](./sequence-diagram.mmd) | Raw Mermaid sources (for mermaid.live or `mmdc`) |

## Core invariants

1. Custody balance equals locked deposits plus unreleased claims.
2. Claim tokens are always fully backed; no external mint.
3. Charged amount never exceeds `amountPerPeriod` times elapsed periods, up to expiry or cancel.
4. Each period is charged at most once; catch-up limited by `maxCatchUpPeriods`.
5. Voucher cumulative amount is strictly increasing; stale vouchers cannot settle.
6. Disputes resolve only to payer refund or merchant release.
7. Merchant cannot change price or period; only the payer can extend expiry.

Each invariant has a matching `invariant_` stub in [`contracts/test/invariant/Invariants.t.sol`](../../contracts/test/invariant/Invariants.t.sol).
