import { http } from 'wagmi'
import {
    argentWallet,
    bitgetWallet,
    bifrostWallet,
    bitskiWallet,
    braveWallet,
    coinbaseWallet,
    coin98Wallet,
    coreWallet,
    dawnWallet,
    enkryptWallet,
    foxWallet,
    frameWallet,
    frontierWallet,
    imTokenWallet,
    injectedWallet,
    ledgerWallet,
    metaMaskWallet,
    mewWallet,
    okxWallet,
    omniWallet,
    oneKeyWallet,
    phantomWallet,
    rabbyWallet,
    rainbowWallet,
    safeWallet,
    safeheronWallet,
    tahoWallet,
    talismanWallet,
    tokenaryWallet,
    tokenPocketWallet,
    trustWallet,
    uniswapWallet,
    walletConnectWallet,
    xdefiWallet,
    zerionWallet,
  } from '@rainbow-me/rainbowkit/wallets';
import {
    mainnet,
    sepolia,
    polygon,
    optimism,
    arbitrum,
    base,
  } from 'wagmi/chains';
import { getDefaultConfig } from '@rainbow-me/rainbowkit'

const projectId = process.env.NEXT_PUBLIC_WALLETCONNECT_ID || '';


const wallets = [
    //...getDefaultWallets().wallets,
    {
      groupName: 'Recommended',
      wallets: [
        metaMaskWallet,
        rainbowWallet,
        rabbyWallet,
        ledgerWallet,
        walletConnectWallet,
        phantomWallet,
        coinbaseWallet,
        coin98Wallet,
        trustWallet,
        uniswapWallet,
      ],
    },
    {
      groupName: 'Other Wallets',
      wallets: [
        argentWallet,
        bitgetWallet,
        bifrostWallet,
        bitskiWallet,
        braveWallet,
        coreWallet,
        dawnWallet,
        enkryptWallet,
        foxWallet,
        frameWallet,
        frontierWallet,
        imTokenWallet,
        injectedWallet,
        mewWallet,
        okxWallet,
        omniWallet,
        oneKeyWallet,
        safeWallet,
        safeheronWallet,
        tahoWallet,
        talismanWallet,
        tokenaryWallet,
        tokenPocketWallet,
        xdefiWallet,
        zerionWallet,
      ],
    },
  ];
  

  /* New API that includes Wagmi's createConfig and replaces getDefaultWallets and connectorsForWallets */
export const config = getDefaultConfig({
    appName: 'My RainbowKit App',
    projectId: projectId,
    wallets: wallets,
    chains: [
        mainnet, 
        polygon, 
        optimism, 
        arbitrum, 
        base,
        ...(process.env.NEXT_PUBLIC_ENABLE_TESTNETS === 'true' ? [sepolia] : []),
    ],
    transports: {
    [mainnet.id]: http(),
  },
})
