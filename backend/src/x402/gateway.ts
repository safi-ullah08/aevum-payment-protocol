// X402Gateway (UML, off-chain): quote(resource), verifyVoucher(header), settleBatch().

import {
  AEVUM_NETWORK,
  AEVUM_VOUCHER_SCHEME,
  type PaymentRequirements,
  X402_VERSION,
  type PaymentRequiredResponse,
} from '@aevum/shared';
import { type Address, getAddress, zeroAddress } from 'viem';
import type { Env } from '../config/env.js';
import { NotImplementedError } from '../errors.js';
import type { CatalogEntry } from './catalog.js';

/** Builds the x402 PaymentRequirements for a resource from its plan (UML: quote(resource)). */
export function quote(entry: CatalogEntry, resourceUrl: string, env: Env): PaymentRequirements {
  const { plan } = entry;
  return {
    scheme: AEVUM_VOUCHER_SCHEME,
    network: AEVUM_NETWORK,
    maxAmountRequired: plan.amountPerPeriod.toString(),
    resource: resourceUrl,
    description: entry.description,
    mimeType: entry.mimeType,
    // Parties are bytes32 on-chain; an EVM merchant is the low 20 bytes.
    payTo: getAddress(`0x${plan.merchant.slice(-40)}`),
    maxTimeoutSeconds: 60,
    asset: getAddress(env.TUSD8_ADDRESS),
    extra: {
      planId: plan.id,
      channelCore: (env.CHANNEL_CORE_ADDRESS as Address | undefined) ?? zeroAddress,
      disputeWindowSeconds: plan.disputeWindow.toString(),
    },
  };
}

export function paymentRequired(requirements: PaymentRequirements, error: string): PaymentRequiredResponse {
  return { x402Version: X402_VERSION, error, accepts: [requirements] };
}

/**
 * Verifies the X-PAYMENT header against the requirements (UML: verifyVoucher(header) bool).
 * TODO: base64-decode the VoucherPaymentPayload; check scheme/network; check chainId == 44005 and vault;
 * verify the EIP-712 signature with viem; require cumulativeAmount - lastSeen >= price; reject replays
 * through a DURABLE VoucherStore; store the voucher as the channel's latest.
 */
export async function verifyVoucher(_header: string, _requirements: PaymentRequirements): Promise<boolean> {
  throw new NotImplementedError('X402Gateway.verifyVoucher');
}

/**
 * Settles accepted vouchers on-chain in batches (UML: settleBatch()).
 * TODO: for each channel, submit only the latest voucher via ChannelCore.payWithVoucher; mark receipts settled.
 */
export async function settleBatch(): Promise<never> {
  throw new NotImplementedError('X402Gateway.settleBatch');
}
