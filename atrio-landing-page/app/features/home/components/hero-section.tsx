import { useTranslations } from "next-intl";
import { ArchFrame } from "@/app/components/ui/arch-frame";
import { ButtonLink } from "@/app/components/ui/button-link";
import { PhoneFrame } from "@/app/components/ui/phone-frame";
import { StoreBadges } from "@/app/components/ui/store-badges";
import { LiveQueueScreen } from "@/app/components/screens/live-queue-screen";

export function HeroSection() {
  const t = useTranslations("hero");

  return (
    <section className="mx-auto grid max-w-7xl items-center gap-14 px-5 pt-10 pb-20 md:px-10 lg:grid-cols-[1.1fr_0.9fr] lg:gap-10 lg:pt-14 lg:pb-28">
      <div>
        <h1 className="display max-w-[12ch] text-[clamp(2.75rem,6.2vw,5rem)] font-semibold">
          {t("heading")}
        </h1>
        <p className="text-ink-soft mt-7 max-w-[36rem] text-lg leading-relaxed md:text-xl">
          {t("subheading")}
        </p>
        <StoreBadges className="mt-9" />
        <p className="text-ink-soft mt-8">
          {t("ownerPrompt")}{" "}
          <ButtonLink href="/salons" variant="quiet" className="text-teal min-h-0 px-0">
            {t("ownerLink")}
          </ButtonLink>
        </p>
      </div>

      <figure className="mx-auto w-full max-w-[26rem]">
        <ArchFrame>
          <PhoneFrame label={t("screenLabel")}>
            <LiveQueueScreen live />
          </PhoneFrame>
        </ArchFrame>
        <figcaption className="text-ink-mute mt-5 text-center text-sm">
          {t("screenCaption")}
        </figcaption>
      </figure>
    </section>
  );
}
