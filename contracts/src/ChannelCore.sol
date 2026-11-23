// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IAgentPolicy} from "./interfaces/IAgentPolicy.sol";
import {IChannelCore} from "./interfaces/IChannelCore.sol";
import {IClaimToken} from "./interfaces/IClaimToken.sol";
import {ICustodyAdapter} from "./interfaces/ICustodyAdapter.sol";
import {IMessenger} from "./interfaces/IMessenger.sol";
import {ISubscriptionPlans} from "./interfaces/ISubscriptionPlans.sol";
import {IVoucherVerifier} from "./interfaces/IVoucherVerifier.sol";
import {Mode} from "./types/Enums.sol";
import {NotImplemented} from "./types/Errors.sol";
import {PaymentChannel, Permit, Voucher} from "./types/Structs.sol";

/// @title ChannelCore
/// @notice Channel state machine and payment pipeline. See IChannelCore.
contract ChannelCore is IChannelCore {
    /// @dev Reads plan terms (UML: "reads terms").
    ISubscriptionPlans internal immutable PLANS;
    /// @dev Moves tUSD8 (UML: "moves tUSD8").
    ICustodyAdapter internal immutable CUSTODY;
    /// @dev Issues payment receipts (UML: "issues receipts").
    IClaimToken internal immutable CLAIM_TOKEN;
    /// @dev Voucher signature scheme.
    IVoucherVerifier internal immutable VERIFIER;
    /// @dev Agent spending pre-checks (UML: "pre-checks").
    IAgentPolicy internal immutable POLICY;
    /// @dev Cross-chain transport.
    IMessenger internal immutable MESSENGER;

    /// @dev channelId => channel (UML: "-mapping channels").
    mapping(bytes32 => PaymentChannel) private channels;

    constructor(
        ISubscriptionPlans plans_,
        ICustodyAdapter custody_,
        IClaimToken claimToken_,
        IVoucherVerifier verifier_,
        IAgentPolicy policy_,
        IMessenger messenger_
    ) {
        PLANS = plans_;
        CUSTODY = custody_;
        CLAIM_TOKEN = claimToken_;
        VERIFIER = verifier_;
        POLICY = policy_;
        MESSENGER = messenger_;
    }

    /// @inheritdoc IChannelCore
    function open(bytes32, Mode, uint64, Permit calldata) external returns (bytes32) {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function topUp(bytes32, uint256) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function charge(bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function payWithVoucher(bytes32, Voucher calldata, bytes calldata) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function pause(bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function resume(bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function shortenExpiry(bytes32, uint64) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function cancel(bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function startClose(bytes32, Voucher calldata, bytes calldata) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function challengeClose(bytes32, Voucher calldata, bytes calldata) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function finalize(bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IChannelCore
    function claimable(bytes32) external view returns (uint256) {
        revert NotImplemented();
    }
}
