// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {DeployProtocol} from "../../script/DeployProtocol.sol";
import {AgentPolicy} from "../../src/AgentPolicy.sol";
import {ChannelCore} from "../../src/ChannelCore.sol";
import {ClaimToken} from "../../src/ClaimToken.sol";
import {CustodyAdapter} from "../../src/CustodyAdapter.sol";
import {DisputeManager} from "../../src/DisputeManager.sol";
import {ECDSAVerifier} from "../../src/ECDSAVerifier.sol";
import {HybridMLDSAVerifier} from "../../src/HybridMLDSAVerifier.sol";
import {LocalMessenger} from "../../src/LocalMessenger.sol";
import {SubscriptionPlans} from "../../src/SubscriptionPlans.sol";
import {MockTUSD8} from "../mocks/MockTUSD8.sol";
import {Test} from "forge-std/Test.sol";

/// @title Base
/// @notice Deploys every contract, wires them together and creates the test actors.
abstract contract Base is Test, DeployProtocol {
    uint256 internal constant AEVUM_TESTNET_CHAIN_ID = 44005;
    /// @dev 1 tUSD8 in base units (6 decimals).
    uint256 internal constant ONE_TUSD8 = 1e6;
    uint256 internal constant INITIAL_PAYER_BALANCE = 10_000 * ONE_TUSD8;

    // ---------------------------------------------------------------- actors
    address internal payer;
    uint256 internal payerKey;
    address internal merchant;
    address internal agent;
    uint256 internal agentKey;
    address internal arbiter;

    // ---------------------------------------------------------------- contracts
    MockTUSD8 internal tusd8;
    SubscriptionPlans internal plans;
    AgentPolicy internal policy;
    ECDSAVerifier internal ecdsaVerifier;
    HybridMLDSAVerifier internal hybridVerifier;
    LocalMessenger internal messenger;
    CustodyAdapter internal custody;
    ClaimToken internal claimToken;
    DisputeManager internal disputeManager;
    ChannelCore internal core;

    function setUp() public virtual {
        vm.chainId(AEVUM_TESTNET_CHAIN_ID);

        // Payer and agent need keys to sign permits and vouchers.
        (payer, payerKey) = makeAddrAndKey("payer");
        (agent, agentKey) = makeAddrAndKey("agent");
        merchant = makeAddr("merchant");
        arbiter = makeAddr("arbiter");

        tusd8 = new MockTUSD8();
        vm.label(address(tusd8), "tUSD8");

        Deployment memory d = _deployProtocol(tusd8, arbiter, address(this));
        plans = d.plans;
        policy = d.policy;
        ecdsaVerifier = d.ecdsaVerifier;
        hybridVerifier = d.hybridVerifier;
        messenger = d.messenger;
        custody = d.custody;
        claimToken = d.claimToken;
        disputeManager = d.disputeManager;
        core = d.core;

        vm.label(address(plans), "SubscriptionPlans");
        vm.label(address(policy), "AgentPolicy");
        vm.label(address(ecdsaVerifier), "ECDSAVerifier");
        vm.label(address(hybridVerifier), "HybridMLDSAVerifier");
        vm.label(address(messenger), "LocalMessenger");
        vm.label(address(custody), "CustodyAdapter");
        vm.label(address(claimToken), "ClaimToken");
        vm.label(address(disputeManager), "DisputeManager");
        vm.label(address(core), "ChannelCore");

        tusd8.mint(payer, INITIAL_PAYER_BALANCE);
    }

    /// @dev Parties are stored as bytes32.
    function _toBytes32(address a) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(a)));
    }
}
