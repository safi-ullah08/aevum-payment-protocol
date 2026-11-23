import type { Chain } from 'viem';

/** QDay Aevum testnet. The ONLY network this project targets. */
export const AEVUM_TESTNET_CHAIN_ID = 44005 as const;
export const AEVUM_TESTNET_RPC_URL = 'https://rpc-test.qday.info' as const;
export const AEVUM_TESTNET_EXPLORER_URL = 'https://explorer-test.qday.info' as const;

/**
 * QDay Origin testnet (chainId 44003, rpc.qday.info). Never point anything at it.
 * Listed only so config validation can reject it explicitly.
 */
export const FORBIDDEN_CHAIN_IDS: readonly number[] = [44003];
export const FORBIDDEN_RPC_HOSTS: readonly string[] = ['rpc.qday.info'];

/** tUSD8: ERC-20 with 6 decimals and EIP-2612 permit, on Aevum testnet. */
export const TUSD8 = {
  address: '0x456569838f1d43009A91ebA4263147Afd7233483',
  decimals: 6,
  symbol: 'tUSD8',
} as const;

/**
 * viem/wagmi chain definition for QDay Aevum testnet.
 * TODO: confirm nativeCurrency with QDay. See README "Open questions".
 */
export const aevumTestnet = {
  id: AEVUM_TESTNET_CHAIN_ID,
  name: 'QDay Aevum Testnet',
  nativeCurrency: { name: 'QDay', symbol: 'QDAY', decimals: 18 },
  rpcUrls: {
    default: { http: [AEVUM_TESTNET_RPC_URL] },
  },
  blockExplorers: {
    default: { name: 'Aevum Explorer', url: AEVUM_TESTNET_EXPLORER_URL, apiUrl: `${AEVUM_TESTNET_EXPLORER_URL}/api` },
  },
  testnet: true,
} as const satisfies Chain;

/** Throws if a chain id or RPC URL points at a network this project must never use. */
export function assertAllowedNetwork(chainId: number, rpcUrl?: string): void {
  if (FORBIDDEN_CHAIN_IDS.includes(chainId)) {
    throw new Error(`chainId ${chainId} is the QDay Origin testnet; never use it`);
  }
  if (chainId !== AEVUM_TESTNET_CHAIN_ID) {
    throw new Error(`chainId ${chainId} is not allowed; only QDay Aevum testnet (${AEVUM_TESTNET_CHAIN_ID}) is supported`);
  }
  if (rpcUrl !== undefined) {
    const host = new URL(rpcUrl).hostname;
    if (FORBIDDEN_RPC_HOSTS.includes(host)) {
      throw new Error(`RPC host ${host} is the QDay Origin testnet; use ${AEVUM_TESTNET_RPC_URL}`);
    }
  }
}
