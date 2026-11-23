// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IClaimToken} from "./interfaces/IClaimToken.sol";
import {NotImplemented} from "./types/Errors.sol";

/// @title ClaimToken
/// @notice Payment receipts with no external mint. See IClaimToken.
/// @dev The UML does not say whether this is ERC-721, ERC-1155 or a plain registry. It is a plain contract
///      until that is decided. See README "Open questions".
contract ClaimToken is IClaimToken {
    /// @dev Only minter (UML: ChannelCore --> ClaimToken "issues receipts").
    address internal immutable CHANNEL_CORE;
    /// @dev Pays out on redeem/autoRelease.
    address internal immutable CUSTODY;
    /// @dev Window state and burnOnRefund caller (UML: ClaimToken --> DisputeManager "window state").
    address internal immutable DISPUTE_MANAGER;

    constructor(address channelCore_, address custody_, address disputeManager_) {
        CHANNEL_CORE = channelCore_;
        CUSTODY = custody_;
        DISPUTE_MANAGER = disputeManager_;
    }

    /// @inheritdoc IClaimToken
    function issue(bytes32, bytes32, uint256, uint64) external {
        revert NotImplemented();
    }

    /// @inheritdoc IClaimToken
    function redeem(bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IClaimToken
    function autoRelease(bytes32) external {
        revert NotImplemented();
    }

    /// @inheritdoc IClaimToken
    function burnOnRefund(bytes32) external {
        revert NotImplemented();
    }
}
