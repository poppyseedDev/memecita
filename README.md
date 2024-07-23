# Memecita token Launchpad 

Frontend using  Wagmi, Tailwind CSS, RainbowKIT, TanStack Query.
Smart contracts using Foundry.

The **Memecita Smart Contract** is an innovative platform designed to allow users to create tokens and manage their trading using a bonding curve mechanism. This project ensures fair-launch principles with no presale and no team allocation, preventing rug pulls and promoting trust within the ecosystem.

## Features

- **Token Management**: Anyone can create new tokens with customizable names and symbols. Ensures a fair launch with zero initial supply.
- **Bonding Curve Mechanism**: Automatically initialize the bonding curve upon token creation, managing supply and demand dynamically.
- **Liquidity Management**: Automatically creates and burns liquidity once the market cap threshold is reached.
- **Mock Testing**: Includes comprehensive tests using Foundry with mock Uniswap V2 router and WETH contracts.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- [Foundry](https://book.getfoundry.sh/getting-started/installation.html)
- Node.js (for installing Foundry)

### Directory Structure

```
contracts/
├── src/
│   ├── BondingCurve.sol
│   ├── PumpFun.sol
│   └── Token.sol
├── test/
│   └── BondingCurveTest.t.sol
├── foundry.toml
```

### Contracts

#### Token.sol

Defines the ERC20 token with minting functionality. Ensures zero initial supply for a fair launch.

#### BondingCurve.sol

Implements a bonding curve mechanism to manage token supply and demand dynamically. Includes functionality to automatically create and burn liquidity once a market cap threshold is reached.

#### PumpFun.sol

Manages the creation of tokens and bonding curves. Provides functions for adding and removing liquidity, and for buying and selling tokens using the bonding curve mechanism.

#### MockUniswapV2Router.sol

A mock implementation of the Uniswap V2 router for testing purposes.

#### MockWETH.sol

A mock implementation of the WETH token for testing purposes.

### Testing

The project includes comprehensive tests using Foundry. The tests cover token creation, buying and selling tokens using the bonding curve, and the automatic liquidity creation and burning mechanism.

1. **Run the tests**:
   ```bash
   forge test
   ```

---

# New tokens will be launched on a bonding curve

## Bonding Curve Dynamics

The Memecita token Launchpad uses bonding curve mechanics to govern token transactions. Here's a brief overview:

1. **Create a Coin**: Ability to create a coin that uses the bonding curve.
2. **Buy the Coin**: The price is set by a bonding curve, which increases as more tokens are bought.
3. **Sell at Any Time**: Tokens can be sold back at the current bonding curve price, allowing for potential profits or losses.
4. **Market Cap of $69k**: The mechanism operates until the coin's market cap reaches $69,000. After which it goes to AMMs.
5. **Liquidity Deposit and Burning**: Upon reaching $69,000, $12,000 in liquidity is deposited into "Raydium" and burned, reducing supply and potentially increasing value.

### Dynamics

- **Price and Supply**: Prices start low to encourage early adoption and rise with demand.
- **Incentives**: Early buyers benefit from lower prices and potential appreciation as more users join.

### Example

1. **Initial Purchase**: Alice buys 10 tokens at $1 each.
2. **Increased Demand**: Bob buys 20 tokens, raising the price to $2.
3. **Selling for Profit**: Alice sells her tokens at $2 each, making a profit.
4. **Market Cap Achievement**: At a $69,000 market cap, $12,000 in liquidity is burned.





---

# NOT YET DEFINED

**Memecita Token Launchpad: Enhanced Definition and Features**

### Overview
Memecita is a cutting-edge token launchpad designed to energize the memecoin ecosystem, combining token dynamics with a focus on user engagement, security, and brand utility. Built on the principles of pump.fun, Memecita leverages $MCX tokens to create a vibrant and secure platform for trading, staking, and promoting memecoins.

### Token Dynamics

**Platform Fee:**
- A platform fee of 1-2% is applied to all user transactions (buying and selling).

**Minting $MCX:**
- Each $1 spent on memecoins mints 1 $MCX token.
- Minting occurs based on net weekly inflow (e.g., $100 spent and $50 sold results in 50 $MCX minted).

**Redistribution:**
- At the end of each week, all minted $MCX tokens are distributed among users based on their spending in a weekly leaderboard.
- The platform take-rate is redistributed 20% to the treasury and 80% to $MCX stakers.

**Claim Fee:**
- Newly minted $MCX tokens are subject to a linearly decreasing claim fee over three months. The proceeds from this fee are used to buy back and burn $MCX tokens.

**Staking:**
- Users can stake $MCX to earn a portion of the platform fees, enhancing their staking multiplier.
- $MCX staking also allows users to promote their memecoins on the platform, with a penalty (slashing) if a promoted coin rugs.
- Exclusive items, like the Memecita hat, can be purchased using $MCX.

**Halving Mechanism:**
- The cost to mint $MCX doubles after specific supply thresholds, creating a scarcity model:
  - $1 at 400M tokens
  - $2 at 200M tokens
  - $4 at 100M tokens
  - $8 at 50M tokens
  - $16 at 25M tokens
  - $32 at 12.5M tokens

### Allocation
- 30% of the total supply is allocated to the founding team.
- 70% is reserved for minting through platform activities.

### Additional Features

**Security and Anti-Rug Measures:**
- $MCX staking for coin promotion includes a slashing mechanism to penalize rugs, enhancing platform trust.
- Regular audits and transparent operations to maintain high security standards.

**User Experience:**
- A slick, fast-shipping UI with superb design and vibes.
- Weekly and all-time leaderboards to gamify and incentivize user engagement.

### Community and Engagement

**Leaderboards and Trends:**
- Retardio leaderboard tracks both all-time and weekly performance.
- Trending memecoins are highlighted, with boosted listings displayed as ads.

### Strategic Positioning
- The timing of Memecita’s launch is crucial, aiming to capture market interest during a downturn in altcoins and creating a narrative vacuum that Memecita can fill with its unique value proposition.

### Improving the Experience with $MCX
- **Minimizing Rugs:** The slashing mechanism for $MCX-staked promotions deters malicious actors, ensuring higher quality and trustworthiness of listed memecoins.
- **Enhanced Engagement:** Weekly redistribution and leaderboard incentives keep users actively involved, fostering a dynamic and lively community.
- **Utility and Scarcity:** The dual role of $MCX as both a memecoin and a utility token, combined with the halving mechanism, ensures long-term value and scarcity, appealing to both traders and investors.

Memecita is poised to revolutionize the memecoin landscape with its innovative token dynamics, robust security features, and engaging user experience, positioning $MCX as both a valuable asset and a cultural phenomenon.
