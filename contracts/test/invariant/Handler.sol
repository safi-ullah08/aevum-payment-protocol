// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {AgentPolicy} from "../../src/AgentPolicy.sol";
import {ChannelCore} from "../../src/ChannelCore.sol";
import {ClaimToken} from "../../src/ClaimToken.sol";
import {CustodyAdapter} from "../../src/CustodyAdapter.sol";
import {DisputeManager} from "../../src/DisputeManager.sol";
import {SubscriptionPlans} from "../../src/SubscriptionPlans.sol";
import {NotImplemented} from "../../src/types/Errors.sol";
import {MockTUSD8} from "../mocks/MockTUSD8.sol";
import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

/// @title Handler
/// @notice Stateful fuzzing handler. Each action bounds its inputs, acts as a realistic actor, calls the
///         protocol, and updates ghost variables that the invariants compare against on-chain state.
/// @dev Every action is a stub. Unnamed parameters are the fuzzer-supplied seeds each action will bound.
contract Handler is CommonBase, StdCheats, StdUtils {
    // ---------------------------------------------------------------- system under test
    ChannelCore public immutable core;
    SubscriptionPlans public immutable plans;
    CustodyAdapter public immutable custody;
    ClaimToken public immutable claimToken;
    DisputeManager public immutable disputeManager;
    AgentPolicy public immutable policy;
    MockTUSD8 public immutable tusd8;

    // ---------------------------------------------------------------- actors
    address public immutable payer;
    address public immutable merchant;
    address public immutable agent;
    address public immutable arbiter;

    // ---------------------------------------------------------------- ghost variables
    /// @dev Channels opened by the handler, used to pick targets for later actions.
    bytes32[] public ghost_channelIds;
    /// @dev Claims issued by the handler, used to pick dispute targets.
    bytes32[] public ghost_paymentIds;

    /// @dev Sum of tUSD8 that entered custody (deposits, top-ups, allowance pulls). Invariant 1.
    uint256 public ghost_totalDeposited;
    /// @dev Sum of escrow currently locked behind channels. Invariant 1.
    uint256 public ghost_totalLocked;
    /// @dev Sum of amounts of claims issued and not yet released or burned. Invariants 1 and 2.
    uint256 public ghost_unreleasedClaims;
    /// @dev Sum released to merchants (redeem, autoRelease, resolveRelease).
    uint256 public ghost_totalReleased;
    /// @dev Sum refunded to payers (cancel, finalize, resolveRefund).
    uint256 public ghost_totalRefunded;

    /// @dev channelId => total charged through charge(). Invariant 3.
    mapping(bytes32 => uint256) public ghost_chargedPerChannel;
    /// @dev channelId => period index => times charged. Invariant 4 (must be <= 1).
    mapping(bytes32 => mapping(uint256 => uint256)) public ghost_chargesPerPeriod;
    /// @dev channelId => highest cumulativeAmount settled. Invariant 5.
    mapping(bytes32 => uint256) public ghost_lastCumulative;
    /// @dev Count of vouchers that settled with cumulativeAmount <= ghost_lastCumulative. Must stay 0.
    uint256 public ghost_staleVouchersSettled;
    /// @dev Disputes raised and disputes resolved (refund + release). Invariant 6.
    uint256 public ghost_disputesRaised;
    uint256 public ghost_disputesResolvedRefund;
    uint256 public ghost_disputesResolvedRelease;
    /// @dev Count of plan term changes observed after creation. Invariant 7 (must stay 0).
    uint256 public ghost_planTermChanges;
    /// @dev Count of expiry extensions observed. Invariant 7 (must stay 0).
    uint256 public ghost_expiryExtensions;

    /// @dev Number of calls per action, for debugging the call distribution.
    mapping(bytes32 => uint256) public calls;

    constructor(
        ChannelCore core_,
        SubscriptionPlans plans_,
        CustodyAdapter custody_,
        ClaimToken claimToken_,
        DisputeManager disputeManager_,
        AgentPolicy policy_,
        MockTUSD8 tusd8_,
        address payer_,
        address merchant_,
        address agent_,
        address arbiter_
    ) {
        core = core_;
        plans = plans_;
        custody = custody_;
        claimToken = claimToken_;
        disputeManager = disputeManager_;
        policy = policy_;
        tusd8 = tusd8_;
        payer = payer_;
        merchant = merchant_;
        agent = agent_;
        arbiter = arbiter_;
    }

    // ---------------------------------------------------------------- actions

    /// @notice Payer opens a channel on a merchant plan in a fuzzed mode.
    /// @dev TODO: bound mode/expiry/deposit, sign permit, call core.open, push id, add the deposit to ghosts.
    function open(
        uint256,
        /* modeSeed */
        uint256,
        /* expirySeed */
        uint256 /* depositSeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Payer tops up an escrow channel.
    /// @dev TODO: pick channel, bound amount, call core.topUp, update ghost_totalDeposited/ghost_totalLocked.
    function topUp(
        uint256,
        /* channelSeed */
        uint256 /* amountSeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Anyone charges due periods.
    /// @dev TODO: pick channel, call core.charge, record per-period charge counts and the new claim.
    function charge(
        uint256 /* channelSeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Gateway settles a payer/agent-signed voucher.
    /// @dev TODO: pick channel, build a voucher (sometimes stale on purpose), sign, call core.payWithVoucher,
    ///      and increment ghost_staleVouchersSettled if a stale voucher ever succeeds.
    function payWithVoucher(
        uint256,
        /* channelSeed */
        uint256 /* amountSeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Payer pauses a channel.
    /// @dev TODO: pick channel, call core.pause as payer.
    function pause(
        uint256 /* channelSeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Payer resumes a channel.
    /// @dev TODO: pick channel, call core.resume as payer.
    function resume(
        uint256 /* channelSeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Payer cancels a channel.
    /// @dev TODO: pick channel, call core.cancel, add the refund to ghost_totalRefunded.
    function cancel(
        uint256 /* channelSeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Payer or payee starts a close.
    /// @dev TODO: pick channel and party, sign voucher (sometimes not the latest), call core.startClose.
    function startClose(
        uint256,
        /* channelSeed */
        uint256 /* partySeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Watchtower challenges a close with the latest voucher.
    /// @dev TODO: pick a Closing channel, submit the highest known voucher via core.challengeClose.
    function challengeClose(
        uint256 /* channelSeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Anyone finalizes after the challenge window.
    /// @dev TODO: pick a Closing channel, call core.finalize, update released/refunded ghosts.
    function finalize(
        uint256 /* channelSeed */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Payer raises a dispute on a claim.
    /// @dev TODO: pick paymentId, call disputeManager.raise as payer, ghost_disputesRaised++.
    function raiseDispute(
        uint256,
        /* paymentSeed */
        bytes32 /* reason */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Arbiter resolves an open dispute.
    /// @dev TODO: pick a disputed payment, call resolveRefund or resolveRelease by outcome seed, update ghosts.
    function resolve(
        uint256,
        /* paymentSeed */
        bool /* refund */
    )
        external
    {
        revert NotImplemented();
    }

    /// @notice Advances time so periods accrue and windows elapse.
    /// @dev TODO: bound seconds (e.g. 1 second to 3 periods) and vm.warp.
    function warp(
        uint256 /* secondsSeed */
    )
        external
    {
        revert NotImplemented();
    }
}
