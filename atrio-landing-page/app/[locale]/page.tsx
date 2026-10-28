import { getTranslations, setRequestLocale } from "next-intl/server";
import { DownloadSection } from "@/app/components/sections/download-section";
import { FaqSection } from "@/app/components/sections/faq-section";
import { FeaturesSection } from "@/app/features/home/components/features-section";
import { HeroSection } from "@/app/features/home/components/hero-section";
import { HowItWorksSection } from "@/app/features/home/components/how-it-works-section";
import { ProblemSection } from "@/app/features/home/components/problem-section";
import { SalonsTeaserSection } from "@/app/features/home/components/salons-teaser-section";

const faqKeys = [
  "liveQueue",
  "chooseBarber",
  "walkIn",
  "manageBooking",
  "salonJoin",
  "languages",
] as const;

type Props = {
  params: Promise<{ locale: string }>;
};

export default async function HomePage({ params }: Props) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations({ locale, namespace: "download" });

  return (
    <main id="main">
      <HeroSection />
      <ProblemSection />
      <HowItWorksSection />
      <SalonsTeaserSection />
      <FeaturesSection />
      <FaqSection namespace="faq" keys={faqKeys} />
      <DownloadSection heading={t("heading")} body={t("body")} />
    </main>
  );
}
