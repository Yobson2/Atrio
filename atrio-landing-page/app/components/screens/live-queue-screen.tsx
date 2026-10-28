"use client";

import { useEffect, useState } from "react";
import { Clock, Scissors } from "lucide-react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { useTranslations } from "next-intl";
import { swapTransition, tickVariants } from "@/app/lib/animations";
import { cn } from "@/app/lib/utils";
import { queueAhead, sampleSalon } from "./sample-data";
import { LivePill, ScreenHeader, TabBar } from "./screen-chrome";

const MINUTES_PER_CLIENT = 3;
const TICK_MS = 3200;
const PEOPLE_BEHIND = 9;

interface LiveQueueScreenProps {
  /** Advance the queue on a timer — the hero's single orchestrated motion. */
  live?: boolean;
}

/** Recreation of the client "Queue status" screen (live_queue_status). */
export function LiveQueueScreen({ live = false }: LiveQueueScreenProps) {
  const t = useTranslations("screens");
  const reduceMotion = useReducedMotion();
  const [served, setServed] = useState(0);

  const isTicking = live && !reduceMotion;
  const maxServed = queueAhead.length - 1;

  useEffect(() => {
    if (!isTicking) return;
    const timer = setInterval(() => {
      setServed((prev) => (prev >= maxServed ? 0 : prev + 1));
    }, TICK_MS);
    return () => clearInterval(timer);
  }, [isTicking, maxServed]);

  const remaining = queueAhead.slice(served);
  const position = remaining.length + 1;
  const wait = (position - 1) * MINUTES_PER_CLIENT;
  const isNext = position === 2;

  return (
    <>
      <ScreenHeader title={t("queue.title")} trailing={<LivePill label={t("live")} />} />

      <div className="grid grid-cols-3 gap-1.5 px-4">
        {[
          { label: t("queue.waiting"), value: remaining.length + PEOPLE_BEHIND },
          { label: t("queue.serving"), value: 3 },
          { label: t("queue.avgWait"), value: "15m" },
        ].map((stat) => (
          <div key={stat.label} className="bg-folder rounded-lg px-2 py-2 text-center">
            <p className="text-ink-mute text-[8px]">{stat.label}</p>
            <p className="tabular text-teal text-[15px] font-bold">{stat.value}</p>
          </div>
        ))}
      </div>

      <div className="cta-gradient shadow-ambient mx-4 mt-3 rounded-[var(--radius-card)] p-4 text-white">
        <p className="text-[10px] text-white/80">{t("queue.yourPosition")}</p>
        <div className="mt-1 flex items-end gap-1.5">
          <span className="relative inline-flex h-[52px] overflow-hidden">
            <AnimatePresence mode="popLayout" initial={false}>
              <motion.span
                key={position}
                variants={tickVariants}
                initial="initial"
                animate="animate"
                exit="exit"
                transition={swapTransition}
                className="tabular block text-[48px] leading-[52px] font-extrabold tracking-[-0.04em]"
              >
                #{position}
              </motion.span>
            </AnimatePresence>
          </span>
          <span className="pb-1.5 text-[11px] text-white/80">{t("queue.inLine")}</span>
        </div>
        <p
          className={cn(
            "mt-2 inline-flex items-center gap-1.5 rounded-lg px-2.5 py-1.5 text-[10px] font-semibold transition-colors duration-500",
            isNext ? "bg-gold text-ink" : "bg-white/15"
          )}
        >
          <Clock className="size-3" />
          {isNext ? t("queue.youreNext") : t("queue.estimatedWait", { minutes: wait })}
        </p>
        <div className="text-teal mt-3 rounded-lg bg-white py-2 text-center text-[11px] font-semibold">
          {t("queue.imHere")}
        </div>
        <div className="mt-1.5 rounded-lg bg-white/10 py-1.5 text-center text-[10px] text-white/90">
          {t("queue.leave")}
        </div>
      </div>

      <p className="mt-3 px-4 text-[11px] font-semibold">{t("queue.details")}</p>
      <ul className="mt-1.5 flex flex-col gap-1.5 px-4">
        <AnimatePresence initial={false} mode="popLayout">
          {remaining.slice(0, 3).map((client, index) => (
            <motion.li
              key={client.name}
              layout={!reduceMotion}
              initial={{ opacity: 0, y: 12 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, x: -24, transition: { duration: 0.2 } }}
              transition={swapTransition}
              className={cn(
                "flex items-center gap-2 rounded-lg px-2.5 py-2",
                index === 0 ? "bg-card shadow-ambient" : "bg-folder"
              )}
            >
              <span
                className={cn(
                  "flex size-6 items-center justify-center rounded-full text-[9px] font-bold",
                  index === 0 ? "bg-teal-mist text-teal" : "bg-chip text-ink-mute"
                )}
              >
                {index === 0 ? <Scissors className="size-3" /> : `#${index + 1}`}
              </span>
              <span className="flex-1">
                <span className="block text-[10px] font-semibold">{client.name}</span>
                <span className="text-ink-mute block text-[8px]">
                  {index === 0
                    ? t("queue.inChair")
                    : t("queue.inLineWait", { minutes: index * MINUTES_PER_CLIENT })}
                </span>
              </span>
              <span className="text-ink-soft text-[9px] font-medium">
                {t(`services.${client.service}`)}
              </span>
            </motion.li>
          ))}
        </AnimatePresence>
      </ul>

      <div className="bg-folder mx-4 mt-2 flex items-center gap-2 rounded-lg px-2.5 py-2">
        <span className="size-6 rounded-md bg-[linear-gradient(135deg,var(--color-teal-deep),var(--color-teal))]" />
        <span className="flex-1">
          <span className="block text-[10px] font-semibold">{sampleSalon.name}</span>
          <span className="text-ink-mute block text-[8px]">{sampleSalon.district}</span>
        </span>
        <span className="text-gold-ink text-[9px] font-semibold">★ {sampleSalon.rating}</span>
      </div>

      <TabBar
        items={[t("tabs.discover"), t("tabs.bookings"), t("tabs.queue"), t("tabs.profile")]}
        active={2}
      />
    </>
  );
}
