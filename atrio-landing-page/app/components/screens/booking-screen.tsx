import { useTranslations } from "next-intl";
import { cn } from "@/app/lib/utils";
import { sampleBarbers } from "./sample-data";
import { ScreenHeader } from "./screen-chrome";

const slots = [
  { time: "09:30", free: false },
  { time: "10:15", free: true },
  { time: "11:00", free: true },
  { time: "13:45", free: false },
  { time: "14:30", free: true },
  { time: "15:15", free: true },
] as const;

const SELECTED_SLOT = "14:30";
const SELECTED_DAY = 2;

/** Recreation of the booking flow's barber + time step (select_barber / select_time). */
export function BookingScreen() {
  const t = useTranslations("screens");
  const days = t("booking.days").split(",");

  return (
    <>
      <ScreenHeader title="Atrio" />
      <div className="px-4">
        <p className="text-ink-mute text-[9px] font-semibold">{t("booking.step")}</p>
        <p className="mt-0.5 text-[17px] font-semibold tracking-[-0.02em]">{t("booking.title")}</p>

        <div className="bg-folder mt-2.5 flex rounded-lg p-0.5 text-[10px] font-semibold">
          <span className="bg-card text-teal shadow-ambient flex-1 rounded-md py-1.5 text-center">
            {t("booking.reservation")}
          </span>
          <span className="text-ink-mute flex-1 py-1.5 text-center">{t("booking.walkIn")}</span>
        </div>

        <p className="mt-3 text-[10px] font-semibold">{t("booking.barber")}</p>
        <div className="mt-1.5 flex gap-1.5">
          <span className="bg-folder text-ink-soft flex flex-1 flex-col items-center gap-1 rounded-lg py-2 text-[8px]">
            <span className="bg-gold-mist text-gold-ink flex size-7 items-center justify-center rounded-full text-[10px] font-bold">
              ✦
            </span>
            {t("booking.anyBarber")}
          </span>
          {sampleBarbers.map((barber, index) => (
            <span
              key={barber.name}
              className={cn(
                "flex flex-1 flex-col items-center gap-1 rounded-lg py-2 text-[8px]",
                index === 0 ? "bg-teal-mist text-teal font-semibold" : "bg-folder text-ink-soft"
              )}
            >
              <span
                className={cn(
                  "flex size-7 items-center justify-center rounded-full text-[10px] font-bold",
                  index === 0 ? "bg-teal text-white" : "bg-chip text-ink-soft"
                )}
              >
                {barber.initials}
              </span>
              {barber.name}
            </span>
          ))}
        </div>

        <div className="mt-3 flex gap-1">
          {days.map((day, index) => (
            <span
              key={day}
              className={cn(
                "flex flex-1 flex-col items-center rounded-lg py-1.5 text-[8px]",
                index === SELECTED_DAY ? "bg-teal text-white" : "bg-folder text-ink-soft"
              )}
            >
              {day}
              <span className="tabular text-[12px] font-bold">{14 + index}</span>
            </span>
          ))}
        </div>

        <p className="mt-3 text-[10px] font-semibold">{t("booking.slots")}</p>
        <div className="mt-1.5 grid grid-cols-3 gap-1.5">
          {slots.map((slot) => (
            <span
              key={slot.time}
              className={cn(
                "tabular rounded-full py-1.5 text-center text-[10px] font-semibold",
                slot.time === SELECTED_SLOT
                  ? "bg-teal text-white"
                  : slot.free
                    ? "bg-chip text-ink-soft"
                    : "bg-folder text-ghost line-through"
              )}
            >
              {slot.time}
            </span>
          ))}
        </div>
      </div>

      <div className="mt-auto px-4 pb-4">
        <div className="bg-folder flex items-center justify-between rounded-[var(--radius-card)] px-3 py-2">
          <span>
            <span className="text-ink-mute block text-[8px]">{t("booking.summaryLabel")}</span>
            <span className="block text-[10px] font-semibold">{t("booking.summary")}</span>
          </span>
          <span className="tabular text-teal text-[11px] font-bold">3 000 FCFA</span>
        </div>
        <div className="cta-gradient mt-2 rounded-lg py-2.5 text-center text-[11px] font-semibold text-white">
          {t("booking.next")}
        </div>
      </div>
    </>
  );
}
