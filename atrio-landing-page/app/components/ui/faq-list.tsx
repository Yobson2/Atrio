"use client";

import { useId, useState } from "react";
import { Plus } from "lucide-react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { easeOutQuint } from "@/app/lib/animations";
import { cn } from "@/app/lib/utils";

export interface FaqEntry {
  question: string;
  answer: string;
}

interface FaqListProps {
  items: FaqEntry[];
}

/** Accordion separated by tonal rows and spacing, not divider lines. */
export function FaqList({ items }: FaqListProps) {
  const [openIndex, setOpenIndex] = useState<number | null>(0);
  const reduceMotion = useReducedMotion();
  const baseId = useId();

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{
          // Static, first-party strings; escape "<" so nothing can close the tag.
          __html: JSON.stringify({
            "@context": "https://schema.org",
            "@type": "FAQPage",
            mainEntity: items.map((item) => ({
              "@type": "Question",
              name: item.question,
              acceptedAnswer: { "@type": "Answer", text: item.answer },
            })),
          }).replace(/</g, "\\u003c"),
        }}
      />
      <ul className="flex flex-col gap-2">
        {items.map((item, index) => {
          const isOpen = openIndex === index;
          const panelId = `${baseId}-panel-${index}`;
          const buttonId = `${baseId}-button-${index}`;

          return (
            <li
              key={item.question}
              className={cn(
                "rounded-[var(--radius-card)] transition-colors duration-300",
                isOpen ? "bg-card shadow-ambient" : "bg-desk hover:bg-card"
              )}
            >
              <h3>
                <button
                  id={buttonId}
                  type="button"
                  onClick={() => setOpenIndex(isOpen ? null : index)}
                  aria-expanded={isOpen}
                  aria-controls={panelId}
                  className="flex min-h-16 w-full items-center justify-between gap-6 px-6 py-4 text-left text-[1.05rem] font-semibold tracking-[-0.01em]"
                >
                  {item.question}
                  <Plus
                    aria-hidden="true"
                    className={cn(
                      "text-teal size-5 shrink-0 transition-transform duration-300",
                      isOpen && "rotate-45"
                    )}
                  />
                </button>
              </h3>
              <AnimatePresence initial={false}>
                {isOpen && (
                  <motion.div
                    id={panelId}
                    role="region"
                    aria-labelledby={buttonId}
                    initial={reduceMotion ? false : { height: 0, opacity: 0 }}
                    animate={{ height: "auto", opacity: 1 }}
                    exit={reduceMotion ? { opacity: 0 } : { height: 0, opacity: 0 }}
                    transition={{ duration: 0.35, ease: easeOutQuint }}
                    className="overflow-hidden"
                  >
                    <p className="text-ink-soft max-w-[62ch] px-6 pb-6 leading-relaxed">
                      {item.answer}
                    </p>
                  </motion.div>
                )}
              </AnimatePresence>
            </li>
          );
        })}
      </ul>
    </>
  );
}
