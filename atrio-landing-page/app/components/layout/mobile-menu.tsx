"use client";

import { useEffect } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { useTranslations } from "next-intl";
import { Link } from "@/app/i18n/navigation";
import { ButtonLink } from "@/app/components/ui/button-link";
import { easeOutQuint } from "@/app/lib/animations";
import { navLinks } from "@/app/lib/constants";
import { LanguageSwitcher } from "./language-switcher";

interface MobileMenuProps {
  isOpen: boolean;
  onClose: () => void;
}

/** Drop-down sheet under the nav bar. Only mounted while open, so it never traps focus. */
export function MobileMenu({ isOpen, onClose }: MobileMenuProps) {
  const t = useTranslations("nav");

  useEffect(() => {
    if (!isOpen) return;
    const onKeyDown = (event: KeyboardEvent) => {
      if (event.key === "Escape") onClose();
    };
    const previousOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    document.addEventListener("keydown", onKeyDown);
    return () => {
      document.body.style.overflow = previousOverflow;
      document.removeEventListener("keydown", onKeyDown);
    };
  }, [isOpen, onClose]);

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div
          id="mobile-menu"
          initial={{ opacity: 0, y: -8 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: -8 }}
          transition={{ duration: 0.25, ease: easeOutQuint }}
          className="bg-desk absolute inset-x-0 top-full h-[calc(100dvh-4.5rem)] px-5 pt-4 pb-8 lg:hidden"
        >
          <ul className="flex flex-col gap-1">
            {navLinks.map((link) => (
              <li key={link.href}>
                <Link
                  href={link.href}
                  onNavigate={onClose}
                  className="hover:bg-folder flex min-h-14 items-center rounded-[var(--radius-card)] px-4 text-2xl font-semibold tracking-[-0.02em] transition-colors"
                >
                  {t(link.textKey)}
                </Link>
              </li>
            ))}
          </ul>
          <div className="mt-8 flex flex-col gap-4 px-4">
            <ButtonLink href="/#download" onNavigate={onClose} className="w-full">
              {t("download")}
            </ButtonLink>
            <LanguageSwitcher />
          </div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
