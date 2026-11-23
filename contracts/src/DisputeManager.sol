// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IDisputeManager} from "./interfaces/IDisputeManager.sol";
import {FlagType} from "./types/Enums.sol";
import {NotImplemented} from "./types/Errors.sol";

/// @title DisputeManager
/// @notice Disputes resolve only to payer refund or merchant release. See IDisputeManager.
contract DisputeManager is IDisputeManager {
    /// @dev Refunds or releases funds (UML: "refund or release only").
    address internal immutable CUSTODY;
    /// @dev Claim window state and burnOnRefund.
    address internal immutable CLAIM_TOKEN;
    /// @dev Allowed to call autoFlag.
    address internal immutable CHANNEL_CORE;
    /// @dev Allowed to call resolveRefund and resolveRelease.
    address internal immutable ARBITER;

    constructor(address custody_, address claimToken_, address channelCore_, address arbiter_) {
        CUSTODY = custody_;
        CLAIM_TOKEN = claimToken_;
        CHANNEL_CORE = channelCore_;
        ARBITER = arbiter_;
    }

    /// @inheritdoc IDisputeManager
    function raise(bytes32, bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IDisputeManager
    function autoFlag(bytes32, FlagType) external {
        revert NotImplemented();
    }

    /// @inheritdoc IDisputeManager
    function resolveRefund(bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IDisputeManager
    function resolveRelease(bytes32) external {
        revert NotImplemented();
    }
}
