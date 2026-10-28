import type { Transition } from "framer-motion";

/** Shared easing for the few orchestrated moments on the page. */
export const easeOutQuint = [0.22, 1, 0.36, 1] as const;

export const swapTransition: Transition = { duration: 0.45, ease: easeOutQuint };

/** Number/row swap used by the live queue ticket. */
export const tickVariants = {
  initial: { y: "60%", opacity: 0 },
  animate: { y: "0%", opacity: 1 },
  exit: { y: "-60%", opacity: 0 },
} as const;

/** Phone screen swap in the sticky "how it works" story. */
export const screenVariants = {
  initial: { opacity: 0, scale: 0.98 },
  animate: { opacity: 1, scale: 1 },
  exit: { opacity: 0, scale: 1.01 },
} as const;
