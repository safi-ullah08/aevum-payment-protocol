/** Subscribe page (stub). */
export function SubscribePage() {
  return (
    <section className="page">
      <h1>Subscribe</h1>
      <p className="muted">Open a channel on a plan: choose escrow or allowance mode and set an expiry.</p>
      <h2>TODO</h2>
      <ul className="todo">
        <li>Read the plan via SubscriptionPlans.getPlan(planId).</li>
        <li>Mode selector: Escrow (deposit up front) or Allowance (pull per period). Disable modes the plan does not allow.</li>
        <li>Expiry picker (must be in the future). Escrow: deposit amount input.</li>
        <li>Sign an EIP-2612 permit for tUSD8 (value = deposit or allowance) and call ChannelCore.open(planId, mode, expiry, permit).</li>
      </ul>
    </section>
  );
}
