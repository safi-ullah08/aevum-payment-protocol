/** Agent policy page (stub). */
export function AgentPolicyPage() {
  return (
    <section className="page">
      <h1>Agent policy</h1>
      <p className="muted">Set spending caps and a payee allowlist for an agent that signs vouchers for you.</p>
      <h2>TODO</h2>
      <ul className="todo">
        <li>Form: agent address, per-transaction cap, daily cap (tUSD8), expiry → AgentPolicy.setPolicy.</li>
        <li>Allowlist: add payee → allowPayee(agent, payee).</li>
        <li>Revoke button → revoke(agent).</li>
        <li>Preview: check(agent, payee, amount) to show which FlagType a payment would hit.</li>
      </ul>
    </section>
  );
}
