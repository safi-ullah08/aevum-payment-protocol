// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ISubscriptionPlans} from "./interfaces/ISubscriptionPlans.sol";
import {NotImplemented} from "./types/Errors.sol";
import {Plan} from "./types/Structs.sol";

/// @title SubscriptionPlans
/// @notice Registry of immutable merchant plans. See ISubscriptionPlans.
contract SubscriptionPlans is ISubscriptionPlans {
    /// @dev planId => plan. Aggregates Plan (UML: SubscriptionPlans o-- Plan).
    mapping(bytes32 => Plan) private plans;

    /// @inheritdoc ISubscriptionPlans
    function createPlan(Plan calldata) external returns (bytes32) {
        revert NotImplemented();
    }

    /// @inheritdoc ISubscriptionPlans
    function deactivatePlan(bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc ISubscriptionPlans
    function getPlan(bytes32) external view returns (Plan memory) {
        revert NotImplemented();
    }
}
