// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title VoucherMonotonicityFuzzTest
/// @notice Fuzz placeholders for voucher monotonicity (invariant 5).
/// @dev Fuzz runs: 256 (foundry.toml). Every test is skipped until implemented.
contract VoucherMonotonicityFuzzTest is Base {
    function testFuzz_payWithVoucher_cumulativeStrictlyIncreasing(
        uint256,
        /* first */
        uint256 /* second */
    )
        public
    {
        vm.skip(true);
        // Asserts: a second voucher settles only if second > first, otherwise reverts StaleVoucher.
    }

    function testFuzz_payWithVoucher_staleVoucherNeverSettles(
        uint256 /* staleCumulative */
    )
        public
    {
        vm.skip(true);
        // Asserts: any voucher with cumulativeAmount <= claimed reverts and leaves balances unchanged.
    }

    function testFuzz_challengeClose_onlyHigherVoucherReplaces(
        uint256,
        /* closeCumulative */
        uint256 /* challenge */
    )
        public
    {
        vm.skip(true);
        // Asserts: challengeClose accepts only a strictly higher cumulativeAmount than the recorded close voucher.
    }
}
