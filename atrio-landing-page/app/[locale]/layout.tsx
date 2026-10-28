import { NextIntlClientProvider, hasLocale } from "next-intl";
import { setRequestLocale, getTranslations } from "next-intl/server";
import { notFound } from "next/navigation";
import { routing } from "@/app/i18n/routing";
import { Navbar } from "@/app/components/layout/navbar";
import { Footer } from "@/app/components/layout/footer";
import { JsonLd } from "@/app/components/seo/json-ld";
import { constructMetadata } from "@/app/lib/metadata";
import { siteConfig } from "@/app/lib/constants";

type Props = {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
};

export function generateStaticParams() {
  return routing.locales.map((locale) => ({ locale }));
}

export async function generateMetadata({ params }: { params: Promise<{ locale: string }> }) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "metadata" });

  return constructMetadata({
    title: { default: t("title"), template: `%s | ${siteConfig.name}` },
    description: t("description"),
    openGraph: {
      locale: t("ogLocale"),
    },
    alternates: {
      canonical: `${siteConfig.url}/${locale}`,
      languages: Object.fromEntries(routing.locales.map((l) => [l, `${siteConfig.url}/${l}`])),
    },
  });
}

export default async function LocaleLayout({ children, params }: Props) {
  const { locale } = await params;

  if (!hasLocale(routing.locales, locale)) {
    notFound();
  }

  setRequestLocale(locale);

  const t = await getTranslations({ locale, namespace: "nav" });

  return (
    <NextIntlClientProvider>
      <JsonLd locale={locale} />
      <a
        href="#main"
        className="focus:bg-teal sr-only focus:not-sr-only focus:fixed focus:top-4 focus:left-4 focus:z-[200] focus:rounded-[var(--radius-card)] focus:px-4 focus:py-3 focus:font-semibold focus:text-white"
      >
        {t("skipToContent")}
      </a>
      <Navbar />
      {children}
      <Footer />
    </NextIntlClientProvider>
  );
}
