import type { Metadata } from "next";
import { siteConfig } from "./constants";

export function constructMetadata(overrides?: Partial<Metadata>): Metadata {
  const title = overrides?.title ?? siteConfig.name;
  const description = overrides?.description ?? siteConfig.name;
  const plainTitle = typeof title === "string" ? title : siteConfig.name;
  const plainDescription = typeof description === "string" ? description : siteConfig.name;

  return {
    title: overrides?.title ?? {
      default: siteConfig.name,
      template: `%s | ${siteConfig.name}`,
    },
    description,
    metadataBase: new URL(siteConfig.url),
    openGraph: {
      type: "website",
      url: siteConfig.url,
      title: plainTitle,
      description: plainDescription,
      siteName: siteConfig.name,
      ...overrides?.openGraph,
    },
    twitter: {
      card: "summary_large_image",
      title: plainTitle,
      description: plainDescription,
      ...overrides?.twitter,
    },
    appleWebApp: {
      title: siteConfig.name,
      capable: true,
      statusBarStyle: "default",
    },
    ...overrides,
  };
}
