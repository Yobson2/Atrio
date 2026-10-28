import { useTranslations } from "next-intl";
import { ArchFrame } from "@/app/components/ui/arch-frame";
import { ButtonLink } from "@/app/components/ui/button-link";
import { PhoneFrame } from "@/app/components/ui/phone-frame";
import { OwnerQueueScreen } from "@/app/components/screens/owner-queue-screen";

export function SalonsHeroSection() {
  const t = useTranslations("salonsHero");

  return (
    <section className="mx-auto grid max-w-7xl items-center gap-14 px-5 pt-10 pb-20 md:px-10 lg:grid-cols-[1.1fr_0.9fr] lg:gap-10 lg:pt-14 lg:pb-28">
      <div>
        <h1 className="display max-w-[14ch] text-[clamp(2.6rem,6.4vw,5rem)] font-semibold">
          {t("heading")}
        </h1>
        <p className="text-ink-soft mt-7 max-w-[36rem] text-lg leading-relaxed md:text-xl">
          {t("subheading")}
        </p>
        <div className="mt-9 flex flex-wrap gap-3">
          <ButtonLink href="#get-started">{t("ctaPrimary")}</ButtonLink>
          <ButtonLink href="#download" variant="secondary">
            {t("ctaSecondary")}
          </ButtonLink>
        </div>
      </div>

      <figure className="mx-auto w-full max-w-[26rem]">
        <ArchFrame tone="night">
          <PhoneFrame label={t("screenLabel")}>
            <OwnerQueueScreen />
          </PhoneFrame>
        </ArchFrame>
        <figcaption className="text-ink-mute mt-5 text-center text-sm">
          {t("screenCaption")}
        </figcaption>
      </figure>
    </section>
  );
}
