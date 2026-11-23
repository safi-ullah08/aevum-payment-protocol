// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/// @title MockTUSD8
/// @notice TESTS ONLY. Mirrors tUSD8 (ERC-20, 6 decimals, EIP-2612 permit) with an open mint.
/// @dev Never deploy this to a live network.
contract MockTUSD8 is ERC20, ERC20Permit {
    constructor() ERC20("Test USD8", "tUSD8") ERC20Permit("Test USD8") {}

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    /// @notice Open mint for tests.
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
