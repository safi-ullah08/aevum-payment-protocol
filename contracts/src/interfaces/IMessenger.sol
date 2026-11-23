// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/// @title IMessenger
/// @notice Cross-chain transport abstraction used by ChannelCore. LocalMessenger is the single-chain stand-in.
/// @dev `receive` is the name in the UML. It shadows Solidity's special receive function name and produces a
///      compiler warning. See README "Open questions".
interface IMessenger {
    // ---------------------------------------------------------------- events
    event MessageSent(uint64 indexed dstChain, uint64 indexed nonce, bytes payload);
    event MessageReceived(uint64 indexed srcChain, uint64 indexed nonce, bytes payload);

    // ---------------------------------------------------------------- errors
    error Unauthorized(address caller);
    error UnsupportedChain(uint64 chainId);
    error ReplayedMessage(uint64 srcChain, uint64 nonce);

    // ---------------------------------------------------------------- functions
    /// @notice Sends a payload to another chain.
    /// @dev Intended: ChannelCore only; assign the next outbound nonce. Emit MessageSent.
    /// @param dstChain Destination chain id.
    /// @param payload Encoded message.
    function send(uint64 dstChain, bytes calldata payload) external;

    /// @notice Delivers an inbound payload.
    /// @dev Intended: authorised relayer only; reject replayed (srcChain, nonce) pairs; forward to ChannelCore.
    ///      Emit MessageReceived.
    /// @param srcChain Source chain id.
    /// @param nonce Source-side nonce.
    /// @param payload Encoded message.
    function receive(uint64 srcChain, uint64 nonce, bytes calldata payload) external;
}
