import type { ComponentProps } from "react";
import { Link } from "@/app/i18n/navigation";
import { cn } from "@/app/lib/utils";

type Variant = "primary" | "secondary" | "quiet" | "ivory";

const variantStyles: Record<Variant, string> = {
  primary: "cta-gradient text-white shadow-ambient hover:-translate-y-0.5 hover:shadow-lift",
  secondary: "bg-chip text-teal hover:bg-recess",
  quiet: "text-ink underline-offset-4 hover:underline",
  ivory: "bg-desk text-teal-deep shadow-ambient hover:-translate-y-0.5 hover:shadow-lift",
};

type ButtonLinkProps = ComponentProps<typeof Link> & {
  variant?: Variant;
};

/** Link styled as a Griot button: 12px radius, lift on hover, no borders. */
export function ButtonLink({ variant = "primary", className, ...props }: ButtonLinkProps) {
  return (
    <Link
      className={cn(
        "inline-flex min-h-12 items-center justify-center gap-2 rounded-[var(--radius-card)] px-6 text-[0.95rem] font-semibold transition duration-200 ease-[var(--ease-out-quint)] active:translate-y-0",
        variantStyles[variant],
        className
      )}
      {...props}
    />
  );
}
