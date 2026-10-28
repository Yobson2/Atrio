import { useId } from "react";
import { cn } from "@/app/lib/utils";

interface LogoMarkProps {
  className?: string;
}

/** Portal A — archway + crossbar with the kente-gold oculus. */
export function LogoMark({ className }: LogoMarkProps) {
  const gradientId = useId();

  return (
    <svg viewBox="0 0 120 120" className={className} aria-hidden="true" focusable="false">
      <defs>
        <linearGradient id={gradientId} x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#00685F" />
          <stop offset="1" stopColor="#008378" />
        </linearGradient>
      </defs>
      <rect width="120" height="120" rx="27" fill={`url(#${gradientId})`} />
      <g transform="translate(16.8 13.2) scale(0.72)">
        <path
          d="M32 100V58a28 28 0 0 1 56 0v42M32 80h56"
          fill="none"
          stroke="#fff"
          strokeWidth="16"
          strokeLinecap="round"
        />
        <circle cx="60" cy="54" r="7" fill="#F0C060" />
      </g>
    </svg>
  );
}

interface LogoProps {
  className?: string;
  tone?: "ink" | "ivory";
}

export function Logo({ className, tone = "ink" }: LogoProps) {
  return (
    <span className={cn("flex items-center gap-2.5", className)}>
      <LogoMark className="size-8" />
      <span
        className={cn(
          "text-xl font-semibold tracking-[-0.03em]",
          tone === "ink" ? "text-ink" : "text-desk"
        )}
      >
        Atrio
      </span>
    </span>
  );
}
