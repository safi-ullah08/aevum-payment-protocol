// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAgentPolicy} from "./interfaces/IAgentPolicy.sol";
import {FlagType} from "./types/Enums.sol";
import {NotImplemented} from "./types/Errors.sol";

/// @title AgentPolicy
/// @notice Per-agent spending caps and payee allowlists. See IAgentPolicy.
contract AgentPolicy is IAgentPolicy {
    /// @inheritdoc IAgentPolicy
    function setPolicy(address, uint256, uint256, uint64) external {
        revert NotImplemented();
    }

    /// @inheritdoc IAgentPolicy
    function allowPayee(address, bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IAgentPolicy
    function revoke(address) external {
        revert NotImplemented();
    }

    /// @inheritdoc IAgentPolicy
    function check(address, bytes32, uint256) external view returns (FlagType) {
        revert NotImplemented();
    }
}
