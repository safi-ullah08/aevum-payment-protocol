// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title RoundingFuzzTest
/// @notice Fuzz placeholders for rounding with 6-decimal tUSD8 amounts.
/// @dev Fuzz runs: 256 (foundry.toml). Every test is skipped until implemented.
contract RoundingFuzzTest is Base {
    function testFuzz_charge_noDustLossWithSixDecimals(
        uint256,
        /* amountPerPeriod */
        uint64 /* periods */
    )
        public
    {
        vm.skip(true);
        // Asserts: payer debit == sum of claim amounts == merchant credit exactly, in 6-decimal base units.
    }

    function testFuzz_finalize_refundPlusPaidEqualsDeposit(
        uint256,
        /* deposit */
        uint256 /* cumulative */
    )
        public
    {
        vm.skip(true);
        // Asserts: paidToPayee + refundedToPayer == deposit, with no rounding remainder left in custody.
    }

    function testFuzz_payWithVoucher_deltaExactForSubCentAmounts(
        uint256 /* cumulativeAmount */
    )
        public
    {
        vm.skip(true);
        // Asserts: amounts below 0.01 tUSD8 (< 10_000 base units) settle exactly, with no rounding to zero.
    }
}
