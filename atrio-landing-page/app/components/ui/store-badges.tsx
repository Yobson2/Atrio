import { useTranslations } from "next-intl";
import { siteConfig } from "@/app/lib/constants";
import { cn } from "@/app/lib/utils";

function AppleGlyph({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={className} aria-hidden="true" fill="currentColor">
      <path d="M16.37 12.6c-.02-2.3 1.88-3.4 1.96-3.46-1.07-1.56-2.73-1.78-3.32-1.8-1.41-.14-2.76.83-3.48.83-.72 0-1.82-.81-3-.79-1.54.02-2.96.9-3.76 2.28-1.6 2.78-.41 6.9 1.15 9.16.76 1.1 1.67 2.34 2.86 2.3 1.15-.05 1.58-.74 2.96-.74 1.39 0 1.77.74 2.98.72 1.23-.02 2.01-1.12 2.76-2.23.87-1.28 1.23-2.51 1.25-2.58-.03-.01-2.39-.92-2.41-3.65ZM14.1 5.86c.63-.77 1.06-1.83.94-2.89-.91.04-2.01.61-2.66 1.37-.58.67-1.1 1.76-.96 2.8 1.02.08 2.05-.52 2.68-1.28Z" />
    </svg>
  );
}

function PlayGlyph({ className }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={className} aria-hidden="true">
      <path
        d="M4.2 2.6 13.6 12l-9.4 9.4a1.6 1.6 0 0 1-.6-1.3V3.9c0-.5.2-1 .6-1.3Z"
        fill="#00a173"
      />
      <path d="m16.8 8.8-3.2 3.2 3.2 3.2 3.6-2a1.4 1.4 0 0 0 0-2.4l-3.6-2Z" fill="#f0c060" />
      <path d="M13.6 12 4.2 21.4c.4.3 1 .4 1.6.1l11-6.3-3.2-3.2Z" fill="#c4502e" />
      <path d="M5.8 2.5c-.6-.3-1.2-.2-1.6.1l9.4 9.4 3.2-3.2-11-6.3Z" fill="#008378" />
    </svg>
  );
}

interface StoreBadgesProps {
  tone?: "light" | "dark";
  className?: string;
}

/**
 * App Store / Google Play entry points. Without a configured URL a badge
 * renders as a non-interactive "coming soon" chip instead of a dead link.
 */
export function StoreBadges({ tone = "light", className }: StoreBadgesProps) {
  const t = useTranslations("download");

  const stores = [
    {
      key: "appStore",
      url: siteConfig.stores.appStore,
      glyph: <AppleGlyph className="size-6" />,
      label: t("appStore"),
    },
    {
      key: "googlePlay",
      url: siteConfig.stores.googlePlay,
      glyph: <PlayGlyph className="size-5.5" />,
      label: t("googlePlay"),
    },
  ] as const;

  const base =
    "flex min-h-14 items-center gap-3 rounded-[var(--radius-card)] px-5 py-2.5 text-left transition";

  return (
    <ul className={cn("flex flex-wrap gap-3", className)}>
      {stores.map((store) => {
        const content = (
          <>
            {store.glyph}
            <span className="flex flex-col leading-tight">
              <span className="text-xs opacity-80">
                {store.url ? t("getItOn") : t("comingSoon")}
              </span>
              <span className="text-base font-semibold tracking-[-0.01em]">{store.label}</span>
            </span>
          </>
        );

        return (
          <li key={store.key}>
            {store.url ? (
              <a
                href={store.url}
                target="_blank"
                rel="noopener noreferrer"
                className={cn(
                  base,
                  "shadow-ambient hover:shadow-lift hover:-translate-y-0.5",
                  tone === "light" ? "bg-ink text-desk" : "bg-desk text-ink"
                )}
              >
                {content}
              </a>
            ) : (
              <span
                className={cn(
                  base,
                  tone === "light" ? "bg-recess text-ink-soft" : "text-desk/85 bg-white/10"
                )}
              >
                {content}
              </span>
            )}
          </li>
        );
      })}
    </ul>
  );
}
