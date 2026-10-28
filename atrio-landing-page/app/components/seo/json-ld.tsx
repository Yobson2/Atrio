import { getTranslations } from "next-intl/server";
import { siteConfig } from "@/app/lib/constants";

interface JsonLdProps {
  locale: string;
}

export async function JsonLd({ locale }: JsonLdProps) {
  const t = await getTranslations({ locale, namespace: "metadata" });

  const structuredData = [
    {
      "@context": "https://schema.org",
      "@type": "Organization",
      name: siteConfig.name,
      url: siteConfig.url,
      logo: `${siteConfig.url}/icon.svg`,
      description: t("description"),
      ...(siteConfig.email ? { email: siteConfig.email } : {}),
    },
    {
      "@context": "https://schema.org",
      "@type": "MobileApplication",
      name: siteConfig.name,
      operatingSystem: "iOS, Android",
      applicationCategory: "LifestyleApplication",
      description: t("description"),
      inLanguage: ["fr", "en"],
    },
  ];

  return (
    <script
      type="application/ld+json"
      // Static, first-party strings; escape "<" so nothing can close the tag.
      dangerouslySetInnerHTML={{ __html: JSON.stringify(structuredData).replace(/</g, "\\u003c") }}
    />
  );
}
