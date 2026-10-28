import { useTranslations } from "next-intl";

const pointKeys = ["unknownWait", "barberTaken", "salonMemory"] as const;

export function ProblemSection() {
  const t = useTranslations("problem");

  return (
    <section aria-labelledby="problem-heading" className="bg-folder">
      <div className="mx-auto max-w-7xl px-5 py-24 md:px-10 lg:py-32">
        <h2
          id="problem-heading"
          className="headline max-w-[20ch] text-[clamp(2rem,4.6vw,3.5rem)] font-semibold"
        >
          {t("heading")}
        </h2>
        <ul className="mt-14 grid gap-10 md:grid-cols-3 md:gap-12">
          {pointKeys.map((key) => (
            <li key={key}>
              <p className="text-lg font-semibold tracking-[-0.01em]">{t(`points.${key}.title`)}</p>
              <p className="text-ink-soft mt-2 max-w-[34ch] leading-relaxed">
                {t(`points.${key}.body`)}
              </p>
            </li>
          ))}
        </ul>
      </div>
    </section>
  );
}
