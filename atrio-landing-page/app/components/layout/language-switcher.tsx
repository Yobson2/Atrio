"use client";

import { useLocale, useTranslations } from "next-intl";
import { usePathname, useRouter } from "@/app/i18n/navigation";
import { routing, type Locale } from "@/app/i18n/routing";
import { cn } from "@/app/lib/utils";

const localeLabels: Record<Locale, { short: string; full: string }> = {
  fr: { short: "FR", full: "Français" },
  en: { short: "EN", full: "English" },
};

interface LanguageSwitcherProps {
  className?: string;
  tone?: "light" | "dark";
}

/** Segmented pill — the active locale is a filled chip, per the Griot chip spec. */
export function LanguageSwitcher({ className, tone = "light" }: LanguageSwitcherProps) {
  const t = useTranslations("nav");
  const locale = useLocale() as Locale;
  const pathname = usePathname();
  const router = useRouter();

  return (
    <div
      role="group"
      aria-label={t("language")}
      className={cn(
        "flex w-max items-center gap-0.5 rounded-full p-1 text-sm font-semibold",
        tone === "light" ? "bg-folder" : "bg-white/10",
        className
      )}
    >
      {routing.locales.map((l) => {
        const isActive = l === locale;
        return (
          <button
            key={l}
            type="button"
            lang={l}
            onClick={() => router.replace(pathname, { locale: l })}
            aria-pressed={isActive}
            aria-label={localeLabels[l].full}
            className={cn(
              "min-h-9 min-w-10 rounded-full px-2.5 transition-colors",
              isActive
                ? tone === "light"
                  ? "bg-card text-teal shadow-ambient"
                  : "bg-desk text-teal-deep"
                : tone === "light"
                  ? "text-ink-mute hover:text-ink"
                  : "text-desk/70 hover:text-desk"
            )}
          >
            {localeLabels[l].short}
          </button>
        );
      })}
    </div>
  );
}
