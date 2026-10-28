"use client";

import { useTranslations } from "next-intl";

interface ErrorPageProps {
  error: Error & { digest?: string };
  reset: () => void;
}

export default function ErrorPage({ reset }: ErrorPageProps) {
  const t = useTranslations("errors");

  return (
    <main
      id="main"
      className="mx-auto flex min-h-[65vh] max-w-xl flex-col items-start justify-center px-5 py-24"
    >
      <h1 className="headline text-4xl font-semibold">{t("genericTitle")}</h1>
      <p className="text-ink-soft mt-4 text-lg leading-relaxed">{t("genericDescription")}</p>
      <button
        type="button"
        onClick={reset}
        className="cta-gradient shadow-ambient hover:shadow-lift mt-10 inline-flex min-h-12 items-center rounded-[var(--radius-card)] px-6 font-semibold text-white transition hover:-translate-y-0.5"
      >
        {t("genericCta")}
      </button>
    </main>
  );
}
