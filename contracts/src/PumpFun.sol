// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "./Token.sol";
import "./BondingCurve.sol";

contract PumpFun is Ownable {
    IUniswapV2Router02 public uniswapRouter;

    event PoolCreated(address indexed token, address indexed bondingCurve);

    constructor(address _uniswapRouter) Ownable(msg.sender) {
        uniswapRouter = IUniswapV2Router02(_uniswapRouter);
    }

    function createToken(string memory name, string memory symbol) external onlyOwner returns (address) {
        Token newToken = new Token(name, symbol);
        return address(newToken);
    }

    function createBondingCurve(address token) external onlyOwner returns (address) {
        BondingCurve bondingCurve = new BondingCurve(token, address(uniswapRouter), msg.sender);
        emit PoolCreated(token, address(bondingCurve));
        return address(bondingCurve);
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
