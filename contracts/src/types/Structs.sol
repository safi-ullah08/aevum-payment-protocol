// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Mode, Status} from "./Enums.sol";

/// @notice A payment channel between a payer and a payee under one plan.
/// @dev Parties are bytes32 so that non-EVM identities (for example hashed post-quantum keys) fit.
///      The id commits to originChainId so channels opened on different chains never collide.
struct PaymentChannel {
    bytes32 id;
    bytes32 payer;
    bytes32 payee;
    uint64 originChainId;
    Mode mode;
    bytes32 planId;
    /// @dev Escrow mode: tUSD8 deposited and not yet charged. Unused in Allowance mode.
    uint256 deposit;
    /// @dev Total amount charged so far, across periods and vouchers.
    uint256 claimed;
    uint64 start;
    uint64 expiry;
    /// @dev Nonce of the latest settled voucher.
    uint64 voucherNonce;
    Status status;
}

/// @notice Terms a merchant publishes. Immutable once created; only deactivation is possible.
struct Plan {
    bytes32 id;
    bytes32 merchant;
    /// @dev In tUSD8 base units (6 decimals).
    uint256 amountPerPeriod;
    /// @dev Period length in seconds.
    uint64 period;
    /// @dev Maximum number of missed periods that one charge may collect.
    uint8 maxCatchUpPeriods;
    /// @dev Seconds a claim stays disputable before it can be released to the merchant.
    uint64 disputeWindow;
    bool escrowAllowed;
    bool allowanceAllowed;
}

/// @notice Off-chain payment voucher, signed by the payer (or its agent) as EIP-712 typed data.
/// @dev cumulativeAmount is the running total owed on the channel, so only the latest voucher matters.
///      chainId and vault bind the voucher to one deployment, preventing cross-chain and cross-vault replay.
struct Voucher {
    bytes32 channelId;
    uint256 cumulativeAmount;
    uint64 nonce;
    uint64 chainId;
    address vault;
}

/// @notice EIP-2612 permit signature passed to ChannelCore.open.
/// @dev The UML shows open(planId, mode, expiry, permit) without a type for `permit`.
///      This shape is an assumption. See README "Open questions".
struct Permit {
    uint256 value;
    uint256 deadline;
    uint8 v;
    bytes32 r;
    bytes32 s;
}
