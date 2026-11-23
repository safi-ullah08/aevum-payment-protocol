// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title CustodyAdapterTest
/// @notice Unit test placeholders for CustodyAdapter (see ICustodyAdapter). Every test is skipped until implemented.
contract CustodyAdapterTest is Base {
    // ---------------------------------------------------------------- pullFrom

    function test_pullFrom_happyPath() public {
        vm.skip(true);
        // Asserts: transfers amount from payer to custody and emits Pulled.
    }

    function test_pullFrom_revertsZeroAmount() public {
        vm.skip(true);
        // Asserts: reverts ZeroAmount when amount is 0.
    }

    function test_pullFrom_revertsZeroAddress() public {
        vm.skip(true);
        // Asserts: reverts ZeroAddress when payer is address(0).
    }

    function test_pullFrom_revertsUnauthorizedWhenCallerIsNotCore() public {
        vm.skip(true);
        // Asserts: access control: reverts Unauthorized for any caller except ChannelCore.
    }

    // ---------------------------------------------------------------- lock

    function test_lock_happyPath() public {
        vm.skip(true);
        // Asserts: moves amount from the channel escrow into claim backing and emits Locked.
    }

    function test_lock_revertsZeroAmount() public {
        vm.skip(true);
        // Asserts: reverts ZeroAmount when amount is 0.
    }

    function test_lock_revertsInsufficientBalance() public {
        vm.skip(true);
        // Asserts: reverts InsufficientBalance when the channel escrow is smaller than amount.
    }

    function test_lock_revertsUnauthorizedWhenCallerIsNotCore() public {
        vm.skip(true);
        // Asserts: access control: reverts Unauthorized for any caller except ChannelCore.
    }

    // ---------------------------------------------------------------- release

    function test_release_happyPath() public {
        vm.skip(true);
        // Asserts: transfers amount to the merchant and emits Released.
    }

    function test_release_revertsZeroAmount() public {
        vm.skip(true);
        // Asserts: reverts ZeroAmount when amount is 0.
    }

    function test_release_revertsZeroAddress() public {
        vm.skip(true);
        // Asserts: reverts ZeroAddress when to is address(0).
    }

    function test_release_revertsUnauthorizedWhenCallerIsNotClaimTokenOrDisputeManager() public {
        vm.skip(true);
        // Asserts: access control: reverts Unauthorized for any caller except ClaimToken or DisputeManager.
    }

    // ---------------------------------------------------------------- refund

    function test_refund_happyPath() public {
        vm.skip(true);
        // Asserts: transfers amount back to the payer and emits Refunded.
    }

    function test_refund_revertsZeroAmount() public {
        vm.skip(true);
        // Asserts: reverts ZeroAmount when amount is 0.
    }

    function test_refund_revertsZeroAddress() public {
        vm.skip(true);
        // Asserts: reverts ZeroAddress when payer is address(0).
    }

    function test_refund_revertsUnauthorizedWhenCallerIsNotCoreOrDisputeManager() public {
        vm.skip(true);
        // Asserts: access control: reverts Unauthorized for any caller except ChannelCore or DisputeManager.
    }
}
