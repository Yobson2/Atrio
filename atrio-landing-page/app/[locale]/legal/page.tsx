import { setRequestLocale, getTranslations } from "next-intl/server";
import { constructMetadata } from "@/app/lib/metadata";
import { siteConfig } from "@/app/lib/constants";

const sectionKeys = ["dataWeCollect", "purpose", "storage", "yourRights", "cookies"] as const;

type Props = {
  params: Promise<{ locale: string }>;
};

export async function generateMetadata({ params }: Props) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "legal" });

  return constructMetadata({
    title: t("title"),
    description: t("metaDescription", { name: siteConfig.name }),
  });
}

export default async function LegalPage({ params }: Props) {
  const { locale } = await params;
  setRequestLocale(locale);

  const t = await getTranslations({ locale, namespace: "legal" });

  return (
    <main id="main" className="mx-auto max-w-3xl px-5 py-20 md:px-10 lg:py-28">
      <h1 className="display text-[clamp(2.5rem,6vw,4rem)] font-semibold">{t("title")}</h1>
      <p className="text-ink-mute mt-5">{t("lastUpdated")}</p>
      <p className="text-ink-soft mt-8 text-lg leading-relaxed">
        {t("intro", { name: siteConfig.name })}
      </p>

      <div className="mt-14 flex flex-col gap-3">
        {sectionKeys.map((key, index) => (
          <section key={key} className="bg-folder rounded-[var(--radius-card)] p-7">
            <h2 className="text-xl font-semibold tracking-[-0.01em]">
              {index + 1}. {t(`${key}.title`)}
            </h2>
            <p className="text-ink-soft mt-3 max-w-[65ch] leading-relaxed">{t(`${key}.content`)}</p>
          </section>
        ))}
      </div>

      <p className="text-ink-soft mt-10 leading-relaxed">
        {t("contact")}{" "}
        {siteConfig.email ? (
          <a
            href={`mailto:${siteConfig.email}`}
            className="text-teal font-medium underline underline-offset-4"
          >
            {siteConfig.email}
          </a>
        ) : (
          t("contactInApp")
        )}
      </p>
    </main>
  );
}
