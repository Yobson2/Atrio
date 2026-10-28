# Atrio — Landing page

Public site for Atrio, the barber and salon app: clients find a salon, book or join the queue and follow their turn live; salon owners run their queue, bookings, team and services.

Built with **Next.js 16** (App Router, Turbopack), **React 19**, **TypeScript**, **Tailwind CSS 4**, **next-intl** (French by default, English) and **Framer Motion**.

## Pages

| Route              | Purpose                                                            |
| ------------------ | ------------------------------------------------------------------ |
| `/[locale]`        | Clients: hero, problem, how it works, salons teaser, FAQ, download |
| `/[locale]/salons` | Salon owners: queue, dashboard, statistics, onboarding, FAQ        |
| `/[locale]/legal`  | Website privacy notice                                             |

## Project structure

```
app/
├── components/
│   ├── layout/     # Navbar, mobile menu, footer, language switcher
│   ├── screens/    # Coded recreations of real app screens (+ sample-data.ts)
│   ├── sections/   # Sections shared by both pages (FAQ, download)
│   ├── seo/        # JSON-LD
│   └── ui/         # Logo, arch frame, phone frame, store badges, buttons, FAQ list
├── features/
│   ├── home/       # Home page sections
│   └── salons/     # "For salons" page sections
├── i18n/           # next-intl routing (fr default, en)
├── lib/            # siteConfig, animations, metadata, utils
└── globals.css     # Modern Griot design tokens
messages/           # fr.json, en.json — all copy lives here
```

## Before launch

Set these in `app/lib/constants.ts` (or the env):

- `stores.appStore` / `stores.googlePlay` — store badges show "coming soon" until set.
- `email` — public support address; hidden from the site while empty.
- `NEXT_PUBLIC_SITE_URL` — canonical URL used for metadata, sitemap and JSON-LD.

## Design rules

The site follows the monorepo's Modern Griot rules (see the root `CLAUDE.md`): no 1px borders, ambient shadows only, 12px radius, pill chips, Inter with tight headline tracking, teal for CTAs only. Product visuals are coded screens rebuilt from the Flutter app's real flows, and their sample data is illustrative only. Never add testimonials, logos or figures that aren't real.

## Scripts

| Command             | Description             |
| ------------------- | ----------------------- |
| `npm run dev`       | Dev server (Turbopack)  |
| `npm run build`     | Production build        |
| `npm run start`     | Start production server |
| `npm run lint`      | ESLint                  |
| `npm run typecheck` | TypeScript              |
| `npm run format`    | Prettier                |
