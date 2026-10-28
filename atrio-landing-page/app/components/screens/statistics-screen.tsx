import { useTranslations } from "next-intl";
import { leaderboard, weeklyBookings } from "./sample-data";
import { ScreenHeader, TabBar } from "./screen-chrome";

/** Recreation of the owner "Statistics" screen (statistics). */
export function StatisticsScreen() {
  const t = useTranslations("screens");
  const days = t("booking.weekDays").split(",");
  const peak = Math.max(...weeklyBookings);

  return (
    <>
      <ScreenHeader title={t("stats.title")} />
      <div className="px-4">
        <div className="bg-folder flex rounded-full p-0.5 text-[9px] font-semibold">
          <span className="bg-teal flex-1 rounded-full py-1 text-center text-white">
            {t("stats.weekly")}
          </span>
          <span className="text-ink-mute flex-1 py-1 text-center">{t("stats.monthly")}</span>
        </div>

        <div className="mt-2.5 grid grid-cols-2 gap-1.5">
          {[
            { label: t("stats.bookings"), value: "138" },
            { label: t("stats.rating"), value: "4,8" },
            { label: t("stats.revenue"), value: "412k" },
            { label: t("stats.topService"), value: t("services.fade") },
          ].map((kpi) => (
            <div key={kpi.label} className="bg-card shadow-ambient rounded-lg px-2.5 py-2">
              <p className="text-ink-mute text-[8px]">{kpi.label}</p>
              <p className="tabular text-teal truncate text-[13px] font-bold tracking-[-0.02em]">
                {kpi.value}
              </p>
            </div>
          ))}
        </div>

        <div className="bg-card shadow-ambient mt-2.5 rounded-[var(--radius-card)] p-3">
          <p className="text-[10px] font-semibold">{t("stats.bookingsPerDay")}</p>
          <div className="mt-2 flex h-20 items-end gap-1.5">
            {weeklyBookings.map((value, index) => (
              <span key={index} className="flex flex-1 flex-col items-center gap-1">
                <span
                  className={
                    value === peak ? "bg-gold w-full rounded-md" : "bg-teal/80 w-full rounded-md"
                  }
                  style={{ height: `${(value / peak) * 64}px` }}
                />
                <span className="text-ink-mute text-[7px]">{days[index]}</span>
              </span>
            ))}
          </div>
        </div>

        <p className="mt-2.5 text-[10px] font-semibold">{t("stats.leaderboard")}</p>
        <ul className="mt-1.5 flex flex-col gap-1.5">
          {leaderboard.map((barber) => (
            <li key={barber.name} className="flex items-center gap-2 text-[9px]">
              <span className="w-10 font-semibold">{barber.name}</span>
              <span className="bg-folder h-1.5 flex-1 rounded-full">
                <span
                  className="bg-teal block h-1.5 rounded-full"
                  style={{ width: `${barber.share * 100}%` }}
                />
              </span>
            </li>
          ))}
        </ul>
      </div>

      <TabBar
        items={[t("tabs.dashboard"), t("tabs.queue"), t("tabs.stats"), t("tabs.salon")]}
        active={2}
      />
    </>
  );
}
