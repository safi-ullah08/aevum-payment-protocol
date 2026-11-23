// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IVoucherVerifier} from "./interfaces/IVoucherVerifier.sol";
import {NotImplemented} from "./types/Errors.sol";
import {Voucher} from "./types/Structs.sol";

/// @title HybridMLDSAVerifier
/// @notice Hybrid verifier: a voucher is valid only if BOTH the ECDSA and the ML-DSA (FIPS 204) signatures
///         verify. `signer` commits to both public keys.
/// @dev The UML gives no signature encoding, key commitment format or ML-DSA verification source
///      (precompile or Solidity library). See README "Open questions".
contract HybridMLDSAVerifier is IVoucherVerifier {
    error MalformedSignature();

    /// @inheritdoc IVoucherVerifier
    function verify(Voucher calldata, bytes calldata, bytes32) external view returns (bool) {
        revert NotImplemented();
    }
}
