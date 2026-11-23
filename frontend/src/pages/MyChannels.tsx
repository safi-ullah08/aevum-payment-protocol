/** My channels page (stub). */
export function MyChannelsPage() {
  return (
    <section className="page">
      <h1>My channels</h1>
      <p className="muted">Manage your payment channels.</p>
      <h2>TODO</h2>
      <ul className="todo">
        <li>List channels where you are payer, from ChannelOpened events (the UML has no channel getter).</li>
        <li>Show status, mode, deposit, claimed, expiry and claimable(channelId).</li>
        <li>Actions: pause, resume, cancel, top up (escrow only), shorten expiry.</li>
        <li>Start close / show challenge window for closing channels.</li>
      </ul>
    </section>
  );
}
