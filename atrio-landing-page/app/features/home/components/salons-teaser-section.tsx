import { CalendarCheck, ChartColumn, ListOrdered, Users } from "lucide-react";
import { useTranslations } from "next-intl";
import { ButtonLink } from "@/app/components/ui/button-link";
import { PhoneFrame } from "@/app/components/ui/phone-frame";
import { OwnerDashboardScreen } from "@/app/components/screens/owner-dashboard-screen";
import { OwnerQueueScreen } from "@/app/components/screens/owner-queue-screen";

const capabilities = [
  { key: "queue", Icon: ListOrdered },
  { key: "bookings", Icon: CalendarCheck },
  { key: "team", Icon: Users },
  { key: "stats", Icon: ChartColumn },
] as const;

export function SalonsTeaserSection() {
  const t = useTranslations("salonsTeaser");

  return (
    <section
      aria-labelledby="salons-teaser-heading"
      className="on-dark bg-teal-deep text-desk overflow-hidden"
    >
      <div className="mx-auto grid max-w-7xl items-center gap-16 px-5 py-24 md:px-10 lg:grid-cols-2 lg:py-32">
        <div>
          <p className="text-gold font-semibold">{t("kicker")}</p>
          <h2
            id="salons-teaser-heading"
            className="headline mt-4 max-w-[16ch] text-[clamp(2rem,4.6vw,3.5rem)] font-semibold"
          >
            {t("heading")}
          </h2>
          <p className="text-desk/80 mt-5 max-w-lg text-lg leading-relaxed">{t("body")}</p>

          <ul className="mt-10 grid gap-x-8 gap-y-7 sm:grid-cols-2">
            {capabilities.map(({ key, Icon }) => (
              <li key={key}>
                <Icon aria-hidden="true" className="text-teal-glow size-5" />
                <p className="mt-3 font-semibold">{t(`capabilities.${key}.title`)}</p>
                <p className="text-desk/75 mt-1 leading-relaxed">{t(`capabilities.${key}.body`)}</p>
              </li>
            ))}
          </ul>

          <ButtonLink href="/salons" variant="ivory" className="mt-12">
            {t("cta")}
          </ButtonLink>
        </div>

        <div className="relative flex justify-center lg:justify-start lg:pl-6">
          <PhoneFrame label={t("dashboardLabel")} className="relative z-10">
            <OwnerDashboardScreen />
          </PhoneFrame>
          <PhoneFrame
            label={t("queueLabel")}
            className="absolute top-16 left-[46%] hidden w-[17rem] xl:block"
          >
            <OwnerQueueScreen />
          </PhoneFrame>
        </div>
      </div>
    </section>
  );
}
