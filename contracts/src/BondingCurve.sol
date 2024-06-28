// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BondingCurveToken is ERC20, Ownable {
    uint256 public constant MAX_MARKET_CAP = 69000 * 1e18; // $69,000 in Wei
    uint256 public constant LIQUIDITY_AMOUNT = 12000 * 1e18; // $12,000 in Wei

    address public raydiumAddress; // Address where liquidity will be sent
    bool public liquidityBurned = false;

    // Bonding curve parameters (example: linear bonding curve)
    uint256 public constant INITIAL_PRICE = 1e16; // 0.01 ETH
    uint256 public constant PRICE_INCREMENT = 1e15; // 0.001 ETH per token

    event TokensPurchased(address indexed buyer, uint256 amount, uint256 cost);
    event TokensSold(address indexed seller, uint256 amount, uint256 revenue);
    event LiquidityBurned(uint256 amount);

    constructor(address _raydiumAddress) ERC20("BondingCurveToken", "BCT") Ownable(_raydiumAddress) {
        raydiumAddress = _raydiumAddress;
    }

    // Calculate the current price based on the total supply
    function getCurrentPrice() public view returns (uint256) {
        return INITIAL_PRICE + (totalSupply() * PRICE_INCREMENT);
    }

    // Buy tokens
    function buyTokens() public payable {
        require(!liquidityBurned, "Market cap reached, no more purchases allowed");

        uint256 currentPrice = getCurrentPrice();
        require(currentPrice > 0, "Current price should be greater than zero");
        uint256 amountToBuy = msg.value / currentPrice;
        require(amountToBuy > 0, "Amount to buy should be greater than zero");

        _mint(msg.sender, amountToBuy);

        emit TokensPurchased(msg.sender, amountToBuy, msg.value);

        if (totalSupply() * getCurrentPrice() >= MAX_MARKET_CAP) {
            _burnLiquidity();
        }
    }

    // Sell tokens
    function sellTokens(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient token balance");

        uint256 currentPrice = getCurrentPrice();
        require(currentPrice > 0, "Current price should be greater than zero");
        uint256 revenue = amount * currentPrice;

        _burn(msg.sender, amount);
        payable(msg.sender).transfer(revenue);

        emit TokensSold(msg.sender, amount, revenue);
    }

    // Burn liquidity when market cap is reached
    function _burnLiquidity() internal {
        require(!liquidityBurned, "Liquidity already burned");

        liquidityBurned = true;
        payable(raydiumAddress).transfer(LIQUIDITY_AMOUNT);

        emit LiquidityBurned(LIQUIDITY_AMOUNT);
    }

    // Withdraw function for contract owner (for demonstration purposes)
    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // Receive function to accept ETH
    receive() external payable {
        buyTokens();
    }
}
