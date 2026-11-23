import { aevumTestnet } from '@aevum/shared';
import { createConfig, http, injected } from 'wagmi';

/** wagmi config: QDay Aevum testnet (44005) only. Never add the Origin testnet (44003). */
export const wagmiConfig = createConfig({
  chains: [aevumTestnet],
  connectors: [injected()],
  transports: {
    [aevumTestnet.id]: http(aevumTestnet.rpcUrls.default.http[0]),
  },
});

declare module 'wagmi' {
  interface Register {
    config: typeof wagmiConfig;
  }
}
