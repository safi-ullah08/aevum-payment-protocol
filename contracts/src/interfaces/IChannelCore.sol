// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {FlagType, Mode, Status} from "../types/Enums.sol";
import {Permit, Voucher} from "../types/Structs.sol";

/// @title IChannelCore
/// @notice One channel type with two funding modes (Escrow, Allowance). Every payment, whether a periodic
///         `charge` or an off-chain `payWithVoucher`, moves funds through CustodyAdapter and mints a ClaimToken
///         receipt that settles after the plan's dispute window.
interface IChannelCore {
    // ---------------------------------------------------------------- events
    event ChannelOpened(
        bytes32 indexed channelId,
        bytes32 indexed payer,
        bytes32 indexed payee,
        bytes32 planId,
        Mode mode,
        uint256 deposit,
        uint64 expiry
    );
    event ToppedUp(bytes32 indexed channelId, uint256 amount, uint256 newDeposit);
    event Charged(bytes32 indexed channelId, bytes32 indexed paymentId, uint256 amount, uint256 periods);
    event VoucherPaid(bytes32 indexed channelId, bytes32 indexed paymentId, uint256 cumulativeAmount, uint64 nonce);
    event ChannelPaused(bytes32 indexed channelId);
    event ChannelResumed(bytes32 indexed channelId);
    event ChannelPastDue(bytes32 indexed channelId);
    event ExpiryShortened(bytes32 indexed channelId, uint64 oldExpiry, uint64 newExpiry);
    event ChannelCancelled(bytes32 indexed channelId);
    event CloseStarted(bytes32 indexed channelId, uint256 cumulativeAmount, uint64 challengeEndsAt);
    event CloseChallenged(bytes32 indexed channelId, uint256 cumulativeAmount, uint64 nonce);
    event ChannelFinalized(bytes32 indexed channelId, uint256 paidToPayee, uint256 refundedToPayer);

    // ---------------------------------------------------------------- errors
    error ChannelNotFound(bytes32 channelId);
    error InvalidStatus(bytes32 channelId, Status status);
    error NotPayer(bytes32 channelId, address caller);
    error NotChannelParty(bytes32 channelId, address caller);
    error PlanNotActive(bytes32 planId);
    error ModeNotAllowed(bytes32 planId, Mode mode);
    error WrongMode(bytes32 channelId, Mode mode);
    error InvalidExpiry(uint64 expiry);
    error ExpiryNotShorter(uint64 currentExpiry, uint64 requestedExpiry);
    error ChannelExpired(bytes32 channelId);
    error ZeroAmount();
    error PeriodAlreadyCharged(bytes32 channelId);
    error InsufficientDeposit(bytes32 channelId, uint256 required, uint256 available);
    error InvalidVoucher();
    error StaleVoucher(uint256 cumulativeAmount, uint256 claimed);
    error PolicyViolation(FlagType flag);
    error CloseNotStarted(bytes32 channelId);
    error ChallengeWindowOpen(bytes32 channelId, uint64 endsAt);
    error ChallengeWindowClosed(bytes32 channelId);

    // ---------------------------------------------------------------- functions
    /// @notice Opens a channel on a plan.
    /// @dev Intended: read terms from SubscriptionPlans; require the plan active and `mode` allowed; require
    ///      expiry > now. Escrow: use `permit` and pull the deposit into custody. Allowance: use `permit` to
    ///      grant CustodyAdapter an allowance. The id commits to block.chainid (originChainId). Emit ChannelOpened.
    /// @param planId Plan to subscribe to.
    /// @param mode Escrow or Allowance.
    /// @param expiry Unix time after which no further charges accrue.
    /// @param permit EIP-2612 signature for tUSD8.
    /// @return channelId Id of the new channel.
    function open(bytes32 planId, Mode mode, uint64 expiry, Permit calldata permit) external returns (bytes32 channelId);

