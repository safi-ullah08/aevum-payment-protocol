// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {FlagType} from "../types/Enums.sol";

/// @title IDisputeManager
/// @notice Holds disputes on claims during their window. Invariant 6: every dispute resolves to exactly one of
///         a payer refund or a merchant release.
interface IDisputeManager {
    // ---------------------------------------------------------------- events
    event DisputeRaised(bytes32 indexed paymentId, address indexed raiser, bytes32 reason);
    event AutoFlagged(bytes32 indexed paymentId, FlagType flag);
    event ResolvedRefund(bytes32 indexed paymentId);
    event ResolvedRelease(bytes32 indexed paymentId);

    // ---------------------------------------------------------------- errors
    error Unauthorized(address caller);
    error NotPayer(bytes32 paymentId, address caller);
    error NotArbiter(address caller);
    error InvalidFlag();
    error DisputeWindowClosed(bytes32 paymentId);
    error AlreadyDisputed(bytes32 paymentId);
    error NotDisputed(bytes32 paymentId);

    // ---------------------------------------------------------------- functions
    /// @notice The payer disputes a payment inside its window.
    /// @dev Intended: payer of the underlying channel only; now < releaseAt; not already disputed.
    ///      Freezes the claim. Emit DisputeRaised.
    /// @param paymentId Disputed payment.
    /// @param reason Opaque reason code or hash of off-chain evidence.
    function raise(bytes32 paymentId, bytes32 reason) external;

    /// @notice Automatically flags a payment, for example after an AgentPolicy violation.
    /// @dev Intended: ChannelCore only; flag != None; same window rules as raise. Emit AutoFlagged.
    /// @param paymentId Flagged payment.
    /// @param flag Reason from AgentPolicy.check.
    function autoFlag(bytes32 paymentId, FlagType flag) external;

    /// @notice Resolves a dispute in the payer's favour.
    /// @dev Intended: arbiter only; burn the claim and refund the payer via CustodyAdapter. Emit ResolvedRefund.
    /// @param paymentId Disputed payment.
    function resolveRefund(bytes32 paymentId) external;

    /// @notice Resolves a dispute in the merchant's favour.
    /// @dev Intended: arbiter only; unfreeze and release to the merchant via CustodyAdapter. Emit ResolvedRelease.
    /// @param paymentId Disputed payment.
    function resolveRelease(bytes32 paymentId) external;
}
