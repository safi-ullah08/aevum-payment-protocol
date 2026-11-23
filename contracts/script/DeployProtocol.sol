// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {AgentPolicy} from "../src/AgentPolicy.sol";
import {ChannelCore} from "../src/ChannelCore.sol";
import {ClaimToken} from "../src/ClaimToken.sol";
import {CustodyAdapter} from "../src/CustodyAdapter.sol";
import {DisputeManager} from "../src/DisputeManager.sol";
import {ECDSAVerifier} from "../src/ECDSAVerifier.sol";
import {HybridMLDSAVerifier} from "../src/HybridMLDSAVerifier.sol";
import {LocalMessenger} from "../src/LocalMessenger.sol";
import {SubscriptionPlans} from "../src/SubscriptionPlans.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Vm} from "forge-std/Vm.sol";

/// @notice Shared deployment and wiring used by both script/Deploy.s.sol and test/utils/Base.t.sol.
/// @dev CustodyAdapter, ClaimToken, DisputeManager, LocalMessenger and ChannelCore reference each other.
///      Their addresses are predicted from the deployer nonce so every reference can be an immutable
///      constructor argument (no setter functions, which the UML does not define).
abstract contract DeployProtocol {
    Vm private constant VM_ = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    struct Deployment {
        SubscriptionPlans plans;
        AgentPolicy policy;
        ECDSAVerifier ecdsaVerifier;
        HybridMLDSAVerifier hybridVerifier;
        LocalMessenger messenger;
        CustodyAdapter custody;
        ClaimToken claimToken;
        DisputeManager disputeManager;
        ChannelCore core;
    }

    error AddressPredictionMismatch(string name, address predicted, address actual);

    /// @param token tUSD8 (or MockTUSD8 in tests).
    /// @param arbiter Address allowed to resolve disputes.
    /// @param deployer Account whose nonce is used for CREATE (the broadcaster, or the test contract).
    function _deployProtocol(IERC20 token, address arbiter, address deployer) internal returns (Deployment memory d) {
        uint256 n = VM_.getNonce(deployer);
        // Deployment order, which fixes each nonce offset:
        // 0 plans, 1 policy, 2 ecdsa, 3 hybrid, 4 messenger, 5 custody, 6 claimToken, 7 disputeManager, 8 core
        address custodyAddr = VM_.computeCreateAddress(deployer, n + 5);
        address claimAddr = VM_.computeCreateAddress(deployer, n + 6);
        address disputeAddr = VM_.computeCreateAddress(deployer, n + 7);
        address coreAddr = VM_.computeCreateAddress(deployer, n + 8);

        d.plans = new SubscriptionPlans();
        d.policy = new AgentPolicy();
        d.ecdsaVerifier = new ECDSAVerifier();
        d.hybridVerifier = new HybridMLDSAVerifier();
        d.messenger = new LocalMessenger(coreAddr);
        d.custody = new CustodyAdapter(token, coreAddr, claimAddr, disputeAddr);
        d.claimToken = new ClaimToken(coreAddr, custodyAddr, disputeAddr);
        d.disputeManager = new DisputeManager(custodyAddr, claimAddr, coreAddr, arbiter);
        // ChannelCore uses ECDSAVerifier by default. HybridMLDSAVerifier is deployed but not wired.
        d.core = new ChannelCore(d.plans, d.custody, d.claimToken, d.ecdsaVerifier, d.policy, d.messenger);

        _checkPrediction("CustodyAdapter", custodyAddr, address(d.custody));
        _checkPrediction("ClaimToken", claimAddr, address(d.claimToken));
        _checkPrediction("DisputeManager", disputeAddr, address(d.disputeManager));
        _checkPrediction("ChannelCore", coreAddr, address(d.core));
    }

    function _checkPrediction(string memory name, address predicted, address actual) private pure {
        if (predicted != actual) revert AddressPredictionMismatch(name, predicted, actual);
    }
}
