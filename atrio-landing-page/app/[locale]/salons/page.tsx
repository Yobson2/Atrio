import { getTranslations, setRequestLocale } from "next-intl/server";
import { DownloadSection } from "@/app/components/sections/download-section";
import { FaqSection } from "@/app/components/sections/faq-section";
import { SalonsHeroSection } from "@/app/features/salons/components/salons-hero-section";
import { SalonsShowcaseSection } from "@/app/features/salons/components/salons-showcase-section";
import { SalonsStepsSection } from "@/app/features/salons/components/salons-steps-section";
import { siteConfig } from "@/app/lib/constants";
import { constructMetadata } from "@/app/lib/metadata";

const faqKeys = [
  "walkInsAndBookings",
  "severalBarbers",
  "offline",
  "clientsNeedApp",
  "languages",
] as const;

type Props = {
  params: Promise<{ locale: string }>;
};

export async function generateMetadata({ params }: Props) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "salonsHero" });

  return constructMetadata({
    title: t("metaTitle"),
    description: t("metaDescription"),
    alternates: {
      canonical: `${siteConfig.url}/${locale}/salons`,
    },
  });
}

export default async function SalonsPage({ params }: Props) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations({ locale, namespace: "salonsDownload" });

  return (
    <main id="main">
      <SalonsHeroSection />
      <SalonsShowcaseSection />
      <SalonsStepsSection />
      <FaqSection namespace="salonsFaq" keys={faqKeys} />
      <DownloadSection heading={t("heading")} body={t("body")} />
    </main>
  );
}
