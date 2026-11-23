// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {NotImplemented} from "../../src/types/Errors.sol";
import {Base} from "../utils/Base.t.sol";

/// @title Symbolic
/// @notice Halmos symbolic tests. Run with `halmos --contract Symbolic` from /contracts.
/// @dev `forge test` ignores check_ functions. Halmos has no skip cheatcode, so each stub reverts NotImplemented.
///      Halmos does not count a revert as a counterexample, so these stubs prove nothing until implemented.
contract Symbolic is Base {
    /// @notice Conservation of funds: for any sequence of payments, disputes and closes, tUSD8 is neither
    ///         created nor destroyed. payer debits == merchant credits + payer refunds + custody balance delta.
    function check_conservationOfFunds(
        uint256,
        /* deposit */
        uint256,
        /* charged */
        uint256 /* refunded */
    )
        public
    {
        revert NotImplemented();
    }

    /// @notice At most one charge per period: for any two charge timestamps t1 <= t2 inside the same period,
    ///         the second charge collects 0 or reverts PeriodAlreadyCharged.
    function check_atMostOneChargePerPeriod(
        uint64,
        /* t1 */
        uint64 /* t2 */
    )
        public
    {
        revert NotImplemented();
    }

    /// @notice Stale vouchers never settle: for any voucher with cumulativeAmount <= claimed,
    ///         payWithVoucher, startClose and challengeClose never transfer value.
    function check_staleVoucherNeverSettles(
        uint256,
        /* claimed */
        uint256 /* cumulativeAmount */
    )
        public
    {
        revert NotImplemented();
    }
}
