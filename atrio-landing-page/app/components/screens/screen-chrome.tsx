import { cn } from "@/app/lib/utils";

/** App bar shared by the screen recreations. */
export function ScreenHeader({ title, trailing }: { title: string; trailing?: React.ReactNode }) {
  return (
    <div className="flex items-center justify-between px-4 pb-3">
      <span className="text-teal text-[15px] font-semibold tracking-[-0.02em]">{title}</span>
      {trailing}
    </div>
  );
}

export function LivePill({ label }: { label: string }) {
  return (
    <span className="bg-gold-mist text-gold-ink flex items-center gap-1 rounded-full px-2 py-0.5 text-[9px] font-semibold">
      <span className="bg-gold size-1.5 animate-pulse rounded-full motion-reduce:animate-none" />
      {label}
    </span>
  );
}

type Tone = "teal" | "gold" | "clay" | "neutral";

const toneStyles: Record<Tone, string> = {
  teal: "bg-teal-mist text-teal",
  gold: "bg-gold-mist text-gold-ink",
  clay: "bg-clay-mist text-clay",
  neutral: "bg-chip text-ink-soft",
};

export function StatusChip({ tone, children }: { tone: Tone; children: React.ReactNode }) {
  return (
    <span className={cn("rounded-full px-2 py-0.5 text-[9px] font-semibold", toneStyles[tone])}>
      {children}
    </span>
  );
}

/** Floating glass tab bar, as in the app's navigation rail. */
export function TabBar({ items, active }: { items: string[]; active: number }) {
  return (
    <div className="mt-auto px-3 pb-3">
      <div className="bg-card/80 shadow-ambient flex justify-between rounded-[var(--radius-card)] p-1 backdrop-blur-xl">
        {items.map((item, index) => (
          <span
            key={item}
            className={cn(
              "flex-1 rounded-lg py-1.5 text-center text-[9px] font-medium",
              index === active ? "bg-teal-mist text-teal" : "text-ink-mute"
            )}
          >
            {item}
          </span>
        ))}
      </div>
    </div>
  );
}
