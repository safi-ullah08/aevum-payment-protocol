// x402 wire types shared by the backend gateway and the frontend/agents.
// Shapes follow the x402 v1 spec (402 body with `accepts`, X-PAYMENT request header).

import type { Address } from 'viem';
import type { Bytes32, Voucher } from './types.js';

export const X402_VERSION = 1 as const;
/** Request header carrying the base64-encoded PaymentPayload on the paid retry. */
export const X_PAYMENT_HEADER = 'x-payment' as const;
/** Response header carrying the base64-encoded settlement response. */
export const X_PAYMENT_RESPONSE_HEADER = 'x-payment-response' as const;

/**
 * Payment scheme name for channel vouchers. Not a standard x402 scheme (the standard one is "exact").
 * See README "Open questions".
 */
export const AEVUM_VOUCHER_SCHEME = 'aevum-channel-voucher' as const;
export const AEVUM_NETWORK = 'qday-aevum-testnet' as const;

export interface PaymentRequirements {
  scheme: typeof AEVUM_VOUCHER_SCHEME;
  network: typeof AEVUM_NETWORK;
  /** Price in tUSD8 base units, as a decimal string. */
  maxAmountRequired: string;
  resource: string;
  description: string;
  mimeType: string;
  /** Merchant payout address. */
  payTo: Address;
  maxTimeoutSeconds: number;
  /** tUSD8 token address. */
  asset: Address;
  extra: {
    planId: Bytes32;
    /** ChannelCore address that settles vouchers. */
    channelCore: Address;
    disputeWindowSeconds: string;
  };
}

/** Body of a 402 Payment Required response. */
export interface PaymentRequiredResponse {
  x402Version: typeof X402_VERSION;
  error: string;
  accepts: PaymentRequirements[];
}

/** Decoded X-PAYMENT header. bigint fields are encoded as decimal strings on the wire. */
export interface VoucherPaymentPayload {
  x402Version: typeof X402_VERSION;
  scheme: typeof AEVUM_VOUCHER_SCHEME;
  network: typeof AEVUM_NETWORK;
  payload: {
    voucher: { [K in keyof Voucher]: Voucher[K] extends bigint ? string : Voucher[K] };
    signature: `0x${string}`;
  };
}
