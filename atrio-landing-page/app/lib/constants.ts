import type { NavLink } from "@/app/types";

/**
 * ===== SITE CONFIGURATION =====
 * Single source of truth for Atrio's public identity.
 * Translatable strings live in /messages/{locale}.json
 *
 * Leave a value empty until it is real — the UI hides or degrades
 * gracefully (e.g. store badges show "coming soon" without a URL).
 */
export const siteConfig = {
  name: "Atrio",
  url: process.env.NEXT_PUBLIC_SITE_URL ?? "http://localhost:3000",

  themeColor: "#00685f",

  // TODO: fill in once the store listings are live.
  stores: {
    appStore: "",
    googlePlay: "",
  },

  // TODO: public support address. Hidden from the page while empty.
  email: "",
} as const;

export const navLinks: NavLink[] = [
  { href: "/#how-it-works", textKey: "howItWorks" },
  { href: "/salons", textKey: "forSalons" },
  { href: "/#faq", textKey: "faq" },
];

export const hasStoreLinks = Boolean(siteConfig.stores.appStore || siteConfig.stores.googlePlay);
