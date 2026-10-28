import { useTranslations } from "next-intl";
import { ButtonLink } from "@/app/components/ui/button-link";

export default function NotFound() {
  const t = useTranslations("errors");

  return (
    <main
      id="main"
      className="mx-auto flex min-h-[65vh] max-w-xl flex-col items-start justify-center px-5 py-24"
    >
      <p className="tabular text-teal text-6xl font-semibold tracking-[-0.04em]">404</p>
      <h1 className="headline mt-6 text-4xl font-semibold">{t("notFoundTitle")}</h1>
      <p className="text-ink-soft mt-4 text-lg leading-relaxed">{t("notFoundDescription")}</p>
      <ButtonLink href="/" className="mt-10">
        {t("notFoundCta")}
      </ButtonLink>
    </main>
  );
}
