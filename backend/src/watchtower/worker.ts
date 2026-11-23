// Watchtower (UML, off-chain): watchCloses(), submitLatestVoucher(channelId).
//
// Protects payees from a payer who starts a close with an old voucher: during the challenge window, it
// submits the latest stored voucher through ChannelCore.challengeClose.

import type { Bytes32 } from '@aevum/shared';
import type { PublicClient } from 'viem';
import { NotImplementedError } from '../errors.js';
import type { VoucherStore } from '../store/types.js';

export interface WatchtowerDeps {
  publicClient: PublicClient;
  voucherStore: VoucherStore;
}

export class Watchtower {
  constructor(private readonly deps: WatchtowerDeps) {}

  /**
   * Subscribes to ChannelCore CloseStarted events.
   * TODO: watchContractEvent(CloseStarted) -> compare the event's cumulativeAmount with
   * voucherStore.getLatest(channelId) -> if ours is higher and the window is open, submitLatestVoucher.
   * Also backfill events missed while offline, starting from a persisted block cursor.
   */
  async watchCloses(): Promise<never> {
    throw new NotImplementedError('Watchtower.watchCloses');
  }

  /**
   * Submits the latest stored voucher for a channel via ChannelCore.challengeClose.
   * TODO: needs a wallet client from WATCHTOWER_PRIVATE_KEY (env only).
   */
  async submitLatestVoucher(_channelId: Bytes32): Promise<never> {
    throw new NotImplementedError('Watchtower.submitLatestVoucher');
  }
}
