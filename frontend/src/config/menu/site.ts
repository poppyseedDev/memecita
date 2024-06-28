// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Site
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
interface SiteConfig {
  name: string
  title: string
  emoji: string
  description: string
  localeDefault: string
  links: {
    docs: string
    discord: string
    twitter: string
    github: string
  }
}

export const siteConfig: SiteConfig = {
  name: "Template",
  title: "Hackathon Starter Template",
  emoji: "👩‍💻",
  description:
    "Hackathon starter template with Next.js, Tailwind CSS, TypeScript, Wagmi and RainbowKit.",
  localeDefault: "en",
  links: {
    docs: "https://docs",
    discord: "https://discord.com",
    twitter: "https://x.com/poppyseeddev",
    github: "https://github.com/poppyseeddev",
  },
}

export const DEPLOY_URL =
  "https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fturbo-eth%2Ftemplate-web3-app&project-name=TurboETH&repository-name=turbo-eth&demo-title=TurboETH&env=NEXTAUTH_SECRET,DATABASE_URL&envDescription=How%20to%20get%20these%20env%20variables%3A&envLink=https%3A%2F%2Fgithub.com%2Fturbo-eth%2Ftemplate-web3-app%2Fblob%2Fintegrations%2F.env.example"
