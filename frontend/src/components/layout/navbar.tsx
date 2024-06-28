import { useState, useEffect } from 'react';
//Importing Next
import Image from 'next/image';
import Link from 'next/link';
//Importing RainbowKit
import { ConnectButton } from '@rainbow-me/rainbowkit';
import { MainNav } from "@/components/layout/main-nav"
import { MobileNav } from "@/components/layout/mobile-nav"
import { ModeToggle } from "@/components/shared/mode-toggle"

export default function NavBar() {
  const [isNavVisible, setNavVisibility] = useState(false);

  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return null;
  }

  const toggleNav = () => {
    setNavVisibility(!isNavVisible);
  };

  return (
    <header className="mx-auto sticky top-0 z-50 w-full border-b backdrop-blur transition-all">
      <nav className="container flex items-center justify-between h-20">

        <MainNav />
        <MobileNav />
          <div className="flex pt-2 md:pt-0 items-center justify-center">
              <ConnectButton />
              <ModeToggle />

        </div>

      </nav>
    </header>
  );
}
