import type { Bytes32, Voucher } from '@aevum/shared';
import type { Hex } from 'viem';

export interface StoredVoucher {
  voucher: Voucher;
  signature: Hex;
  receivedAt: Date;
}

export interface Receipt {
  paymentId: Bytes32;
  channelId: Bytes32;
  resource: string;
  amount: bigint;
  settled: boolean;
  createdAt: Date;
}

/**
 * Persistence for vouchers. The gateway keeps the highest voucher per channel for settleBatch,
 * and the watchtower submits it when a stale close is detected.
 */
export interface VoucherStore {
  /** Stores `voucher` if its cumulativeAmount is higher than the stored one for the channel. */
  saveIfNewer(stored: StoredVoucher): Promise<boolean>;
  /** Latest (highest cumulativeAmount) voucher for a channel. */
  getLatest(channelId: Bytes32): Promise<StoredVoucher | undefined>;
  /** Replay protection: whether this exact payment payload was already accepted. */
  hasSeen(payloadHash: Hex): Promise<boolean>;
  markSeen(payloadHash: Hex): Promise<void>;
}

/** Persistence for receipts of served resources awaiting on-chain settlement. */
export interface ReceiptStore {
  save(receipt: Receipt): Promise<void>;
  listUnsettled(): Promise<Receipt[]>;
  markSettled(paymentIds: Bytes32[]): Promise<void>;
}
