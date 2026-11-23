// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title ClaimTokenTest
/// @notice Unit test placeholders for ClaimToken (see IClaimToken). Every test is skipped until implemented.
contract ClaimTokenTest is Base {
    // ---------------------------------------------------------------- issue

    function test_issue_happyPath() public {
        vm.skip(true);
        // Asserts: records the claim (merchant, amount, releaseAt) and emits ClaimIssued.
    }

    function test_issue_revertsZeroAmount() public {
        vm.skip(true);
        // Asserts: reverts ZeroAmount when amount is 0.
    }

    function test_issue_revertsInvalidReleaseAt() public {
        vm.skip(true);
        // Asserts: reverts InvalidReleaseAt when releaseAt < block.timestamp.
    }

    function test_issue_revertsClaimAlreadyExists() public {
        vm.skip(true);
        // Asserts: reverts ClaimAlreadyExists for a reused paymentId.
    }

    function test_issue_revertsUnauthorizedWhenCallerIsNotCore() public {
        vm.skip(true);
        // Asserts: access control: reverts Unauthorized for any caller except ChannelCore (no external mint).
    }

    // ---------------------------------------------------------------- redeem

    function test_redeem_happyPath() public {
        vm.skip(true);
        // Asserts: after releaseAt, releases amount to the merchant via custody, marks settled, emits ClaimRedeemed.
    }

    function test_redeem_revertsClaimNotFound() public {
        vm.skip(true);
        // Asserts: reverts ClaimNotFound for an unknown paymentId.
    }

    function test_redeem_revertsWindowNotElapsed() public {
        vm.skip(true);
        // Asserts: reverts WindowNotElapsed before releaseAt.
    }

    function test_redeem_revertsClaimDisputed() public {
        vm.skip(true);
        // Asserts: reverts ClaimDisputed while a dispute is open.
    }

    function test_redeem_revertsClaimAlreadySettled() public {
        vm.skip(true);
        // Asserts: reverts ClaimAlreadySettled on a second redeem.
    }

    function test_redeem_revertsNotClaimHolderWhenCallerIsNotMerchant() public {
        vm.skip(true);
        // Asserts: access control: reverts NotClaimHolder when the caller is not the merchant.
    }

    // ---------------------------------------------------------------- autoRelease

    function test_autoRelease_happyPath() public {
        vm.skip(true);
        // Asserts: after releaseAt, any caller releases to the merchant, marks settled, emits ClaimAutoReleased.
    }

    function test_autoRelease_revertsClaimNotFound() public {
        vm.skip(true);
        // Asserts: reverts ClaimNotFound for an unknown paymentId.
    }

    function test_autoRelease_revertsWindowNotElapsed() public {
        vm.skip(true);
        // Asserts: reverts WindowNotElapsed before releaseAt.
    }

    function test_autoRelease_revertsClaimDisputed() public {
        vm.skip(true);
        // Asserts: reverts ClaimDisputed while a dispute is open.
    }

    function test_autoRelease_revertsClaimAlreadySettled() public {
        vm.skip(true);
        // Asserts: reverts ClaimAlreadySettled when already redeemed or burned.
    }

    // ---------------------------------------------------------------- burnOnRefund

    function test_burnOnRefund_happyPath() public {
        vm.skip(true);
        // Asserts: burns the claim, marks settled and emits ClaimBurned.
    }

    function test_burnOnRefund_revertsClaimNotFound() public {
        vm.skip(true);
        // Asserts: reverts ClaimNotFound for an unknown paymentId.
    }

    function test_burnOnRefund_revertsClaimAlreadySettled() public {
        vm.skip(true);
        // Asserts: reverts ClaimAlreadySettled when already redeemed or burned.
    }

    function test_burnOnRefund_revertsUnauthorizedWhenCallerIsNotDisputeManager() public {
        vm.skip(true);
        // Asserts: access control: reverts Unauthorized for any caller except DisputeManager.
    }
}
