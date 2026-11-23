import { aevumTestnet } from '@aevum/shared';
import type { WalletClient } from 'viem';

/**
 * Asks the connected wallet to add QDay Aevum testnet (EIP-3085 wallet_addEthereumChain),
 * then switch to it. Wallets that already know the chain just switch.
 */
export async function addAevumNetwork(walletClient: WalletClient): Promise<void> {
  await walletClient.addChain({ chain: aevumTestnet });
  await walletClient.switchChain({ id: aevumTestnet.id });
}
