// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title ChannelCoreTest
/// @notice Unit test placeholders for ChannelCore (see IChannelCore). Every test is skipped until implemented.
contract ChannelCoreTest is Base {
    // ---------------------------------------------------------------- open

    function test_open_happyPathEscrow() public {
        vm.skip(true);
        // Asserts: Escrow: pulls the deposit via permit into custody, stores an Active channel whose id commits to block.chainid, emits ChannelOpened.
    }

    function test_open_happyPathAllowance() public {
        vm.skip(true);
        // Asserts: Allowance: applies the permit allowance without pulling funds, stores an Active channel, emits ChannelOpened.
    }

    function test_open_revertsPlanNotActive() public {
        vm.skip(true);
        // Asserts: reverts PlanNotActive for a deactivated or unknown plan.
    }

    function test_open_revertsModeNotAllowed() public {
        vm.skip(true);
        // Asserts: reverts ModeNotAllowed when the plan disables the requested mode.
    }

    function test_open_revertsInvalidExpiry() public {
        vm.skip(true);
        // Asserts: reverts InvalidExpiry when expiry <= block.timestamp.
    }

    function test_open_revertsZeroAmount() public {
        vm.skip(true);
        // Asserts: reverts ZeroAmount when an Escrow open has permit.value == 0.
    }

    // ---------------------------------------------------------------- topUp

    function test_topUp_happyPath() public {
        vm.skip(true);
        // Asserts: increases deposit by amount, moves tokens into custody and emits ToppedUp.
    }

    function test_topUp_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_topUp_revertsZeroAmount() public {
        vm.skip(true);
        // Asserts: reverts ZeroAmount when amount is 0.
    }

    function test_topUp_revertsWrongMode() public {
        vm.skip(true);
        // Asserts: reverts WrongMode on an Allowance-mode channel.
    }

    function test_topUp_revertsInvalidStatus() public {
        vm.skip(true);
        // Asserts: reverts InvalidStatus when the channel is Closing or Closed.
    }

    function test_topUp_revertsNotPayerWhenCallerIsNotPayer() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPayer when a non-payer calls.
    }

    // ---------------------------------------------------------------- charge

    function test_charge_happyPath() public {
        vm.skip(true);
        // Asserts: charges exactly one elapsed period, issues a ClaimToken with releaseAt = now + disputeWindow and emits Charged.
    }

    function test_charge_happyPathCatchUp() public {
        vm.skip(true);
        // Asserts: charges several missed periods, capped at maxCatchUpPeriods.
    }

    function test_charge_marksPastDueWhenAllowancePullFails() public {
        vm.skip(true);
        // Asserts: Allowance: sets status PastDue and emits ChannelPastDue instead of reverting when pullFrom fails.
    }

    function test_charge_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_charge_revertsInvalidStatus() public {
        vm.skip(true);
        // Asserts: reverts InvalidStatus when the channel is Paused, Closing or Closed.
    }

    function test_charge_revertsPeriodAlreadyCharged() public {
        vm.skip(true);
        // Asserts: reverts PeriodAlreadyCharged when called twice in the same period.
    }

    function test_charge_revertsChannelExpired() public {
        vm.skip(true);
        // Asserts: reverts ChannelExpired when no period accrued before expiry.
    }

    function test_charge_revertsInsufficientDeposit() public {
        vm.skip(true);
        // Asserts: Escrow: reverts InsufficientDeposit when the deposit cannot cover the due amount.
    }

    // ---------------------------------------------------------------- payWithVoucher

    function test_payWithVoucher_happyPath() public {
        vm.skip(true);
        // Asserts: settles cumulativeAmount - claimed, updates claimed and voucherNonce, issues a ClaimToken, emits VoucherPaid.
    }

    function test_payWithVoucher_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_payWithVoucher_revertsInvalidStatus() public {
        vm.skip(true);
        // Asserts: reverts InvalidStatus when the channel is not Active.
    }

    function test_payWithVoucher_revertsInvalidVoucherBadSignature() public {
        vm.skip(true);
        // Asserts: reverts InvalidVoucher when the verifier rejects the signature.
    }

    function test_payWithVoucher_revertsInvalidVoucherWrongChainId() public {
        vm.skip(true);
        // Asserts: reverts InvalidVoucher when voucher.chainId != block.chainid.
    }

    function test_payWithVoucher_revertsInvalidVoucherWrongVault() public {
        vm.skip(true);
        // Asserts: reverts InvalidVoucher when voucher.vault is not this deployment.
    }

    function test_payWithVoucher_revertsInvalidVoucherWrongChannel() public {
        vm.skip(true);
        // Asserts: reverts InvalidVoucher when voucher.channelId != channelId.
    }

    function test_payWithVoucher_revertsStaleVoucher() public {
        vm.skip(true);
        // Asserts: reverts StaleVoucher when cumulativeAmount <= claimed.
    }

    function test_payWithVoucher_revertsInsufficientDeposit() public {
        vm.skip(true);
        // Asserts: Escrow: reverts InsufficientDeposit when the delta exceeds the remaining deposit.
    }

    function test_payWithVoucher_revertsPolicyViolation() public {
        vm.skip(true);
        // Asserts: reverts PolicyViolation(flag) when AgentPolicy.check returns a non-None flag for an agent signer.
    }

    // ---------------------------------------------------------------- pause

    function test_pause_happyPath() public {
        vm.skip(true);
        // Asserts: moves Active -> Paused and emits ChannelPaused.
    }

    function test_pause_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_pause_revertsInvalidStatus() public {
        vm.skip(true);
        // Asserts: reverts InvalidStatus when the channel is not Active.
    }

    function test_pause_revertsNotPayerWhenCallerIsNotPayer() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPayer when a non-payer calls.
    }

    // ---------------------------------------------------------------- resume

    function test_resume_happyPath() public {
        vm.skip(true);
        // Asserts: moves Paused -> Active and emits ChannelResumed.
    }

    function test_resume_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_resume_revertsInvalidStatus() public {
        vm.skip(true);
        // Asserts: reverts InvalidStatus when the channel is not Paused.
    }

    function test_resume_revertsNotPayerWhenCallerIsNotPayer() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPayer when a non-payer calls.
    }

    // ---------------------------------------------------------------- shortenExpiry

    function test_shortenExpiry_happyPath() public {
        vm.skip(true);
        // Asserts: sets a strictly earlier expiry and emits ExpiryShortened.
    }

    function test_shortenExpiry_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_shortenExpiry_revertsExpiryNotShorter() public {
        vm.skip(true);
        // Asserts: reverts ExpiryNotShorter when newExpiry >= current expiry (expiry can never be extended).
    }

    function test_shortenExpiry_revertsInvalidExpiry() public {
        vm.skip(true);
        // Asserts: reverts InvalidExpiry when newExpiry < block.timestamp.
    }

    function test_shortenExpiry_revertsInvalidStatus() public {
        vm.skip(true);
        // Asserts: reverts InvalidStatus when the channel is Closing or Closed.
    }

    function test_shortenExpiry_revertsNotPayerWhenCallerIsNotPayer() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPayer when the merchant or anyone else calls.
    }

    // ---------------------------------------------------------------- cancel

    function test_cancel_happyPath() public {
        vm.skip(true);
        // Asserts: stops accrual, refunds unlocked escrow to the payer, leaves issued claims intact, emits ChannelCancelled.
    }

    function test_cancel_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_cancel_revertsInvalidStatus() public {
        vm.skip(true);
        // Asserts: reverts InvalidStatus when the channel is already Closing or Closed.
    }

    function test_cancel_revertsNotPayerWhenCallerIsNotPayer() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPayer when a non-payer calls.
    }

    // ---------------------------------------------------------------- startClose

    function test_startClose_happyPath() public {
        vm.skip(true);
        // Asserts: moves to Closing, records the voucher and challenge deadline, emits CloseStarted.
    }

    function test_startClose_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_startClose_revertsInvalidStatus() public {
        vm.skip(true);
        // Asserts: reverts InvalidStatus when the channel is already Closing or Closed.
    }

    function test_startClose_revertsInvalidVoucher() public {
        vm.skip(true);
        // Asserts: reverts InvalidVoucher for a bad signature, chainId, vault or channelId.
    }

    function test_startClose_revertsStaleVoucher() public {
        vm.skip(true);
        // Asserts: reverts StaleVoucher when cumulativeAmount < claimed.
    }

    function test_startClose_revertsNotChannelPartyWhenCallerIsOutsider() public {
        vm.skip(true);
        // Asserts: access control: reverts NotChannelParty when neither payer nor payee calls.
    }

    // ---------------------------------------------------------------- challengeClose

    function test_challengeClose_happyPath() public {
        vm.skip(true);
        // Asserts: replaces the close voucher with a higher cumulativeAmount and emits CloseChallenged.
    }

    function test_challengeClose_happyPathFromWatchtower() public {
        vm.skip(true);
        // Asserts: access control: any third party (watchtower) may submit a newer valid voucher.
    }

    function test_challengeClose_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_challengeClose_revertsCloseNotStarted() public {
        vm.skip(true);
        // Asserts: reverts CloseNotStarted when the channel is not Closing.
    }

    function test_challengeClose_revertsChallengeWindowClosed() public {
        vm.skip(true);
        // Asserts: reverts ChallengeWindowClosed after the challenge deadline.
    }

    function test_challengeClose_revertsInvalidVoucher() public {
        vm.skip(true);
        // Asserts: reverts InvalidVoucher for a bad signature, chainId, vault or channelId.
    }

    function test_challengeClose_revertsStaleVoucher() public {
        vm.skip(true);
        // Asserts: reverts StaleVoucher when cumulativeAmount <= the recorded close voucher.
    }

    // ---------------------------------------------------------------- finalize

    function test_finalize_happyPath() public {
        vm.skip(true);
        // Asserts: settles the final delta as a claim, refunds the remaining escrow, sets Closed, emits ChannelFinalized.
    }

    function test_finalize_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }

    function test_finalize_revertsCloseNotStarted() public {
        vm.skip(true);
        // Asserts: reverts CloseNotStarted when the channel is not Closing.
    }

    function test_finalize_revertsChallengeWindowOpen() public {
        vm.skip(true);
        // Asserts: reverts ChallengeWindowOpen before the challenge deadline.
    }

    // ---------------------------------------------------------------- claimable

    function test_claimable_happyPath() public {
        vm.skip(true);
        // Asserts: returns the same amount charge() would collect, capped by maxCatchUpPeriods and expiry.
    }

    function test_claimable_returnsZeroWhenPaused() public {
        vm.skip(true);
        // Asserts: returns 0 for a Paused channel.
    }

    function test_claimable_revertsChannelNotFound() public {
        vm.skip(true);
        // Asserts: reverts ChannelNotFound for an unknown channel.
    }
}
