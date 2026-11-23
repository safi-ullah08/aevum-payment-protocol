// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title AgentPolicyTest
/// @notice Unit test placeholders for AgentPolicy (see IAgentPolicy). Every test is skipped until implemented.
contract AgentPolicyTest is Base {
    // ---------------------------------------------------------------- setPolicy

    function test_setPolicy_happyPath() public {
        vm.skip(true);
        // Asserts: stores caps and expiry with the caller as principal and emits PolicySet.
    }

    function test_setPolicy_happyPathReplacesExisting() public {
        vm.skip(true);
        // Asserts: the existing principal can overwrite caps and expiry.
    }

    function test_setPolicy_revertsZeroAddress() public {
        vm.skip(true);
        // Asserts: reverts ZeroAddress when agent is address(0).
    }

    function test_setPolicy_revertsInvalidCaps() public {
        vm.skip(true);
        // Asserts: reverts InvalidCaps when perTxCap is 0 or perTxCap > dailyCap.
    }

    function test_setPolicy_revertsInvalidExpiry() public {
        vm.skip(true);
        // Asserts: reverts InvalidExpiry when expiry <= block.timestamp.
    }

    function test_setPolicy_revertsNotPrincipalWhenAgentOwnedByOther() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPrincipal when another principal already owns the agent.
    }

    // ---------------------------------------------------------------- allowPayee

    function test_allowPayee_happyPath() public {
        vm.skip(true);
        // Asserts: adds payee to the allowlist and emits PayeeAllowed.
    }

    function test_allowPayee_revertsNoPolicy() public {
        vm.skip(true);
        // Asserts: reverts NoPolicy when the agent has no policy.
    }

    function test_allowPayee_revertsNotPrincipalWhenCallerIsNotPrincipal() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPrincipal when a non-principal calls.
    }

    // ---------------------------------------------------------------- revoke

    function test_revoke_happyPath() public {
        vm.skip(true);
        // Asserts: deletes the policy so check returns NoPolicy, and emits PolicyRevoked.
    }

    function test_revoke_revertsNoPolicy() public {
        vm.skip(true);
        // Asserts: reverts NoPolicy when the agent has no policy.
    }

    function test_revoke_revertsNotPrincipalWhenCallerIsNotPrincipal() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPrincipal when a non-principal calls.
    }

    // ---------------------------------------------------------------- check

    function test_check_happyPath() public {
        vm.skip(true);
        // Asserts: returns FlagType.None for an allowed payee within both caps before expiry.
    }

    function test_check_returnsNoPolicy() public {
        vm.skip(true);
        // Asserts: returns NoPolicy for an unknown or revoked agent.
    }

    function test_check_returnsPolicyExpired() public {
        vm.skip(true);
        // Asserts: returns PolicyExpired after expiry.
    }

    function test_check_returnsPerTxCapExceeded() public {
        vm.skip(true);
        // Asserts: returns PerTxCapExceeded when amount > perTxCap.
    }

    function test_check_returnsDailyCapExceeded() public {
        vm.skip(true);
        // Asserts: returns DailyCapExceeded when spentToday + amount > dailyCap.
    }

    function test_check_returnsPayeeNotAllowed() public {
        vm.skip(true);
        // Asserts: returns PayeeNotAllowed for a payee not on the allowlist.
    }
}
