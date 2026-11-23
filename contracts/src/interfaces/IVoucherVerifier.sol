// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Voucher} from "../types/Structs.sol";

/// @title IVoucherVerifier
/// @notice Pluggable signature check for vouchers, so the protocol can move from ECDSA to hybrid
///         post-quantum signatures without changing ChannelCore.
interface IVoucherVerifier {
    /// @notice Returns true if `sig` is a valid signature by `signer` over the EIP-712 hash of `voucher`.
    /// @param voucher The voucher.
    /// @param sig Scheme-specific signature bytes.
    /// @param signer Signer identity as bytes32 (an ECDSA address left-padded, or a key commitment).
    /// @return valid Whether the signature is valid.
    function verify(Voucher calldata voucher, bytes calldata sig, bytes32 signer) external view returns (bool valid);
}
