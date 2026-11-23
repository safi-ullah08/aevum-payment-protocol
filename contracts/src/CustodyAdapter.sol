// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ICustodyAdapter} from "./interfaces/ICustodyAdapter.sol";
import {NotImplemented} from "./types/Errors.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title CustodyAdapter
/// @notice Sole holder of tUSD8. See ICustodyAdapter.
contract CustodyAdapter is ICustodyAdapter {
    /// @dev tUSD8 (6 decimals, EIP-2612).
    IERC20 internal immutable TOKEN;
    /// @dev May call pullFrom, lock and refund.
    address internal immutable CHANNEL_CORE;
    /// @dev May call release.
    address internal immutable CLAIM_TOKEN;
    /// @dev May call release and refund.
    address internal immutable DISPUTE_MANAGER;

    /// @dev channelId => escrow not yet locked into claims.
    mapping(bytes32 => uint256) private escrowed;

    constructor(IERC20 token_, address channelCore_, address claimToken_, address disputeManager_) {
        TOKEN = token_;
        CHANNEL_CORE = channelCore_;
        CLAIM_TOKEN = claimToken_;
        DISPUTE_MANAGER = disputeManager_;
    }

    /// @inheritdoc ICustodyAdapter
    function pullFrom(address, uint256) external {
        revert NotImplemented();
    }

    /// @inheritdoc ICustodyAdapter
    function lock(bytes32, uint256) external {
        revert NotImplemented();
    }

    /// @inheritdoc ICustodyAdapter
    function release(address, uint256) external {
        revert NotImplemented();
    }

    /// @inheritdoc ICustodyAdapter
    function refund(address, uint256) external {
        revert NotImplemented();
    }
}
