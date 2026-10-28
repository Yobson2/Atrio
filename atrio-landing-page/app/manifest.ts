import type { MetadataRoute } from "next";
import { siteConfig } from "@/app/lib/constants";

export default function manifest(): MetadataRoute.Manifest {
  return {
    name: siteConfig.name,
    short_name: siteConfig.name,
    start_url: "/",
    display: "standalone",
    background_color: "#f8f7f4",
    theme_color: siteConfig.themeColor,
    icons: [
      {
        src: "/icon.svg",
        sizes: "any",
        type: "image/svg+xml",
      },
      {
        src: "/assets/app-icon.png",
        sizes: "1024x1024",
        type: "image/png",
      },
    ],
  };
}
