// In-memory store STUB for local development only.
//
// WARNING: this must become durable (Postgres, SQLite, Redis with AOF, ...) before real use.
// The replay set (hasSeen/markSeen) lives in process memory. After a restart it is empty, so the gateway
// would re-accept previously used payment payloads and serve resources again for vouchers that were already
// spent. Losing the latest-voucher map also means the watchtower cannot challenge a stale close.

import type { Bytes32 } from '@aevum/shared';
import type { Hex } from 'viem';
import { NotImplementedError } from '../errors.js';
import type { Receipt, ReceiptStore, StoredVoucher, VoucherStore } from './types.js';

export class InMemoryVoucherStore implements VoucherStore {
  private readonly latest = new Map<Bytes32, StoredVoucher>();
  private readonly seen = new Set<Hex>();

  async saveIfNewer(_stored: StoredVoucher): Promise<boolean> {
    throw new NotImplementedError('InMemoryVoucherStore.saveIfNewer');
  }

  async getLatest(_channelId: Bytes32): Promise<StoredVoucher | undefined> {
    throw new NotImplementedError('InMemoryVoucherStore.getLatest');
  }

  async hasSeen(_payloadHash: Hex): Promise<boolean> {
    throw new NotImplementedError('InMemoryVoucherStore.hasSeen');
  }

  async markSeen(_payloadHash: Hex): Promise<void> {
    throw new NotImplementedError('InMemoryVoucherStore.markSeen');
  }
}

export class InMemoryReceiptStore implements ReceiptStore {
  private readonly receipts = new Map<Bytes32, Receipt>();

  async save(_receipt: Receipt): Promise<void> {
    throw new NotImplementedError('InMemoryReceiptStore.save');
  }

  async listUnsettled(): Promise<Receipt[]> {
    throw new NotImplementedError('InMemoryReceiptStore.listUnsettled');
  }

  async markSettled(_paymentIds: Bytes32[]): Promise<void> {
    throw new NotImplementedError('InMemoryReceiptStore.markSettled');
  }
}
