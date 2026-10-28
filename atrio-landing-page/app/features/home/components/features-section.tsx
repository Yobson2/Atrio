import { Bell, Gift, Heart, Languages, MessageCircle, Star } from "lucide-react";
import { useTranslations } from "next-intl";

const features = [
  { key: "favorites", Icon: Heart },
  { key: "reviews", Icon: Star },
  { key: "loyalty", Icon: Gift },
  { key: "messages", Icon: MessageCircle },
  { key: "notifications", Icon: Bell },
  { key: "language", Icon: Languages },
] as const;

export function FeaturesSection() {
  const t = useTranslations("features");

  return (
    <section
      aria-labelledby="features-heading"
      className="mx-auto max-w-7xl px-5 py-24 md:px-10 lg:py-32"
    >
      <div className="grid gap-14 lg:grid-cols-[0.8fr_1.2fr] lg:gap-20">
        <div>
          <h2
            id="features-heading"
            className="headline max-w-[14ch] text-[clamp(2rem,4.6vw,3.5rem)] font-semibold"
          >
            {t("heading")}
          </h2>
          <p className="text-ink-soft mt-5 max-w-sm text-lg leading-relaxed">{t("intro")}</p>
        </div>

        <ul className="grid gap-x-10 gap-y-10 sm:grid-cols-2">
          {features.map(({ key, Icon }) => (
            <li key={key} className="flex gap-4">
              <span className="bg-teal-mist text-teal flex size-11 shrink-0 items-center justify-center rounded-[var(--radius-card)]">
                <Icon aria-hidden="true" className="size-5" />
              </span>
              <span>
                <span className="block text-lg font-semibold tracking-[-0.01em]">
                  {t(`items.${key}.title`)}
                </span>
                <span className="text-ink-soft mt-1 block leading-relaxed">
                  {t(`items.${key}.body`)}
                </span>
              </span>
            </li>
          ))}
        </ul>
      </div>
    </section>
  );
}
