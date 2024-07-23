// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "./Token.sol";

contract BondingCurve is Ownable {
    IUniswapV2Router02 public uniswapRouter;
    uint256 public constant MAX_SUPPLY = 1000000 * 10**18;
    uint256 public constant MARKET_CAP_THRESHOLD = 69000 * 10**18; // $69k
    uint256 public constant LIQUIDITY_AMOUNT = 12000 * 10**18; // $12k

    uint256 public currentSupply;
    uint256 public reserve;

    Token public token;
    bool public liquidityBurned;

    event Buy(address indexed buyer, uint256 amount, uint256 price);
    event Sell(address indexed seller, uint256 amount, uint256 price);
    event LiquidityBurned(uint256 amount);

    constructor(address _token, address _uniswapRouter) Ownable(msg.sender) {
        token = Token(_token);
        uniswapRouter = IUniswapV2Router02(_uniswapRouter);
        liquidityBurned = false;
    }

    function getPrice(uint256 _amount) public view returns (uint256) {
        return (_amount * reserve) / (MAX_SUPPLY - currentSupply);
    }

    function buy(uint256 _amount) external payable {
        uint256 cost = getPrice(_amount);
        require(msg.value >= cost, "Insufficient ETH sent");

        reserve += msg.value;
        currentSupply += _amount;

        token.mint(msg.sender, _amount);
        emit Buy(msg.sender, _amount, cost);

        if (reserve >= MARKET_CAP_THRESHOLD && !liquidityBurned) {
            _createAndBurnLiquidity();
        }
    }

    function sell(uint256 _amount) external {
        require(token.balanceOf(msg.sender) >= _amount, "Insufficient tokens");

        uint256 refund = getPrice(_amount);
        reserve -= refund;
        currentSupply -= _amount;

        token.transferFrom(msg.sender, address(this), _amount);
        payable(msg.sender).transfer(refund);
        emit Sell(msg.sender, _amount, refund);
    }

    function _createAndBurnLiquidity() internal {
        uint256 amountETH = LIQUIDITY_AMOUNT;
        address[] memory path = new address[](2);
        path[0] = address(uniswapRouter.WETH());
        path[1] = address(token);

        uniswapRouter.swapExactETHForTokens{value: amountETH}(
            0,
            path,
            address(0), // Burning the tokens
            block.timestamp
        );

        liquidityBurned = true;
        emit LiquidityBurned(amountETH);
    }
}
