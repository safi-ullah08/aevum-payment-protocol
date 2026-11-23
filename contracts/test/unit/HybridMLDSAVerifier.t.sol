// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title HybridMLDSAVerifierTest
/// @notice Unit test placeholders for HybridMLDSAVerifier (see IVoucherVerifier). Every test is skipped until implemented.
contract HybridMLDSAVerifierTest is Base {
    // ---------------------------------------------------------------- verify

    function test_verify_happyPath() public {
        vm.skip(true);
        // Asserts: returns true only when both the ECDSA and the ML-DSA signatures verify for the committed keys.
    }

    function test_verify_returnsFalseWhenEcdsaPartInvalid() public {
        vm.skip(true);
        // Asserts: returns false when only the ML-DSA part is valid.
    }

    function test_verify_returnsFalseWhenMldsaPartInvalid() public {
        vm.skip(true);
        // Asserts: returns false when only the ECDSA part is valid.
    }

    function test_verify_returnsFalseForWrongKeyCommitment() public {
        vm.skip(true);
        // Asserts: returns false when signer does not commit to the supplied public keys.
    }

    function test_verify_revertsMalformedSignature() public {
        vm.skip(true);
        // Asserts: reverts MalformedSignature when sig cannot be decoded into both parts.
    }
}
