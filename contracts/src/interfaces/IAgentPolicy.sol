// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {FlagType} from "../types/Enums.sol";

/// @title IAgentPolicy
/// @notice Spending limits a principal sets for an autonomous agent that signs vouchers on its behalf.
///         ChannelCore pre-checks every agent payment against this policy.
interface IAgentPolicy {
    // ---------------------------------------------------------------- events
    event PolicySet(
        address indexed principal, address indexed agent, uint256 perTxCap, uint256 dailyCap, uint64 expiry
    );
    event PayeeAllowed(address indexed agent, bytes32 indexed payee);
    event PolicyRevoked(address indexed agent);

    // ---------------------------------------------------------------- errors
    error ZeroAddress();
    error InvalidCaps(uint256 perTxCap, uint256 dailyCap);
    error InvalidExpiry(uint64 expiry);
    error NoPolicy(address agent);
    error NotPrincipal(address agent, address caller);

    // ---------------------------------------------------------------- functions
    /// @notice Creates or replaces an agent's policy. The caller becomes the agent's principal.
    /// @dev Intended: agent != 0; 0 < perTxCap <= dailyCap; expiry > now; caller must be the existing principal
    ///      if one is set. Emit PolicySet.
    /// @param agent Agent address.
    /// @param perTxCap Max tUSD8 per payment.
    /// @param dailyCap Max tUSD8 per rolling day.
    /// @param expiry Time after which the policy no longer authorises payments.
    function setPolicy(address agent, uint256 perTxCap, uint256 dailyCap, uint64 expiry) external;

    /// @notice Adds a payee to the agent's allowlist.
    /// @dev Intended: principal only; policy must exist. Emit PayeeAllowed.
    /// @param agent Agent address.
    /// @param payee Allowed payee.
    function allowPayee(address agent, bytes32 payee) external;

    /// @notice Revokes an agent's policy immediately.
    /// @dev Intended: principal only; policy must exist. Emit PolicyRevoked.
    /// @param agent Agent address.
    function revoke(address agent) external;

    /// @notice Checks whether a payment would be within policy.
    /// @dev Intended: return the first violation found, or FlagType.None if the payment is allowed.
    /// @param agent Agent address.
    /// @param payee Payment recipient.
    /// @param amount tUSD8 base units.
    /// @return flag FlagType.None if allowed, otherwise the violation.
    function check(address agent, bytes32 payee, uint256 amount) external view returns (FlagType flag);
}
