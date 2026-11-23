// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title SubscriptionPlansTest
/// @notice Unit test placeholders for SubscriptionPlans (see ISubscriptionPlans). Every test is skipped until implemented.
contract SubscriptionPlansTest is Base {
    // ---------------------------------------------------------------- createPlan

    function test_createPlan_happyPath() public {
        vm.skip(true);
        // Asserts: stores the plan as active, returns a deterministic id and emits PlanCreated.
    }

    function test_createPlan_revertsInvalidAmount() public {
        vm.skip(true);
        // Asserts: reverts InvalidAmount when amountPerPeriod is 0.
    }

    function test_createPlan_revertsInvalidPeriod() public {
        vm.skip(true);
        // Asserts: reverts InvalidPeriod when period is 0.
    }

    function test_createPlan_revertsInvalidDisputeWindow() public {
        vm.skip(true);
        // Asserts: reverts InvalidDisputeWindow when disputeWindow is outside the allowed bounds.
    }

    function test_createPlan_revertsNoModeAllowed() public {
        vm.skip(true);
        // Asserts: reverts NoModeAllowed when both escrowAllowed and allowanceAllowed are false.
    }

    function test_createPlan_revertsPlanAlreadyExists() public {
        vm.skip(true);
        // Asserts: reverts PlanAlreadyExists when the derived id is already registered.
    }

    function test_createPlan_revertsInvalidMerchantWhenCallerIsNotMerchant() public {
        vm.skip(true);
        // Asserts: access control: reverts InvalidMerchant when plan.merchant != caller.
    }

    // ---------------------------------------------------------------- deactivatePlan

    function test_deactivatePlan_happyPath() public {
        vm.skip(true);
        // Asserts: marks the plan inactive, keeps its terms readable and emits PlanDeactivated.
    }

    function test_deactivatePlan_revertsPlanNotFound() public {
        vm.skip(true);
        // Asserts: reverts PlanNotFound for an unknown id.
    }

    function test_deactivatePlan_revertsPlanInactive() public {
        vm.skip(true);
        // Asserts: reverts PlanInactive when the plan is already deactivated.
    }

    function test_deactivatePlan_revertsNotPlanMerchantWhenCallerIsNotMerchant() public {
        vm.skip(true);
        // Asserts: access control: reverts NotPlanMerchant when a non-merchant calls.
    }

    // ---------------------------------------------------------------- getPlan

    function test_getPlan_happyPath() public {
        vm.skip(true);
        // Asserts: returns exactly the terms passed to createPlan, with the assigned id.
    }

    function test_getPlan_revertsPlanNotFound() public {
        vm.skip(true);
        // Asserts: reverts PlanNotFound for an unknown id.
    }
}
