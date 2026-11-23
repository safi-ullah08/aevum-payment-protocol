// EIP-712 typed data for vouchers. Must match the hashing in ECDSAVerifier / HybridMLDSAVerifier.
// The UML does not give the domain name/version or say which contract is verifyingContract.
// See README "Open questions".

import type { Address, TypedDataDomain } from 'viem';
import { AEVUM_TESTNET_CHAIN_ID } from './chain.js';
import type { Voucher } from './types.js';

export const VOUCHER_DOMAIN_NAME = 'AevumPaymentProtocol';
export const VOUCHER_DOMAIN_VERSION = '1';

/** EIP-712 domain for vouchers on Aevum testnet. */
export function voucherDomain(verifyingContract: Address): TypedDataDomain {
  return {
    name: VOUCHER_DOMAIN_NAME,
    version: VOUCHER_DOMAIN_VERSION,
    chainId: AEVUM_TESTNET_CHAIN_ID,
    verifyingContract,
  };
}

/** Field order and types mirror `struct Voucher` in contracts/src/types/Structs.sol. */
export const voucherTypes = {
  Voucher: [
    { name: 'channelId', type: 'bytes32' },
    { name: 'cumulativeAmount', type: 'uint256' },
    { name: 'nonce', type: 'uint64' },
    { name: 'chainId', type: 'uint64' },
    { name: 'vault', type: 'address' },
  ],
} as const;

export const VOUCHER_PRIMARY_TYPE = 'Voucher' as const;

/** Full typed-data payload, ready for viem `signTypedData` / `verifyTypedData` / `hashTypedData`. */
export function voucherTypedData(verifyingContract: Address, message: Voucher) {
  return {
    domain: voucherDomain(verifyingContract),
    types: voucherTypes,
    primaryType: VOUCHER_PRIMARY_TYPE,
    message,
  } as const;
}
