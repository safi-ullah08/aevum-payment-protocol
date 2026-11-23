// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";
import {Handler} from "./Handler.sol";

/// @title Invariants
/// @notice One invariant_ per "Core invariants" entry in the UML. Runs 64, depth 50 (foundry.toml).
/// @dev Every invariant is skipped until the protocol and Handler are implemented.
contract Invariants is Base {
    Handler internal handler;

    function setUp() public override {
        super.setUp();
        handler = new Handler(
            core, plans, custody, claimToken, disputeManager, policy, tusd8, payer, merchant, agent, arbiter
        );
        targetContract(address(handler));
    }

    /// @notice Invariant 1: Custody balance equals locked deposits plus unreleased claims.
    function invariant_custodyBalanceEqualsLockedPlusUnreleasedClaims() public {
        vm.skip(true);
        // tusd8.balanceOf(custody) == handler.ghost_totalLocked() + handler.ghost_unreleasedClaims()
    }

    /// @notice Invariant 2: Claim tokens are always fully backed; no external mint.
    function invariant_claimTokensFullyBackedNoExternalMint() public {
        vm.skip(true);
        // sum of open claim amounts <= custody balance not attributed to escrow, and every claim was issued
        // by ChannelCore (count of ClaimIssued == count of handler-observed charges plus vouchers)
    }

    /// @notice Invariant 3: Charged amount never exceeds amountPerPeriod times elapsed periods, up to expiry or cancel.
    function invariant_chargedNeverExceedsAccrued() public {
        vm.skip(true);
        // for each channel: ghost_chargedPerChannel <= amountPerPeriod * periodsElapsed(min(now, expiry, cancelledAt))
    }

    /// @notice Invariant 4: Each period is charged at most once; catch-up limited by maxCatchUpPeriods.
    function invariant_eachPeriodChargedAtMostOnce() public {
        vm.skip(true);
        // for each channel and period index: ghost_chargesPerPeriod <= 1, and no single charge spans more than
        // maxCatchUpPeriods periods
    }

    /// @notice Invariant 5: Voucher cumulative amount is strictly increasing; stale vouchers cannot settle.
    function invariant_voucherCumulativeStrictlyIncreasing() public {
        vm.skip(true);
        // handler.ghost_staleVouchersSettled() == 0 and each channel's claimed == ghost_lastCumulative
    }

    /// @notice Invariant 6: Disputes resolve only to payer refund or merchant release.
    function invariant_disputesResolveOnlyToRefundOrRelease() public {
        vm.skip(true);
        // resolvedRefund + resolvedRelease <= raised, every resolved claim is either burned (refund) or released,
        // and no funds left custody through any other path
    }

    /// @notice Invariant 7: Merchant cannot change price or period; only the payer can extend expiry.
    function invariant_planTermsImmutableAndExpiryNotExtendedByMerchant() public {
        vm.skip(true);
        // handler.ghost_planTermChanges() == 0 and handler.ghost_expiryExtensions() == 0
        // (see README Open questions: the UML has shortenExpiry only, so no expiry extension path exists)
    }
}
