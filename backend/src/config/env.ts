import { existsSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import {
  AEVUM_TESTNET_CHAIN_ID,
  AEVUM_TESTNET_RPC_URL,
  FORBIDDEN_CHAIN_IDS,
  FORBIDDEN_RPC_HOSTS,
  TUSD8,
} from '@aevum/shared';
import { z } from 'zod';

// Load the monorepo root .env (gitignored) if present. Keys only ever come from there or the process env.
const rootEnv = resolve(dirname(fileURLToPath(import.meta.url)), '../../../.env');
if (existsSync(rootEnv)) process.loadEnvFile(rootEnv);

const address = z.string().regex(/^0x[0-9a-fA-F]{40}$/, 'must be a 0x-prefixed 20-byte address');
const privateKey = z.string().regex(/^0x[0-9a-fA-F]{64}$/, 'must be a 0x-prefixed 32-byte hex private key');
const optional = <T extends z.ZodType>(schema: T) =>
  z.preprocess((v) => (v === '' ? undefined : v), schema.optional());

const EnvSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
  HOST: z.string().default('127.0.0.1'),
  PORT: z.coerce.number().int().positive().default(3001),

  AEVUM_CHAIN_ID: z.coerce
    .number()
    .int()
    .default(AEVUM_TESTNET_CHAIN_ID)
    .refine((id) => !FORBIDDEN_CHAIN_IDS.includes(id), 'QDay Origin testnet (44003) is forbidden')
    .refine((id) => id === AEVUM_TESTNET_CHAIN_ID, `only chainId ${AEVUM_TESTNET_CHAIN_ID} is supported`),
  AEVUM_RPC_URL: z
    .url()
    .default(AEVUM_TESTNET_RPC_URL)
    .refine((u) => !FORBIDDEN_RPC_HOSTS.includes(new URL(u).hostname), 'rpc.qday.info is the Origin testnet'),

  TUSD8_ADDRESS: address.default(TUSD8.address),

  // Deployed contract addresses (printed by contracts/script/Deploy.s.sol). Optional until deployed.
  CHANNEL_CORE_ADDRESS: optional(address),
  SUBSCRIPTION_PLANS_ADDRESS: optional(address),
  CUSTODY_ADAPTER_ADDRESS: optional(address),

  // Secrets: only from .env / process env, never committed.
  GATEWAY_PRIVATE_KEY: optional(privateKey),
  WATCHTOWER_PRIVATE_KEY: optional(privateKey),
});

export type Env = z.infer<typeof EnvSchema>;

/** Parses and validates process.env. Throws with every problem listed if invalid. */
export function loadEnv(source: NodeJS.ProcessEnv = process.env): Env {
  const parsed = EnvSchema.safeParse(source);
  if (!parsed.success) {
    throw new Error(`Invalid environment:\n${z.prettifyError(parsed.error)}`);
  }
  return parsed.data;
}
