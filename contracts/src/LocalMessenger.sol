// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IMessenger} from "./interfaces/IMessenger.sol";
import {NotImplemented} from "./types/Errors.sol";

/// @title LocalMessenger
/// @notice Single-chain IMessenger for the hackathon and tests: messages loop back on the same chain.
contract LocalMessenger is IMessenger {
    /// @dev Only sender and delivery target.
    address internal immutable CHANNEL_CORE;

    /// @dev Next outbound nonce.
    uint64 private outboundNonce;
    /// @dev srcChain => nonce => delivered.
    mapping(uint64 => mapping(uint64 => bool)) private delivered;

    constructor(address channelCore_) {
        CHANNEL_CORE = channelCore_;
    }

    /// @inheritdoc IMessenger
    function send(uint64, bytes calldata) external {
        revert NotImplemented();
    }

    /// @inheritdoc IMessenger
    function receive(uint64, uint64, bytes calldata) external {
        revert NotImplemented();
    }
}
