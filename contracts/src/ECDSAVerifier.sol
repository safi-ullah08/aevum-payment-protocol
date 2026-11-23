// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IVoucherVerifier} from "./interfaces/IVoucherVerifier.sol";
import {NotImplemented} from "./types/Errors.sol";
import {Voucher} from "./types/Structs.sol";

/// @title ECDSAVerifier
/// @notice secp256k1 verifier for EIP-712 vouchers. `signer` is the signer address left-padded to bytes32.
/// @dev Intended: hash with the EIP-712 domain shared with /shared/src/eip712.ts, recover with OpenZeppelin
///      ECDSA (which rejects high-s and malformed signatures), and compare to address(uint160(uint256(signer))).
contract ECDSAVerifier is IVoucherVerifier {
    error InvalidSignatureLength(uint256 length);
    error InvalidSignatureS();

    /// @inheritdoc IVoucherVerifier
    function verify(Voucher calldata, bytes calldata, bytes32) external view returns (bool) {
        revert NotImplemented();
    }
}
