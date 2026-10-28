import { cn } from "@/app/lib/utils";

interface PhoneFrameProps {
  children: React.ReactNode;
  /** Accessible description of what the screen shows. */
  label: string;
  className?: string;
}

/**
 * Device shell for coded app-screen recreations. The screen is exposed as a
 * single labelled image to assistive tech; its inner UI is decorative.
 */
export function PhoneFrame({ children, label, className }: PhoneFrameProps) {
  return (
    <div
      role="img"
      aria-label={label}
      className={cn(
        "bg-ink-soft shadow-device relative w-[min(19rem,78vw)] rounded-[var(--radius-device)] p-2",
        className
      )}
    >
      <div className="bg-desk relative aspect-[9/19.2] overflow-hidden rounded-[calc(var(--radius-device)-0.5rem)]">
        <div
          aria-hidden="true"
          className="bg-ink-soft absolute top-2 left-1/2 z-20 h-5 w-20 -translate-x-1/2 rounded-full"
        />
        <div aria-hidden="true" className="text-ink absolute inset-0 flex flex-col pt-9">
          {children}
        </div>
      </div>
    </div>
  );
}
