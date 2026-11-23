// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/// @notice How a channel is funded.
/// @dev Escrow: the payer deposits up front and charges are locked from that deposit.
///      Allowance: the payer grants a token allowance and each charge is pulled on demand.
enum Mode {
    Escrow,
    Allowance
}

/// @notice Lifecycle state of a PaymentChannel.
/// @dev Active    -> charges and vouchers accepted.
///      Paused    -> payer paused; no charges until resumed.
///      PastDue   -> an Allowance-mode pull failed; charges are owed.
///      Closing   -> startClose was called; the challenge window is open.
///      Closed    -> finalized or cancelled; terminal.
enum Status {
    Active,
    Paused,
    PastDue,
    Closing,
    Closed
}

/// @notice Result of AgentPolicy.check and the reason passed to DisputeManager.autoFlag.
/// @dev The UML references FlagType without listing its values. These values are inferred from
///      AgentPolicy.setPolicy/allowPayee. See README "Open questions".
enum FlagType {
    None,
    NoPolicy,
    PolicyExpired,
    PerTxCapExceeded,
    DailyCapExceeded,
    PayeeNotAllowed
}
