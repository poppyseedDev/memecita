// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract PumpFun is Ownable {
    IUniswapV2Router02 public uniswapRouter;

    constructor(address _uniswapRouter) {
        uniswapRouter = IUniswapV2Router02(_uniswapRouter);
    }

    function createToken(string memory name, string memory symbol, uint256 initialSupply) external onlyOwner returns (address) {
        ERC20 newToken = new ERC20(name, symbol);
        newToken._mint(msg.sender, initialSupply);
        return address(newToken);
    }

    function createPool(address token) external onlyOwner {
        // Pool creation logic with Uniswap
    }

    function addLiquidity(address token, uint256 amountToken, uint256 amountETH) external payable onlyOwner {
        IERC20(token).transferFrom(msg.sender, address(this), amountToken);
        IERC20(token).approve(address(uniswapRouter), amountToken);

        uniswapRouter.addLiquidityETH{value: amountETH}(
            token,
            amountToken,
            0,
            0,
            msg.sender,
            block.timestamp
        );
    }

    function removeLiquidity(address token, uint256 liquidity) external onlyOwner {
        IERC20 liquidityToken = IERC20(uniswapRouter.WETH());
        liquidityToken.approve(address(uniswapRouter), liquidity);

        uniswapRouter.removeLiquidityETH(
            token,
            liquidity,
            0,
            0,
            msg.sender,
            block.timestamp
        );
    }

    function buyToken(address token, uint256 amountToken) external payable {
        address[] memory path = new address[](2);
        path[0] = uniswapRouter.WETH();
        path[1] = token;

        uniswapRouter.swapExactETHForTokens{value: msg.value}(
            amountToken,
            path,
            msg.sender,
            block.timestamp
        );
    }

    function sellToken(address token, uint256 amountToken) external {
        IERC20(token).transferFrom(msg.sender, address(this), amountToken);
        IERC20(token).approve(address(uniswapRouter), amountToken);

        address[] memory path = new address[](2);
        path[0] = token;
        path[1] = uniswapRouter.WETH();

        uniswapRouter.swapExactTokensForETH(
            amountToken,
            0,
            path,
            msg.sender,
            block.timestamp
        );
    }
}
