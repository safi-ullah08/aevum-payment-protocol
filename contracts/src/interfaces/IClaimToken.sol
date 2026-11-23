// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/// @title IClaimToken
/// @notice A receipt for a single payment, held by the merchant until its dispute window ends.
///         Claims are minted only by ChannelCore and are always fully backed by custody (invariant 2).
interface IClaimToken {
    // ---------------------------------------------------------------- events
    event ClaimIssued(bytes32 indexed paymentId, bytes32 indexed merchant, uint256 amount, uint64 releaseAt);
    event ClaimRedeemed(bytes32 indexed paymentId, address indexed to, uint256 amount);
    event ClaimAutoReleased(bytes32 indexed paymentId, uint256 amount);
    event ClaimBurned(bytes32 indexed paymentId, uint256 amount);

    // ---------------------------------------------------------------- errors
    error Unauthorized(address caller);
    error ZeroAmount();
    error InvalidReleaseAt(uint64 releaseAt);
    error ClaimAlreadyExists(bytes32 paymentId);
    error ClaimNotFound(bytes32 paymentId);
    error NotClaimHolder(bytes32 paymentId, address caller);
    error WindowNotElapsed(bytes32 paymentId, uint64 releaseAt);
    error ClaimDisputed(bytes32 paymentId);
    error ClaimAlreadySettled(bytes32 paymentId);

    // ---------------------------------------------------------------- functions
    /// @notice Mints a claim for a payment. There is no other mint path.
    /// @dev Intended: ChannelCore only; amount > 0; releaseAt >= now; unique paymentId. Emit ClaimIssued.
    /// @param paymentId Unique payment id.
    /// @param merchant Claim holder.
    /// @param amount tUSD8 base units backed in custody.
    /// @param releaseAt Time after which the claim may be released.
    function issue(bytes32 paymentId, bytes32 merchant, uint256 amount, uint64 releaseAt) external;

    /// @notice The merchant redeems a claim after its window.
    /// @dev Intended: holder only; now >= releaseAt; not disputed; not settled. CustodyAdapter.release.
    ///      Emit ClaimRedeemed.
    /// @param paymentId Claim to redeem.
    function redeem(bytes32 paymentId) external;

    /// @notice Anyone releases a claim to its merchant after the window.
    /// @dev Intended: permissionless keeper path with the same checks as redeem. Emit ClaimAutoReleased.
    /// @param paymentId Claim to release.
    function autoRelease(bytes32 paymentId) external;

    /// @notice Burns a claim when its dispute resolves as a refund.
    /// @dev Intended: DisputeManager only; not settled. Emit ClaimBurned.
    /// @param paymentId Claim to burn.
    function burnOnRefund(bytes32 paymentId) external;
}
