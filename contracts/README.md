## Bonding curve dynamics
The bonding curve mechanics of the pump.fun website involve a specific sequence of steps and economic principles that govern the buying and selling of tokens. Here’s a detailed explanation of each step:

### Step-by-Step Breakdown

1. **Pick a Coin**:
   - Users select a coin they are interested in from the available options on the pump.fun platform.

2. **Buy the Coin on the Bonding Curve**:
   - When you buy a coin, the price you pay is determined by the bonding curve. A bonding curve is a mathematical curve that defines the relationship between the token price and its supply. Typically, as more tokens are purchased, the price increases according to the curve formula.
   - For example, in a simple bonding curve model, the price could increase exponentially or logarithmically with the number of tokens issued.

3. **Sell at Any Time**:
   - Users can sell their tokens back to the bonding curve at any time. The price at which they can sell is also determined by the current state of the bonding curve.
   - If more tokens have been bought and the price has increased, users can sell at a higher price and lock in profits. Conversely, if the price has decreased, they might incur losses.

4. **Market Cap of $69k**:
   - The bonding curve mechanism continues to operate until the market capitalization of the coin reaches $69,000. Market cap is calculated as the total supply of tokens multiplied by the current price per token.
   - Reaching this market cap signifies a significant level of demand and liquidity for the token.

5. **Liquidity Deposit and Burning**:
   - When the market cap hits $69,000, $12,000 worth of liquidity is deposited into Raydium, a decentralized exchange and automated market maker (AMM) on the Solana blockchain.
   - This liquidity is then burned, which means it is permanently removed from circulation. Burning liquidity can help to reduce supply, potentially increasing the token's value due to scarcity.

### Bonding Curve Dynamics

- **Price and Supply Relationship**:
  - The bonding curve sets the price based on the total supply of tokens. Initially, the price is low to encourage early adoption. As more tokens are purchased, the price increases.
  - This creates a speculative dynamic where early buyers benefit from lower prices and potential price appreciation as more users buy in.

- **Incentives**:
  - Early participants are incentivized by the potential for higher returns as the token price increases with demand.
  - The mechanism ensures that the price reflects the actual demand for the token, as opposed to arbitrary pricing.

### Example Scenario

1. **Initial Purchase**:
   - Alice buys 10 tokens at an initial price of $1 each. The total supply is now 10, and the price may have increased slightly due to the bonding curve.

2. **Increased Demand**:
   - Bob buys 20 tokens, pushing the total supply to 30. The price per token has now increased to $2 due to the bonding curve.
   
3. **Selling for Profit**:
   - Alice decides to sell her 10 tokens. With the increased demand, she can sell at the new price of $2 per token, making a profit if she bought at $1.

4. **Market Cap Achievement**:
   - The market cap eventually reaches $69,000. At this point, the system deposits $12,000 into Raydium and burns it, potentially stabilizing the price and reducing future supply.

### Conclusion

The bonding curve mechanics of the pump.fun website create a dynamic market where token prices are directly tied to demand. The steps ensure a transparent and predictable pricing model while incentivizing early adoption and providing liquidity through the Raydium deposit and burn mechanism. This approach aligns the interests of the users with the growth and stability of the token ecosystem.



## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
