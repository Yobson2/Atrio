import { useTranslations } from "next-intl";
import { ownerBookings, sampleBarbers, sampleSalon } from "./sample-data";
import { ScreenHeader, StatusChip, TabBar } from "./screen-chrome";

const statusTone = {
  confirmed: "teal",
  arriving: "gold",
  pending: "clay",
} as const;

/** Recreation of the salon owner "Dashboard" screen (owner_dashboard). */
export function OwnerDashboardScreen() {
  const t = useTranslations("screens");

  return (
    <>
      <ScreenHeader
        title="Atrio"
        trailing={<StatusChip tone="teal">{t("discover.open")}</StatusChip>}
      />

      <div className="mx-4 rounded-[var(--radius-card)] bg-[linear-gradient(135deg,var(--color-teal-deep),var(--color-teal))] px-3 py-3 text-white">
        <p className="text-[14px] font-semibold tracking-[-0.02em]">{sampleSalon.name}</p>
        <p className="text-[9px] text-white/75">{sampleSalon.district}</p>
      </div>

      <div className="mt-2 grid grid-cols-2 gap-1.5 px-4">
        {[
          { label: t("owner.todayBookings"), value: "18", bar: 0.72 },
          { label: t("owner.todayRevenue"), value: "54 000", unit: "FCFA", bar: 0.6 },
          { label: t("owner.weekBookings"), value: "124", bar: 0.82 },
          { label: t("owner.avgWait"), value: "8 min", bar: 0.3 },
        ].map((kpi) => (
          <div key={kpi.label} className="bg-card shadow-ambient rounded-lg px-2.5 py-2">
            <p className="text-ink-mute text-[8px]">{kpi.label}</p>
            <p className="tabular text-teal text-[15px] font-bold tracking-[-0.02em]">
              {kpi.value}
              {kpi.unit && <span className="ml-0.5 text-[8px] font-semibold">{kpi.unit}</span>}
            </p>
            <span className="bg-folder mt-1 block h-1 rounded-full">
              <span
                className="bg-teal block h-1 rounded-full"
                style={{ width: `${kpi.bar * 100}%` }}
              />
            </span>
          </div>
        ))}
      </div>

      <p className="mt-3 px-4 text-[11px] font-semibold">{t("owner.todaysBookings")}</p>
      <ul className="mt-1.5 flex flex-col gap-1.5 px-4">
        {ownerBookings.map((booking) => (
          <li
            key={booking.time}
            className="bg-card shadow-ambient flex items-center gap-2 rounded-lg px-2.5 py-2"
          >
            <span className="tabular text-teal w-8 text-[10px] font-bold">{booking.time}</span>
            <span className="flex-1">
              <span className="block text-[10px] font-semibold">{booking.name}</span>
              <span className="text-ink-mute block text-[8px]">
                {t(`services.${booking.service}`)} · {booking.barber}
              </span>
            </span>
            <StatusChip tone={statusTone[booking.status]}>
              {t(`owner.status.${booking.status}`)}
            </StatusChip>
          </li>
        ))}
      </ul>

      <div className="bg-teal-deep mx-4 mt-2 rounded-[var(--radius-card)] px-3 py-2.5 text-white">
        <p className="text-[10px] font-semibold">{t("owner.staff")}</p>
        <ul className="mt-1 flex flex-col gap-1">
          {sampleBarbers.map((barber, index) => (
            <li
              key={barber.name}
              className="flex items-center justify-between text-[9px] text-white/85"
            >
              {barber.name}
              <span
                className={
                  index === 1
                    ? "bg-teal-glow text-teal-night rounded-full px-2 py-0.5 text-[8px] font-semibold"
                    : "rounded-full bg-white/15 px-2 py-0.5 text-[8px]"
                }
              >
                {index === 1 ? t("owner.available") : t("owner.busy")}
              </span>
            </li>
          ))}
        </ul>
      </div>

      <TabBar
        items={[t("tabs.dashboard"), t("tabs.queue"), t("tabs.stats"), t("tabs.salon")]}
        active={0}
      />
    </>
  );
}
