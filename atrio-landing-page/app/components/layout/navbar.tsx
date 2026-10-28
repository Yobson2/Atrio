"use client";

import { useCallback, useEffect, useState } from "react";
import { Menu, X } from "lucide-react";
import { useTranslations } from "next-intl";
import { Link, usePathname } from "@/app/i18n/navigation";
import { ButtonLink } from "@/app/components/ui/button-link";
import { Logo } from "@/app/components/ui/logo";
import { navLinks } from "@/app/lib/constants";
import { cn } from "@/app/lib/utils";
import { LanguageSwitcher } from "./language-switcher";
import { MobileMenu } from "./mobile-menu";

export function Navbar() {
  const t = useTranslations("nav");
  const pathname = usePathname();
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);

  const closeMenu = useCallback(() => setIsMenuOpen(false), []);

  useEffect(() => {
    const onScroll = () => setIsScrolled(window.scrollY > 8);
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <header
      className={cn(
        "bg-desk/80 sticky top-0 z-50 backdrop-blur-xl transition-shadow duration-300",
        (isScrolled || isMenuOpen) && "shadow-ambient"
      )}
    >
      <nav
        aria-label={t("label")}
        className="mx-auto flex h-18 max-w-7xl items-center justify-between gap-6 px-5 md:px-10"
      >
        <Link href="/" aria-label={t("home")} className="rounded-lg">
          <Logo />
        </Link>

        <ul className="hidden items-center gap-1 lg:flex">
          {navLinks.map((link) => {
            const isCurrent = link.href === pathname;
            return (
              <li key={link.href}>
                <Link
                  href={link.href}
                  aria-current={isCurrent ? "page" : undefined}
                  className={cn(
                    "rounded-lg px-3.5 py-2 text-[0.95rem] font-medium transition-colors",
                    isCurrent
                      ? "bg-folder text-teal"
                      : "text-ink-soft hover:bg-folder hover:text-ink"
                  )}
                >
                  {t(link.textKey)}
                </Link>
              </li>
            );
          })}
        </ul>

        <div className="flex items-center gap-2">
          <LanguageSwitcher className="hidden sm:flex" />
          <ButtonLink href="/#download" className="hidden min-h-11 px-5 sm:inline-flex">
            {t("download")}
          </ButtonLink>
          <button
            type="button"
            onClick={() => setIsMenuOpen((open) => !open)}
            aria-expanded={isMenuOpen}
            aria-controls="mobile-menu"
            aria-label={isMenuOpen ? t("closeMenu") : t("openMenu")}
            className="bg-folder text-ink hover:bg-recess flex size-11 items-center justify-center rounded-[var(--radius-card)] transition lg:hidden"
          >
            {isMenuOpen ? <X className="size-5" /> : <Menu className="size-5" />}
          </button>
        </div>
      </nav>

      <MobileMenu isOpen={isMenuOpen} onClose={closeMenu} />
    </header>
  );
}
