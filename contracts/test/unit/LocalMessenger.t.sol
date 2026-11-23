// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title LocalMessengerTest
/// @notice Unit test placeholders for LocalMessenger (see IMessenger). Every test is skipped until implemented.
contract LocalMessengerTest is Base {
    // ---------------------------------------------------------------- send

    function test_send_happyPath() public {
        vm.skip(true);
        // Asserts: assigns the next nonce and emits MessageSent with the payload.
    }

    function test_send_revertsUnsupportedChain() public {
        vm.skip(true);
        // Asserts: reverts UnsupportedChain for a dstChain the local messenger cannot reach.
    }

    function test_send_revertsUnauthorizedWhenCallerIsNotCore() public {
        vm.skip(true);
        // Asserts: access control: reverts Unauthorized for any caller except ChannelCore.
    }

    // ---------------------------------------------------------------- receive

    function test_receive_happyPath() public {
        vm.skip(true);
        // Asserts: marks (srcChain, nonce) delivered, forwards to ChannelCore and emits MessageReceived.
    }

    function test_receive_revertsReplayedMessage() public {
        vm.skip(true);
        // Asserts: reverts ReplayedMessage when (srcChain, nonce) was already delivered.
    }

    function test_receive_revertsUnsupportedChain() public {
        vm.skip(true);
        // Asserts: reverts UnsupportedChain for an unknown srcChain.
    }

    function test_receive_revertsUnauthorizedWhenCallerIsNotRelayer() public {
        vm.skip(true);
        // Asserts: access control: reverts Unauthorized for any caller except the authorised relayer.
    }
}
