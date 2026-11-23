/** Merchant page (stub). */
export function MerchantPage() {
  return (
    <section className="page">
      <h1>Merchant</h1>
      <p className="muted">Create plans, view claims, and handle the dispute queue.</p>
      <h2>TODO</h2>
      <ul className="todo">
        <li>Create a plan form → SubscriptionPlans.createPlan(plan). Terms cannot change afterwards; warn before submitting.</li>
        <li>Deactivate a plan → deactivatePlan(planId).</li>
        <li>Claims table from ClaimIssued events: amount, releaseAt, status. Redeem after the window → ClaimToken.redeem(paymentId).</li>
        <li>Dispute queue from DisputeRaised / AutoFlagged events (resolution is arbiter-only).</li>
      </ul>
    </section>
  );
}