    /// @notice Adds funds to an Escrow-mode channel.
    /// @dev Intended: payer only; Escrow only; status Active, Paused or PastDue; pull `amount` into custody.
    /// @param channelId Channel to fund.
    /// @param amount tUSD8 base units.
    function topUp(bytes32 channelId, uint256 amount) external;

    /// @notice Charges all periods due on a subscription channel.
    /// @dev Intended: compute periods elapsed since the last charge, capped by plan.maxCatchUpPeriods and by
    ///      expiry (invariants 3 and 4). Each period is charged at most once. Escrow: lock from deposit.
    ///      Allowance: pull from payer; on failure mark PastDue instead of reverting. Issue a ClaimToken with
    ///      releaseAt = now + plan.disputeWindow. Emit Charged.
    /// @param channelId Channel to charge.
    function charge(bytes32 channelId) external;

    /// @notice Settles an off-chain voucher (x402 pay-per-use).
    /// @dev Intended: verify the signature via IVoucherVerifier; check voucher.chainId and voucher.vault;
    ///      require cumulativeAmount > claimed (invariant 5); pre-check AgentPolicy for the delta; move the
    ///      delta through custody and issue a ClaimToken. Emit VoucherPaid.
    /// @param channelId Channel the voucher draws on.
    /// @param voucher The signed voucher.
    /// @param sig Signature over the EIP-712 Voucher.
    function payWithVoucher(bytes32 channelId, Voucher calldata voucher, bytes calldata sig) external;

    /// @notice Pauses charging on a channel.
    /// @dev Intended: payer only; Active -> Paused. Emit ChannelPaused.
    /// @param channelId Channel to pause.
    function pause(bytes32 channelId) external;

    /// @notice Resumes a paused channel.
    /// @dev Intended: payer only; Paused -> Active. Emit ChannelResumed.
    /// @param channelId Channel to resume.
    function resume(bytes32 channelId) external;

    /// @notice Moves expiry earlier. Expiry can never be extended through this function.
    /// @dev Intended: payer only; newExpiry < current expiry and >= now. Emit ExpiryShortened.
    /// @param channelId Channel to modify.
    /// @param newExpiry The new, earlier expiry.
    function shortenExpiry(bytes32 channelId, uint64 newExpiry) external;

    /// @notice Cancels a subscription. No further periods accrue.
    /// @dev Intended: payer only; refund unlocked escrow to the payer; already-issued claims are unaffected.
    ///      Emit ChannelCancelled.
    /// @param channelId Channel to cancel.
    function cancel(bytes32 channelId) external;

    /// @notice Starts a unilateral close using the latest voucher the caller holds.
    /// @dev Intended: payer or payee; status -> Closing; open a challenge window. Emit CloseStarted.
    /// @param channelId Channel to close.
    /// @param voucher Latest voucher known to the caller.
    /// @param sig Voucher signature.
    function startClose(bytes32 channelId, Voucher calldata voucher, bytes calldata sig) external;

    /// @notice Replaces the close voucher with a newer one during the challenge window.
    /// @dev Intended: anyone (for example a Watchtower) may submit a valid voucher with a higher
    ///      cumulativeAmount than the current one. Emit CloseChallenged.
    /// @param channelId Channel being closed.
    /// @param voucher A newer voucher.
    /// @param sig Voucher signature.
    function challengeClose(bytes32 channelId, Voucher calldata voucher, bytes calldata sig) external;

    /// @notice Finalizes a close after the challenge window.
    /// @dev Intended: anyone; settle the final voucher delta as a claim, refund the rest of the escrow to the
    ///      payer, status -> Closed. Emit ChannelFinalized.
    /// @param channelId Channel to finalize.
    function finalize(bytes32 channelId) external;

    /// @notice Amount that `charge` would collect right now.
    /// @dev Intended: pure accrual math, the same as charge but without state changes.
    /// @param channelId Channel to inspect.
    /// @return amount tUSD8 base units currently chargeable.
    function claimable(bytes32 channelId) external view returns (uint256 amount);
}
