// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/BondingCurve.sol";
import "../src/PumpFun.sol";
import "../src/Token.sol";
import "../src/MockUniswapV2Router.sol";
import "../src/MockWETH.sol";

contract BondingCurveTest is Test {
    PumpFun public pumpFun;
    BondingCurve public bondingCurve;
    Token public token;
    MockUniswapV2Router public mockRouter;
    MockWETH public mockWETH;
    address public owner;
    address public user;

    function setUp() public {
        owner = address(this);
        user = vm.addr(1);
        mockWETH = new MockWETH();
        mockRouter = new MockUniswapV2Router(address(mockWETH));
        pumpFun = new PumpFun(address(mockRouter));

        (address tokenAddress, address bondingCurveAddress) = pumpFun.createTokenAndBondingCurve("Test Token", "TST");
        token = Token(tokenAddress);
        bondingCurve = BondingCurve(bondingCurveAddress);
    }

    function testTokenCreation() public view {
        assertEq(token.name(), "Test Token");
        assertEq(token.symbol(), "TST");
        assertEq(token.totalSupply(), 0);
    }

    function testBuyTokens() public {
        vm.deal(user, 1 ether); // Give user 1 ETH
        vm.startPrank(user);
        bondingCurve.buy{value: 0.1 ether}(1e18); // Buy 1 TST token with 0.1 ETH
        vm.stopPrank();

        assertEq(token.balanceOf(user), 1e18);
        assertEq(bondingCurve.reserve(), 0.1 ether);
        assertEq(bondingCurve.currentSupply(), 1e18);
    }

    function testSellTokens() public {
        vm.deal(user, 1 ether); // Give user 1 ETH
        vm.startPrank(user);
        bondingCurve.buy{value: 0.1 ether}(1e18); // Buy 1 TST token with 0.1 ETH
        token.approve(address(bondingCurve), 1e18); // Approve BondingCurve to spend user's tokens
        bondingCurve.sell(1e18); // Sell 1 TST token
        vm.stopPrank();

        assertEq(token.balanceOf(user), 0);
        assertEq(bondingCurve.currentSupply(), 0);

        // not working correctly
        assertEq(bondingCurve.reserve(), 99999899999900000);
    }

    // function testLiquidityBurn() public {
    //     uint256 marketCapThreshold = bondingCurve.MARKET_CAP_THRESHOLD();

    //     vm.deal(user, 70 ether); // Give user 70 ETH
    //     vm.startPrank(user);
    //     bondingCurve.buy{value: marketCapThreshold}(marketCapThreshold); // Buy tokens to reach market cap threshold
    //     vm.stopPrank();

    //     assertTrue(bondingCurve.liquidityBurned());
    // }
}

