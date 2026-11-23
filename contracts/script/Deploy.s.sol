// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {DeployProtocol} from "./DeployProtocol.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Script, console2} from "forge-std/Script.sol";

/// @title Deploy
/// @notice Deploys and wires the protocol on QDay Aevum testnet (chainId 44005).
/// @dev Reads from env: TUSD8_ADDRESS, ARBITER_ADDRESS. The signer comes from the CLI
///      (--account / --private-key / --ledger), never from a file in the repo.
///      forge script script/Deploy.s.sol --rpc-url aevum --broadcast --account <keystore>
contract Deploy is Script, DeployProtocol {
    uint256 internal constant AEVUM_TESTNET_CHAIN_ID = 44005;
    /// @dev QDay Origin testnet. Never deploy there.
    uint256 internal constant QDAY_ORIGIN_TESTNET_CHAIN_ID = 44003;

    error WrongChain(uint256 chainId);

    function run() external returns (Deployment memory d) {
        if (block.chainid != AEVUM_TESTNET_CHAIN_ID) revert WrongChain(block.chainid);

        IERC20 token = IERC20(vm.envAddress("TUSD8_ADDRESS"));
        address arbiter = vm.envAddress("ARBITER_ADDRESS");

        vm.startBroadcast();
        (, address deployer,) = vm.readCallers();
        d = _deployProtocol(token, arbiter, deployer);
        vm.stopBroadcast();

        console2.log("SUBSCRIPTION_PLANS_ADDRESS=", address(d.plans));
        console2.log("AGENT_POLICY_ADDRESS=", address(d.policy));
        console2.log("ECDSA_VERIFIER_ADDRESS=", address(d.ecdsaVerifier));
        console2.log("HYBRID_MLDSA_VERIFIER_ADDRESS=", address(d.hybridVerifier));
        console2.log("LOCAL_MESSENGER_ADDRESS=", address(d.messenger));
        console2.log("CUSTODY_ADAPTER_ADDRESS=", address(d.custody));
        console2.log("CLAIM_TOKEN_ADDRESS=", address(d.claimToken));
        console2.log("DISPUTE_MANAGER_ADDRESS=", address(d.disputeManager));
        console2.log("CHANNEL_CORE_ADDRESS=", address(d.core));
    }
}
