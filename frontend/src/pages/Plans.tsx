/** Plans page (stub). */
export function PlansPage() {
  return (
    <section className="page">
      <h1>Plans</h1>
      <p className="muted">Browse merchant plans.</p>
      <h2>TODO</h2>
      <ul className="todo">
        <li>List plans from PlanCreated events on SubscriptionPlans (the UML has no list function).</li>
        <li>Show price per period in tUSD8 (6 decimals), period length, dispute window, and allowed modes.</li>
        <li>Hide deactivated plans (PlanDeactivated events).</li>
        <li>Link each plan to the Subscribe page.</li>
      </ul>
    </section>
  );
}
