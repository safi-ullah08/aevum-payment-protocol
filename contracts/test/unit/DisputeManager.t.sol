// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title DisputeManagerTest
/// @notice Unit test placeholders for DisputeManager (see IDisputeManager). Every test is skipped until implemented.
contract DisputeManagerTest is Base {
    // ---------------------------------------------------------------- raise

    function test_raise_happyPath() public {
        vm.skip(true);
        // Asserts: opens a dispute inside the window, freezes the claim and emits DisputeRaised.
    }

    function test_raise_revertsDisputeWindowClosed() public {
        vm.skip(true);
        // Asserts: reverts DisputeWindowClosed at or after releaseAt.
    }

    function test_raise_revertsAlreadyDisputed() public {
        vm.skip(true);
        // Asserts: reverts AlreadyDisputed for a payment with an open dispute.
    }

    function test_raise_revertsNotPayerWhenCallerIsNotPayer() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPayer when the caller is not the channel payer.
    }

    // ---------------------------------------------------------------- autoFlag

    function test_autoFlag_happyPath() public {
        vm.skip(true);
        // Asserts: opens a dispute tagged with the flag and emits AutoFlagged.
    }

    function test_autoFlag_revertsInvalidFlag() public {
        vm.skip(true);
        // Asserts: reverts InvalidFlag when flag == FlagType.None.
    }

    function test_autoFlag_revertsDisputeWindowClosed() public {
        vm.skip(true);
        // Asserts: reverts DisputeWindowClosed at or after releaseAt.
    }

    function test_autoFlag_revertsAlreadyDisputed() public {
        vm.skip(true);
        // Asserts: reverts AlreadyDisputed for a payment with an open dispute.
    }

    function test_autoFlag_revertsUnauthorizedWhenCallerIsNotCore() public {
        vm.skip(true);
        // Asserts: access control: reverts Unauthorized for any caller except ChannelCore.
    }

    // ---------------------------------------------------------------- resolveRefund

    function test_resolveRefund_happyPath() public {
        vm.skip(true);
        // Asserts: burns the claim, refunds the payer via custody, closes the dispute and emits ResolvedRefund.
    }

    function test_resolveRefund_revertsNotDisputed() public {
        vm.skip(true);
        // Asserts: reverts NotDisputed when no dispute is open.
    }

    function test_resolveRefund_revertsNotArbiterWhenCallerIsNotArbiter() public {
        vm.skip(true);
        // Asserts: access control: reverts NotArbiter when a non-arbiter calls.
    }

    // ---------------------------------------------------------------- resolveRelease

    function test_resolveRelease_happyPath() public {
        vm.skip(true);
        // Asserts: releases the claim to the merchant via custody, closes the dispute and emits ResolvedRelease.
    }

    function test_resolveRelease_revertsNotDisputed() public {
        vm.skip(true);
        // Asserts: reverts NotDisputed when no dispute is open.
    }

    function test_resolveRelease_revertsNotArbiterWhenCallerIsNotArbiter() public {
        vm.skip(true);
        // Asserts: access control: reverts NotArbiter when a non-arbiter calls.
    }
}
