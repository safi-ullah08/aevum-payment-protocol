import { aevumTestnet } from '@aevum/shared';
import { useState } from 'react';
import { useChainId, useConnection, useWalletClient } from 'wagmi';
import { addAevumNetwork } from '../lib/addNetwork';

/** Shows "Add Aevum testnet" when the wallet is connected to a different chain. */
export function AddNetworkButton() {
  const { isConnected, chainId: walletChainId } = useConnection();
  const configChainId = useChainId();
  const { data: walletClient } = useWalletClient();
  const [error, setError] = useState<string>();

  if (!isConnected || walletChainId === aevumTestnet.id) return null;

  return (
    <span className="add-network">
      <button
        type="button"
        className="button"
        disabled={!walletClient}
        onClick={() => {
          if (!walletClient) return;
          setError(undefined);
          addAevumNetwork(walletClient).catch((e: unknown) => setError(e instanceof Error ? e.message : String(e)));
        }}
      >
        Add / switch to {aevumTestnet.name} ({configChainId})
      </button>
      {error && <span className="error">{error}</span>}
    </span>
  );
}
