// SPDX-License-Identifier: MIT

pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor(
        string memory name,
        string memory symbol,
        address owner,
        uint256 supply
    ) ERC20(name, symbol) {
        _mint(owner, supply);
    }
}
