// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Plan} from "../types/Structs.sol";

/// @title ISubscriptionPlans
/// @notice Registry of merchant plans. Plan terms are immutable: a merchant cannot change price or period
///         after creation (invariant 7); it can only deactivate the plan for new channels.
interface ISubscriptionPlans {
    // ---------------------------------------------------------------- events
    event PlanCreated(bytes32 indexed planId, bytes32 indexed merchant, uint256 amountPerPeriod, uint64 period);
    event PlanDeactivated(bytes32 indexed planId);

    // ---------------------------------------------------------------- errors
    error InvalidAmount();
    error InvalidPeriod();
    error InvalidDisputeWindow();
    error NoModeAllowed();
    /// @dev plan.merchant must equal the caller (as bytes32).
    error InvalidMerchant(bytes32 merchant, address caller);
    error PlanAlreadyExists(bytes32 planId);
    error PlanNotFound(bytes32 planId);
    error PlanInactive(bytes32 planId);
    error NotPlanMerchant(bytes32 planId, address caller);

    // ---------------------------------------------------------------- functions
    /// @notice Registers a new plan.
    /// @dev Intended: validate amountPerPeriod > 0, period > 0, a bounded disputeWindow, at least one mode
    ///      allowed, and merchant == caller. Derive the id deterministically (ignore plan.id from input),
    ///      store the plan as active, emit PlanCreated.
    /// @param plan Plan terms. `plan.id` is ignored and assigned by the registry.
    /// @return planId The id of the new plan.
    function createPlan(Plan calldata plan) external returns (bytes32 planId);

    /// @notice Stops new channels from opening on a plan. Existing channels keep their terms.
    /// @dev Intended: only the plan's merchant; revert if missing or already inactive; emit PlanDeactivated.
    /// @param planId The plan to deactivate.
    function deactivatePlan(bytes32 planId) external;

    /// @notice Returns a plan's terms.
    /// @dev Intended: revert PlanNotFound for unknown ids.
    /// @param planId The plan to read.
    /// @return The stored plan.
    function getPlan(bytes32 planId) external view returns (Plan memory);
}
