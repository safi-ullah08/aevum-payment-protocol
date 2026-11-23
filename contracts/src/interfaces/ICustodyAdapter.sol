// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/// @title ICustodyAdapter
/// @notice The only contract that holds tUSD8. Invariant 1: its token balance equals locked deposits plus
///         unreleased claims.
/// @dev The UML does not type the `payer`/`to` parameters. Token transfers need EVM addresses, so they are
///      `address` here while channels store parties as bytes32. See README "Open questions".
interface ICustodyAdapter {
    // ---------------------------------------------------------------- events
    event Pulled(address indexed payer, uint256 amount);
    event Locked(bytes32 indexed channelId, uint256 amount);
    event Released(address indexed to, uint256 amount);
    event Refunded(address indexed payer, uint256 amount);

    // ---------------------------------------------------------------- errors
    error Unauthorized(address caller);
    error ZeroAmount();
    error ZeroAddress();
    error InsufficientBalance(bytes32 channelId, uint256 requested, uint256 available);

    // ---------------------------------------------------------------- functions
    /// @notice Pulls tUSD8 from a payer into custody (escrow deposit or an allowance-mode charge).
    /// @dev Intended: ChannelCore only; SafeERC20 transferFrom. Emit Pulled.
    /// @param payer Address to pull from.
    /// @param amount tUSD8 base units.
    function pullFrom(address payer, uint256 amount) external;

    /// @notice Moves `amount` of a channel's escrow into claim backing.
    /// @dev Intended: ChannelCore only; revert if the channel's unlocked escrow is too small. Emit Locked.
    /// @param channelId Escrow channel.
    /// @param amount tUSD8 base units.
    function lock(bytes32 channelId, uint256 amount) external;

    /// @notice Pays out tUSD8 to a merchant when a claim settles.
    /// @dev Intended: ClaimToken or DisputeManager only. Emit Released.
    /// @param to Recipient.
    /// @param amount tUSD8 base units.
    function release(address to, uint256 amount) external;

    /// @notice Returns tUSD8 to a payer (dispute refund, cancel or finalize remainder).
    /// @dev Intended: DisputeManager or ChannelCore only. Emit Refunded.
    /// @param payer Recipient.
    /// @param amount tUSD8 base units.
    function refund(address payer, uint256 amount) external;
}
