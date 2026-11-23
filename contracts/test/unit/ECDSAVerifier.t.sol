// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Base} from "../utils/Base.t.sol";

/// @title ECDSAVerifierTest
/// @notice Unit test placeholders for ECDSAVerifier (see IVoucherVerifier). Every test is skipped until implemented.
contract ECDSAVerifierTest is Base {
    // ---------------------------------------------------------------- verify

    function test_verify_happyPath() public {
        vm.skip(true);
        // Asserts: returns true for a voucher signed by the signer over the shared EIP-712 domain.
    }

    function test_verify_returnsFalseForWrongSigner() public {
        vm.skip(true);
        // Asserts: returns false when the recovered address != signer.
    }

    function test_verify_returnsFalseForTamperedVoucher() public {
        vm.skip(true);
        // Asserts: returns false when any voucher field differs from what was signed.
    }

    function test_verify_revertsInvalidSignatureLength() public {
        vm.skip(true);
        // Asserts: reverts InvalidSignatureLength for a signature that is not 65 bytes.
    }

    function test_verify_revertsInvalidSignatureS() public {
        vm.skip(true);
        // Asserts: reverts InvalidSignatureS for a high-s (malleable) signature.
    }
}
