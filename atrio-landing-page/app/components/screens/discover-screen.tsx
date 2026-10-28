import { MapPin, Search, SlidersHorizontal } from "lucide-react";
import { useTranslations } from "next-intl";
import { sampleSalons } from "./sample-data";
import { ScreenHeader, StatusChip, TabBar } from "./screen-chrome";

const coverTones = [
  "bg-[linear-gradient(135deg,var(--color-teal-deep),var(--color-teal-bright))]",
  "bg-[linear-gradient(135deg,var(--color-gold-ink),var(--color-gold))]",
  "bg-[linear-gradient(135deg,var(--color-ink-soft),var(--color-clay))]",
] as const;

/** Recreation of the client "Discover" screen (salon_discovery). */
export function DiscoverScreen() {
  const t = useTranslations("screens");

  return (
    <>
      <ScreenHeader title="Atrio" />
      <div className="flex gap-2 px-4">
        <div className="bg-folder text-ink-mute flex flex-1 items-center gap-2 rounded-lg px-3 py-2 text-[10px]">
          <Search className="size-3.5" />
          {t("discover.search")}
        </div>
        <span className="cta-gradient flex size-8 items-center justify-center rounded-lg text-white">
          <SlidersHorizontal className="size-3.5" />
        </span>
      </div>
      <div className="mt-2.5 flex gap-1.5 px-4">
        {[t("discover.nearby"), t("discover.openNow"), t("discover.topRated")].map((chip, i) => (
          <span
            key={chip}
            className={
              i === 0
                ? "bg-teal rounded-full px-2.5 py-1 text-[9px] font-semibold text-white"
                : "bg-chip text-ink-soft rounded-full px-2.5 py-1 text-[9px]"
            }
          >
            {chip}
          </span>
        ))}
      </div>

      <ul className="mt-3 flex flex-col gap-2.5 px-4">
        {sampleSalons.map((salon, index) => (
          <li
            key={salon.name}
            className="bg-card shadow-ambient overflow-hidden rounded-[var(--radius-card)]"
          >
            <div className={`relative h-16 ${coverTones[index]}`}>
              <span className="absolute top-2 right-2">
                <StatusChip tone={salon.open ? "teal" : "clay"}>
                  {salon.open ? t("discover.open") : t("discover.closed")}
                </StatusChip>
              </span>
            </div>
            <div className="px-3 py-2">
              <div className="flex items-center justify-between">
                <span className="text-[12px] font-semibold tracking-[-0.01em]">{salon.name}</span>
                <span className="text-gold-ink text-[9px] font-semibold">★ {salon.rating}</span>
              </div>
              <p className="text-ink-mute mt-0.5 flex items-center gap-1 text-[9px]">
                <MapPin className="size-2.5" />
                {salon.district}, Abidjan
              </p>
              <div className="mt-1.5 flex gap-1">
                {salon.tags.map((tag) => (
                  <span
                    key={tag}
                    className="bg-chip text-ink-soft rounded-full px-2 py-0.5 text-[8px]"
                  >
                    {t(`discover.tags.${tag}`)}
                  </span>
                ))}
              </div>
            </div>
          </li>
        ))}
      </ul>

      <TabBar
        items={[t("tabs.discover"), t("tabs.bookings"), t("tabs.queue"), t("tabs.profile")]}
        active={0}
      />
    </>
  );
}
