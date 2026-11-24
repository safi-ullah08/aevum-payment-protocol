# Payment flow (sequence diagram)

Source of truth: [`aevum-payment-protocol-uml.html`](./aevum-payment-protocol-uml.html) (original, unmodified). This file is a Mermaid copy that GitHub renders inline.

```mermaid
sequenceDiagram
  participant A as Agent / Payer
  participant G as X402Gateway
  participant C as ChannelCore
  participant P as AgentPolicy
  participant K as CustodyAdapter
  participant T as ClaimToken
  participant D as DisputeManager
  A->>G: GET resource
  G-->>A: 402 + plan price
  A->>G: retry with signed voucher
  G->>C: payWithVoucher / charge (batched)
  C->>P: check(agent, payee, amount)
  alt Allowance mode
    C->>K: pullFrom(payer, amount)
  else Escrow mode
    C->>K: lock from deposit
  end
  C->>T: issue claim (releaseAt = now + window)
  opt flagged or disputed
    P-->>D: autoFlag
    D->>K: refund payer OR release merchant
  end
  T->>K: autoRelease after window
  K-->>G: tUSD8 to merchant
```
