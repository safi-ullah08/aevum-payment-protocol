// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title CatchUpFuzzTest
/// @notice Fuzz placeholders for catch-up limits (Plan.maxCatchUpPeriods).
/// @dev Fuzz runs: 256 (foundry.toml). Every test is skipped until implemented.
contract CatchUpFuzzTest is Base {
    function testFuzz_charge_catchUpCappedAtMaxCatchUpPeriods(
        uint8,
        /* maxCatchUp */
        uint64 /* missedPeriods */
    )
        public
    {
        vm.skip(true);
        // Asserts: one charge collects at most min(missedPeriods, maxCatchUpPeriods) periods (invariant 4).
    }

    function testFuzz_charge_eachPeriodChargedAtMostOnce(
        uint64[] calldata /* chargeTimes */
    )
        public
    {
        vm.skip(true);
        // Asserts: repeated charges at arbitrary times never charge the same period index twice (invariant 4).
    }
}
