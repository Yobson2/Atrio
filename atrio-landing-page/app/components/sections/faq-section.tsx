import { useTranslations } from "next-intl";
import { FaqList } from "@/app/components/ui/faq-list";

interface FaqSectionProps {
  /** Message namespace holding `heading`, `intro` and `items.<key>.{question,answer}`. */
  namespace: "faq" | "salonsFaq";
  keys: readonly string[];
}

export function FaqSection({ namespace, keys }: FaqSectionProps) {
  const t = useTranslations(namespace);

  const items = keys.map((key) => ({
    question: t(`items.${key}.question`),
    answer: t(`items.${key}.answer`),
  }));

  return (
    <section id="faq" aria-labelledby={`${namespace}-heading`} className="bg-folder">
      <div className="mx-auto grid max-w-7xl gap-12 px-5 py-24 md:px-10 lg:grid-cols-[0.8fr_1.2fr] lg:gap-20 lg:py-32">
        <div>
          <h2
            id={`${namespace}-heading`}
            className="headline max-w-[14ch] text-[clamp(2rem,4.6vw,3.5rem)] font-semibold"
          >
            {t("heading")}
          </h2>
          <p className="text-ink-soft mt-5 max-w-sm text-lg leading-relaxed">{t("intro")}</p>
        </div>
        <FaqList items={items} />
      </div>
    </section>
  );
}
