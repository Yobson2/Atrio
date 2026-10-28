import { useTranslations } from "next-intl";

const stepKeys = ["download", "role", "setup", "open"] as const;

/** Real onboarding sequence from the app: sign up → owner role → salon setup → open the queue. */
export function SalonsStepsSection() {
  const t = useTranslations("salonsSteps");

  return (
    <section
      id="get-started"
      aria-labelledby="steps-heading"
      className="mx-auto max-w-7xl px-5 py-24 md:px-10 lg:py-32"
    >
      <h2
        id="steps-heading"
        className="headline max-w-[16ch] text-[clamp(2rem,4.6vw,3.5rem)] font-semibold"
      >
        {t("heading")}
      </h2>
      <p className="text-ink-soft mt-5 max-w-xl text-lg leading-relaxed">{t("intro")}</p>

      <ol className="mt-16 grid gap-3 md:grid-cols-2 lg:grid-cols-4">
        {stepKeys.map((key, index) => (
          <li
            key={key}
            className={
              index === stepKeys.length - 1
                ? "cta-gradient shadow-ambient rounded-[var(--radius-card)] p-7 text-white"
                : "bg-folder rounded-[var(--radius-card)] p-7"
            }
          >
            <span
              aria-hidden="true"
              className={
                index === stepKeys.length - 1
                  ? "tabular text-gold text-5xl font-semibold tracking-[-0.04em]"
                  : "tabular text-teal text-5xl font-semibold tracking-[-0.04em]"
              }
            >
              {index + 1}
            </span>
            <p className="mt-8 text-lg font-semibold tracking-[-0.01em]">
              {t(`steps.${key}.title`)}
            </p>
            <p
              className={
                index === stepKeys.length - 1
                  ? "mt-2 leading-relaxed text-white/85"
                  : "text-ink-soft mt-2 leading-relaxed"
              }
            >
              {t(`steps.${key}.body`)}
            </p>
          </li>
        ))}
      </ol>
    </section>
  );
}
