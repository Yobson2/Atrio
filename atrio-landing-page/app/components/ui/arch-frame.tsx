import { cn } from "@/app/lib/utils";

interface ArchFrameProps {
  children: React.ReactNode;
  className?: string;
  tone?: "teal" | "night";
}

/**
 * The Portal A archway from Atrio's mark, scaled up as a stage for the
 * product. The gold oculus sits where it does in the logo.
 */
export function ArchFrame({ children, className, tone = "teal" }: ArchFrameProps) {
  return (
    <div className={cn("relative isolate flex justify-center", className)}>
      <div
        aria-hidden="true"
        className={cn(
          "arch absolute inset-x-0 top-0 bottom-10 -z-10",
          tone === "teal"
            ? "bg-[linear-gradient(160deg,var(--color-teal)_0%,var(--color-teal-bright)_55%,var(--color-teal-deep)_100%)]"
            : "bg-[linear-gradient(160deg,var(--color-teal-deep),var(--color-teal-night))]"
        )}
      >
        <span className="bg-gold absolute top-[9%] left-1/2 size-5 -translate-x-1/2 rounded-full sm:size-6" />
      </div>
      <div className="pt-[22%]">{children}</div>
    </div>
  );
}
