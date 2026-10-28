"use client";

import { useEffect, useRef, useState } from "react";
import { AnimatePresence, motion, useInView, useReducedMotion } from "framer-motion";
import { useTranslations } from "next-intl";
import { PhoneFrame } from "@/app/components/ui/phone-frame";
import { BookingScreen } from "@/app/components/screens/booking-screen";
import { DiscoverScreen } from "@/app/components/screens/discover-screen";
import { LiveQueueScreen } from "@/app/components/screens/live-queue-screen";
import { screenVariants, swapTransition } from "@/app/lib/animations";
import { cn } from "@/app/lib/utils";

const steps = [
  { key: "discover", Screen: DiscoverScreen },
  { key: "book", Screen: BookingScreen },
  { key: "follow", Screen: LiveQueueScreen },
] as const;

type StepKey = (typeof steps)[number]["key"];

interface StepProps {
  index: number;
  stepKey: StepKey;
  isActive: boolean;
  onActive: (index: number) => void;
  children: React.ReactNode;
}

function Step({ index, stepKey, isActive, onActive, children }: StepProps) {
  const t = useTranslations("howItWorks");
  const ref = useRef<HTMLLIElement>(null);
  const inView = useInView(ref, { margin: "-45% 0px -45% 0px" });

  useEffect(() => {
    if (inView) onActive(index);
  }, [inView, index, onActive]);

  return (
    <li ref={ref} className="flex flex-col gap-8 lg:min-h-[78vh] lg:justify-center">
      <div className="max-w-md">
        <span
          aria-hidden="true"
          className={cn(
            "tabular flex size-11 items-center justify-center rounded-full text-lg font-semibold transition-colors duration-500",
            isActive ? "cta-gradient text-white" : "bg-folder text-teal"
          )}
        >
          {index + 1}
        </span>
        <h3 className="headline mt-6 text-[clamp(1.6rem,3vw,2.25rem)] font-semibold">
          {t(`steps.${stepKey}.title`)}
        </h3>
        <p className="text-ink-soft mt-4 text-lg leading-relaxed">{t(`steps.${stepKey}.body`)}</p>
      </div>
      {/* Mobile and tablet: each step carries its own screen. */}
      <div className="bg-folder flex justify-center rounded-[var(--radius-card)] px-4 pt-10 pb-10 lg:hidden">
        {children}
      </div>
    </li>
  );
}

export function HowItWorksSection() {
  const t = useTranslations("howItWorks");
  const reduceMotion = useReducedMotion();
  const [active, setActive] = useState(0);
  const activeStep = steps[active] ?? steps[0];
  const ActiveScreen = activeStep.Screen;

  return (
    <section
      id="how-it-works"
      aria-labelledby="how-heading"
      className="mx-auto max-w-7xl px-5 py-24 md:px-10 lg:py-32"
    >
      <h2
        id="how-heading"
        className="headline max-w-[18ch] text-[clamp(2rem,4.6vw,3.5rem)] font-semibold"
      >
        {t("heading")}
      </h2>
      <p className="text-ink-soft mt-5 max-w-xl text-lg leading-relaxed">{t("intro")}</p>

      <div className="mt-16 grid gap-16 lg:mt-8 lg:grid-cols-2 lg:gap-10">
        <ol className="flex flex-col gap-20 lg:gap-0">
          {steps.map(({ key, Screen }, index) => (
            <Step
              key={key}
              index={index}
              stepKey={key}
              isActive={active === index}
              onActive={setActive}
            >
              <PhoneFrame label={t(`steps.${key}.screenLabel`)}>
                <Screen />
              </PhoneFrame>
            </Step>
          ))}
        </ol>

        {/* Desktop: one sticky device whose screen follows the active step. */}
        <div className="hidden lg:block">
          <div className="bg-folder sticky top-[max(5.5rem,calc(50vh-22.5rem))] flex justify-center rounded-[var(--radius-card)] py-12">
            <PhoneFrame label={t(`steps.${activeStep.key}.screenLabel`)}>
              <AnimatePresence mode="wait" initial={false}>
                <motion.div
                  key={activeStep.key}
                  variants={reduceMotion ? undefined : screenVariants}
                  initial="initial"
                  animate="animate"
                  exit="exit"
                  transition={swapTransition}
                  className="flex min-h-0 flex-1 flex-col"
                >
                  <ActiveScreen />
                </motion.div>
              </AnimatePresence>
            </PhoneFrame>
          </div>
        </div>
      </div>
    </section>
  );
}
