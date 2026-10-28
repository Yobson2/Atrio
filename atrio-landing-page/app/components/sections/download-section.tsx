import { useTranslations } from "next-intl";
import { StoreBadges } from "@/app/components/ui/store-badges";
import { hasStoreLinks } from "@/app/lib/constants";

interface DownloadSectionProps {
  heading: string;
  body: string;
}

/** Closing CTA framed by a wide Portal A archway. */
export function DownloadSection({ heading, body }: DownloadSectionProps) {
  const t = useTranslations("download");

  return (
    <section
      id="download"
      aria-labelledby="download-heading"
      className="px-5 py-24 md:px-10 lg:py-32"
    >
      <div className="on-dark arch-wide cta-gradient relative mx-auto max-w-5xl px-6 pt-28 pb-16 text-center text-white sm:px-12 sm:pt-36 sm:pb-20">
        <span
          aria-hidden="true"
          className="bg-gold absolute top-10 left-1/2 size-6 -translate-x-1/2 rounded-full sm:top-14"
        />
        <h2
          id="download-heading"
          className="headline mx-auto max-w-[18ch] text-[clamp(2rem,5vw,3.75rem)] font-semibold"
        >
          {heading}
        </h2>
        <p className="mx-auto mt-5 max-w-lg text-lg leading-relaxed text-white/85">{body}</p>
        <StoreBadges tone="dark" className="mt-10 justify-center" />
        {!hasStoreLinks && <p className="mt-6 text-sm text-white/75">{t("notYet")}</p>}
      </div>
    </section>
  );
}
