// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MockUniswapV2Router {
    address public WETH;

    constructor(address _WETH) {
        WETH = _WETH;
    }

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity) {
        require(msg.value >= amountETHMin, "Insufficient ETH sent");

        IERC20(token).transferFrom(msg.sender, address(this), amountTokenDesired);
        return (amountTokenDesired, msg.value, 0);
    }

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH) {
        // Mock implementation for removing liquidity
        IERC20(token).transfer(to, amountTokenMin);
        payable(to).transfer(amountETHMin);
        return (amountTokenMin, amountETHMin);
    }

    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts) {
        // Mock implementation for swapping ETH for tokens
        uint[] memory result = new uint[](2);
        result[0] = msg.value;
        result[1] = amountOutMin;
        IERC20(path[1]).transfer(to, amountOutMin);
        return result;
    }

    function swapExactTokensForETH(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts) {
        // Mock implementation for swapping tokens for ETH
        uint[] memory result = new uint[](2);
        result[0] = amountIn;
        result[1] = amountOutMin;
        IERC20(path[0]).transferFrom(msg.sender, address(this), amountIn);
        payable(to).transfer(amountOutMin);
        return result;
    }
}
