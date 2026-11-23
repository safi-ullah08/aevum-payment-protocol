// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title DisputeWindowFuzzTest
/// @notice Fuzz placeholders for dispute-window bounds.
/// @dev Fuzz runs: 256 (foundry.toml). Every test is skipped until implemented.
contract DisputeWindowFuzzTest is Base {
    function testFuzz_raise_onlyInsideWindow(
        uint64,
        /* disputeWindow */
        uint64 /* raiseAt */
    )
        public
    {
        vm.skip(true);
        // Asserts: raise succeeds iff issuedAt <= raiseAt < releaseAt; otherwise reverts DisputeWindowClosed.
    }

    function testFuzz_autoRelease_onlyAfterWindow(
        uint64,
        /* disputeWindow */
        uint64 /* releaseAttemptAt */
    )
        public
    {
        vm.skip(true);
        // Asserts: autoRelease succeeds iff now >= releaseAt and the claim is not disputed.
    }

    function testFuzz_createPlan_disputeWindowBounded(
        uint64 /* disputeWindow */
    )
        public
    {
        vm.skip(true);
        // Asserts: createPlan accepts disputeWindow only inside the configured bounds.
    }
}
