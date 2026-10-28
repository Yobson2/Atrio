import { Plus, Scissors } from "lucide-react";
import { useTranslations } from "next-intl";
import { queueAhead } from "./sample-data";
import { LivePill, ScreenHeader, TabBar } from "./screen-chrome";

/** Recreation of the owner "Master queue" screen (queue_management). */
export function OwnerQueueScreen() {
  const t = useTranslations("screens");
  const [serving, ...upNext] = queueAhead;

  return (
    <>
      <ScreenHeader title={t("ownerQueue.title")} trailing={<LivePill label={t("live")} />} />

      <div className="bg-card shadow-ambient mx-4 rounded-[var(--radius-card)] p-3">
        <p className="text-ink-mute text-[8px]">{t("ownerQueue.serving")}</p>
        <div className="mt-1 flex items-center gap-2">
          <span className="bg-teal-mist text-teal flex size-8 items-center justify-center rounded-full">
            <Scissors className="size-4" />
          </span>
          <span className="flex-1">
            <span className="block text-[12px] font-semibold">{serving.name}</span>
            <span className="text-ink-mute block text-[9px]">
              {t(`services.${serving.service}`)} · Serge
            </span>
          </span>
          <span className="tabular text-teal text-[11px] font-bold">12:40</span>
        </div>
      </div>

      <div className="mt-2 flex items-center justify-between px-4">
        <p className="text-[11px] font-semibold">{t("ownerQueue.upNext")}</p>
        <span className="text-ink-mute text-[9px]">
          {t("ownerQueue.count", { count: upNext.length + 6 })}
        </span>
      </div>
      <ul className="mt-1.5 flex flex-col gap-1.5 px-4">
        {upNext.map((client, index) => (
          <li
            key={client.name}
            className="bg-folder flex items-center gap-2 rounded-lg px-2.5 py-2"
          >
            <span className="tabular bg-chip text-ink-soft flex size-6 items-center justify-center rounded-full text-[9px] font-bold">
              {index + 1}
            </span>
            <span className="flex-1">
              <span className="block text-[10px] font-semibold">{client.name}</span>
              <span className="text-ink-mute block text-[8px]">
                {t(`services.${client.service}`)}
              </span>
            </span>
            <span className="bg-chip text-ink-soft rounded-full px-2 py-0.5 text-[8px]">
              {t("ownerQueue.skip")}
            </span>
          </li>
        ))}
      </ul>

      <div className="mt-2 grid grid-cols-2 gap-1.5 px-4">
        <span className="cta-gradient rounded-lg py-2 text-center text-[10px] font-semibold text-white">
          {t("ownerQueue.advance")}
        </span>
        <span className="bg-chip text-teal flex items-center justify-center gap-1 rounded-lg py-2 text-[10px] font-semibold">
          <Plus className="size-3" />
          {t("ownerQueue.manual")}
        </span>
      </div>

      <div className="bg-teal-deep mx-4 mt-2 grid grid-cols-2 gap-1.5 rounded-[var(--radius-card)] p-3 text-white">
        <span>
          <span className="block text-[8px] text-white/70">{t("ownerQueue.avgWait")}</span>
          <span className="tabular block text-[14px] font-bold">14 min</span>
        </span>
        <span>
          <span className="block text-[8px] text-white/70">{t("ownerQueue.revenue")}</span>
          <span className="tabular block text-[14px] font-bold">
            54 000 <span className="text-[8px]">FCFA</span>
          </span>
        </span>
      </div>

      <TabBar
        items={[t("tabs.dashboard"), t("tabs.queue"), t("tabs.stats"), t("tabs.salon")]}
        active={1}
      />
    </>
  );
}
