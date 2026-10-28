import { useTranslations } from "next-intl";
import { Link } from "@/app/i18n/navigation";
import { Logo } from "@/app/components/ui/logo";
import { siteConfig } from "@/app/lib/constants";
import { LanguageSwitcher } from "./language-switcher";

export function Footer() {
  const t = useTranslations("footer");
  const tNav = useTranslations("nav");

  const columns = [
    {
      title: t("product"),
      links: [
        { href: "/#how-it-works", label: tNav("howItWorks") },
        { href: "/#download", label: tNav("download") },
        { href: "/#faq", label: tNav("faq") },
      ],
    },
    {
      title: t("salons"),
      links: [
        { href: "/salons", label: tNav("forSalons") },
        { href: "/salons#get-started", label: t("getStarted") },
      ],
    },
    {
      title: t("legal"),
      links: [{ href: "/legal", label: t("privacy") }],
    },
  ];

  return (
    <footer className="on-dark bg-teal-night text-desk">
      <div className="mx-auto grid max-w-7xl gap-12 px-5 pt-20 pb-10 md:px-10 lg:grid-cols-[1.4fr_repeat(3,1fr)]">
        <div>
          <Logo tone="ivory" />
          <p className="text-desk/75 mt-5 max-w-xs leading-relaxed">{t("tagline")}</p>
          {siteConfig.email && (
            <a
              href={`mailto:${siteConfig.email}`}
              className="text-gold mt-5 inline-block font-medium underline-offset-4 hover:underline"
            >
              {siteConfig.email}
            </a>
          )}
        </div>

        {columns.map((column) => (
          <nav key={column.title} aria-label={column.title}>
            <p className="font-semibold">{column.title}</p>
            <ul className="mt-4 flex flex-col gap-1">
              {column.links.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    className="text-desk/75 hover:text-desk inline-flex min-h-10 items-center transition-colors"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </nav>
        ))}
      </div>

      <div className="text-desk/60 mx-auto flex max-w-7xl flex-col-reverse items-start justify-between gap-6 px-5 pt-6 pb-10 text-sm sm:flex-row sm:items-center md:px-10">
        <p>{t("copyright", { year: new Date().getFullYear(), name: siteConfig.name })}</p>
        <LanguageSwitcher tone="dark" />
      </div>
    </footer>
  );
}
