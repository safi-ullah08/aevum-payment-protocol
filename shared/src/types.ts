// TypeScript mirrors of contracts/src/types/{Enums,Structs}.sol.
// Keep the enum order identical to Solidity: the numeric values are the on-chain encoding.

import type { Address, Hex } from 'viem';

/** bytes32 */
export type Bytes32 = Hex;

export const Mode = {
  Escrow: 0,
  Allowance: 1,
} as const;
export type Mode = (typeof Mode)[keyof typeof Mode];

export const Status = {
  Active: 0,
  Paused: 1,
  PastDue: 2,
  Closing: 3,
  Closed: 4,
} as const;
export type Status = (typeof Status)[keyof typeof Status];

/** Values inferred from AgentPolicy; the UML does not list them. See README "Open questions". */
export const FlagType = {
  None: 0,
  NoPolicy: 1,
  PolicyExpired: 2,
  PerTxCapExceeded: 3,
  DailyCapExceeded: 4,
  PayeeNotAllowed: 5,
} as const;
export type FlagType = (typeof FlagType)[keyof typeof FlagType];

/** struct PaymentChannel */
export interface PaymentChannel {
  id: Bytes32;
  payer: Bytes32;
  payee: Bytes32;
  originChainId: bigint; // uint64
  mode: Mode;
  planId: Bytes32;
  deposit: bigint; // uint256, tUSD8 base units
  claimed: bigint; // uint256
  start: bigint; // uint64
  expiry: bigint; // uint64
  voucherNonce: bigint; // uint64
  status: Status;
}

/** struct Plan */
export interface Plan {
  id: Bytes32;
  merchant: Bytes32;
  amountPerPeriod: bigint; // uint256, tUSD8 base units
  period: bigint; // uint64, seconds
  maxCatchUpPeriods: number; // uint8
  disputeWindow: bigint; // uint64, seconds
  escrowAllowed: boolean;
  allowanceAllowed: boolean;
}

/** struct Voucher (EIP-712 message) */
export interface Voucher {
  channelId: Bytes32;
  cumulativeAmount: bigint; // uint256
  nonce: bigint; // uint64
  chainId: bigint; // uint64
  vault: Address;
}

/** struct Permit (EIP-2612 signature passed to ChannelCore.open) */
export interface Permit {
  value: bigint;
  deadline: bigint;
  v: number;
  r: Hex;
  s: Hex;
}

/** Deployed protocol addresses (filled from env after script/Deploy.s.sol). */
export interface ProtocolAddresses {
  channelCore: Address;
  subscriptionPlans: Address;
  custodyAdapter: Address;
  claimToken: Address;
  disputeManager: Address;
  agentPolicy: Address;
  ecdsaVerifier: Address;
  hybridMldsaVerifier: Address;
  localMessenger: Address;
}

/** Converts an EVM address to the bytes32 party encoding used on-chain (left-padded). */
export function addressToBytes32(address: Address): Bytes32 {
  return `0x${address.slice(2).toLowerCase().padStart(64, '0')}`;
}
