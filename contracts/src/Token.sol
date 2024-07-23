// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) Ownable(msg.sender) {
        // Mint initial supply to the contract deployer (owner)
        _mint(msg.sender, 0); // Initial supply is 0 for fair launch
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
