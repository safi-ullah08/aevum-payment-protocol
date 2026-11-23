import { useConnect, useConnection, useConnectors, useDisconnect } from 'wagmi';

function shorten(address: string): string {
  return `${address.slice(0, 6)}…${address.slice(-4)}`;
}

/** Connect/disconnect an injected wallet (MetaMask, Rabby, ...). */
export function ConnectButton() {
  const { address, isConnected } = useConnection();
  const connectors = useConnectors();
  const connect = useConnect();
  const disconnect = useDisconnect();

  if (isConnected && address) {
    return (
      <button type="button" className="button" onClick={() => disconnect.mutate()}>
        {shorten(address)} · Disconnect
      </button>
    );
  }

  const connector = connectors[0];
  return (
    <button
      type="button"
      className="button button-primary"
      disabled={!connector || connect.isPending}
      onClick={() => connector && connect.mutate({ connector })}
    >
      {connect.isPending ? 'Connecting…' : 'Connect wallet'}
    </button>
  );
}
