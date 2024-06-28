// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/BondingCurve.sol";

contract BondingCurveTokenTest is Test {
    BondingCurveToken token;
    address constant raydiumAddress = address(0x123);
    uint256 public constant MAX_MARKET_CAP = 69000 * 1e18; // $69,000 in Wei
    uint256 public constant LIQUIDITY_AMOUNT = 12000 * 1e18; // $12,000 in Wei

    function setUp() public {
        token = new BondingCurveToken(raydiumAddress);
    }

    function testInitialPrice() public view {
        uint256 price = token.getCurrentPrice();
        assertEq(price, 1e16, "Initial price should be 0.01 ETH");
    }

    function testBuyTokens() public {
        uint256 buyAmount = 1e16; // 0.01 ETH
        uint256 currentPrice = token.getCurrentPrice();
        uint256 expectedTokens = buyAmount / currentPrice;

        hoax(address(0xabc), buyAmount);
        token.buyTokens{value: buyAmount}();

        uint256 balance = token.balanceOf(address(0xabc));
        assertEq(balance, expectedTokens, "Token balance should match expected tokens");
    }

    function testSellTokens() public {
        uint256 buyAmount = 1e16; // 0.01 ETH

        // Fund the contract with enough ETH to handle the sell operation
        hoax(address(this), buyAmount * 10); // Provide sufficient ETH to the contract
        token.buyTokens{value: buyAmount * 10}(); // Accumulate ETH in the contract

        hoax(address(0xabc), buyAmount * 2);
        token.buyTokens{value: buyAmount * 2}();

        uint256 sellAmount = token.balanceOf(address(0xabc));
        uint256 sellPrice = token.getCurrentPrice();

        hoax(address(0xabc), 0);
        token.sellTokens(sellAmount);

        uint256 balance = token.balanceOf(address(0xabc));
        assertEq(balance, 0, "Token balance should be zero after selling");

        uint256 revenue = sellAmount * sellPrice;
        assertEq(address(0xabc).balance, revenue, "ETH balance should match expected revenue");
    }

    function testMarketCapReached() public {
        uint256 buyAmount = MAX_MARKET_CAP;
        uint256 currentPrice = token.getCurrentPrice();
        uint256 expectedTokens = buyAmount / currentPrice;

        hoax(address(0xabc), buyAmount);
        token.buyTokens{value: buyAmount}();

        uint256 balance = token.balanceOf(address(0xabc));
        assertEq(balance, expectedTokens, "Token balance should match expected tokens");

        uint256 marketCap = token.totalSupply() * token.getCurrentPrice();
        assertTrue(marketCap >= token.MAX_MARKET_CAP(), "Market cap should be reached");

        assertEq(address(raydiumAddress).balance, token.LIQUIDITY_AMOUNT(), "Raydium address should have liquidity amount");
    }

    function testFallbackFunction() public {
        uint256 sendAmount = 1e16; // 0.01 ETH
        uint256 currentPrice = token.getCurrentPrice();
        uint256 expectedTokens = sendAmount / currentPrice;

        hoax(address(0xabc), sendAmount);
        (bool success, ) = address(token).call{value: sendAmount}("");
        assertTrue(success, "Fallback function should succeed");

        uint256 balance = token.balanceOf(address(0xabc));
        assertEq(balance, expectedTokens, "Token balance should match expected tokens");
    }
}
