// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title AccrualFuzzTest
/// @notice Fuzz placeholders for period accrual math in ChannelCore.charge / claimable.
/// @dev Fuzz runs: 256 (foundry.toml). Every test is skipped until implemented.
contract AccrualFuzzTest is Base {
    function testFuzz_charge_accruesAmountPerPeriodTimesElapsedPeriods(
        uint64,
        /* period */
        uint64 /* elapsed */
    )
        public
    {
        vm.skip(true);
        // Asserts: amount charged == amountPerPeriod * floor(elapsed / period) for any period > 0 (invariant 3).
    }

    function testFuzz_charge_neverAccruesPastExpiry(
        uint64,
        /* expiry */
        uint64 /* warpTo */
    )
        public
    {
        vm.skip(true);
        // Asserts: total charged never includes periods that start at or after expiry.
    }

    function testFuzz_claimable_matchesCharge(
        uint64 /* elapsed */
    )
        public
    {
        vm.skip(true);
        // Asserts: claimable(id) before charge(id) equals the amount charge(id) collects.
    }
}
