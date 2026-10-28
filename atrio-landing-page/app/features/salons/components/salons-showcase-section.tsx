import { FileDown, Images, NotebookPen, Scissors } from "lucide-react";
import { useTranslations } from "next-intl";
import { PhoneFrame } from "@/app/components/ui/phone-frame";
import { OwnerDashboardScreen } from "@/app/components/screens/owner-dashboard-screen";
import { OwnerQueueScreen } from "@/app/components/screens/owner-queue-screen";
import { StatisticsScreen } from "@/app/components/screens/statistics-screen";
import { cn } from "@/app/lib/utils";

const rows = [
  { key: "queue", Screen: OwnerQueueScreen },
  { key: "day", Screen: OwnerDashboardScreen },
  { key: "stats", Screen: StatisticsScreen },
] as const;

const extras = [
  { key: "team", Icon: Scissors },
  { key: "profile", Icon: Images },
  { key: "notes", Icon: NotebookPen },
  { key: "export", Icon: FileDown },
] as const;

export function SalonsShowcaseSection() {
  const t = useTranslations("salonsShowcase");

  return (
    <section aria-labelledby="showcase-heading" className="bg-folder">
      <div className="mx-auto max-w-7xl px-5 py-24 md:px-10 lg:py-32">
        <h2
          id="showcase-heading"
          className="headline max-w-[18ch] text-[clamp(2rem,4.6vw,3.5rem)] font-semibold"
        >
          {t("heading")}
        </h2>

        <div className="mt-16 flex flex-col gap-24 lg:gap-32">
          {rows.map(({ key, Screen }, index) => (
            <article key={key} className="grid items-center gap-12 lg:grid-cols-2 lg:gap-20">
              <div className={cn(index % 2 === 1 && "lg:order-2")}>
                <h3 className="headline text-[clamp(1.6rem,3vw,2.25rem)] font-semibold">
                  {t(`rows.${key}.title`)}
                </h3>
                <p className="text-ink-soft mt-4 max-w-md text-lg leading-relaxed">
                  {t(`rows.${key}.body`)}
                </p>
                <ul className="mt-6 flex flex-wrap gap-2">
                  {t(`rows.${key}.points`)
                    .split("|")
                    .map((point) => (
                      <li
                        key={point}
                        className="bg-card text-ink-soft rounded-full px-3.5 py-1.5 text-sm font-medium"
                      >
                        {point}
                      </li>
                    ))}
                </ul>
              </div>
              <div className="bg-desk flex justify-center rounded-[var(--radius-card)] py-12">
                <PhoneFrame label={t(`rows.${key}.screenLabel`)}>
                  <Screen />
                </PhoneFrame>
              </div>
            </article>
          ))}
        </div>

        <h3 className="headline mt-28 text-[clamp(1.5rem,2.6vw,2rem)] font-semibold">
          {t("extrasHeading")}
        </h3>
        <ul className="mt-10 grid gap-x-10 gap-y-10 sm:grid-cols-2 lg:grid-cols-4">
          {extras.map(({ key, Icon }) => (
            <li key={key}>
              <span className="bg-teal-mist text-teal flex size-11 items-center justify-center rounded-[var(--radius-card)]">
                <Icon aria-hidden="true" className="size-5" />
              </span>
              <p className="mt-4 text-lg font-semibold tracking-[-0.01em]">
                {t(`extras.${key}.title`)}
              </p>
              <p className="text-ink-soft mt-1 leading-relaxed">{t(`extras.${key}.body`)}</p>
            </li>
          ))}
        </ul>
      </div>
    </section>
  );
}
