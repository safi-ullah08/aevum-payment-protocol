import { aevumTestnet, assertAllowedNetwork } from '@aevum/shared';
import { createPublicClient, http, type PublicClient } from 'viem';
import type { Env } from './env.js';

export { aevumTestnet, TUSD8 } from '@aevum/shared';

/** Read-only client for QDay Aevum testnet. Refuses to build for any other chain. */
export function createAevumPublicClient(env: Env): PublicClient {
  assertAllowedNetwork(env.AEVUM_CHAIN_ID, env.AEVUM_RPC_URL);
  return createPublicClient({ chain: aevumTestnet, transport: http(env.AEVUM_RPC_URL) });
}
