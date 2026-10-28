# Contributing to Atrio

Thanks for helping out. This monorepo holds four independent projects, so most of the work happens inside one of them. Read the [root README](README.md) first to get set up.

## Workflow

1. Branch from `main`: `feat/<scope>-<short-desc>`, `fix/<scope>-<short-desc>`, etc.
2. Keep each change scoped to one project where possible.
3. Run that project's checks locally (see below) before opening a PR.
4. Open a pull request against `main` and describe **what** changed and **why**. Add screenshots for UI changes.

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/) with the project as the scope. The dashboard ships a Commitizen config ([`cz.yaml`](atrio-dashboard-admin/cz.yaml)).

```
feat(mobile): add queue position card
fix(dashboard): use brand color for logo background
chore(backend): bump typeorm
docs: document API authorization gaps
```

Scopes: `mobile`, `dashboard`, `backend`, `landing`. Use `brand` for changes that span projects.

## Checks per project

| Project | Before pushing |
| --- | --- |
| `atrio-mobile-app` | `dart format .` · `flutter analyze` · `flutter test` (run `make gen` after touching `@freezed`, `@riverpod`, `@JsonSerializable` or Drift classes) |
| `atrio-dashboard-admin` | `pnpm lint` · `pnpm format:check` · `pnpm build` (includes `tsc -b`) · optionally `pnpm knip` |
| `atrio-backend` | `yarn lint` · `yarn test` · `yarn build` |
| `atrio-landing-page` | `npm run lint` · `npm run typecheck` · `npm run format:check` |

Never edit generated files: `*.g.dart`, `*.freezed.dart`, `routeTree.gen.ts`.

## Code conventions

The detailed conventions for each project are in [`CLAUDE.md`](CLAUDE.md) (and [`atrio-mobile-app/CLAUDE.md`](atrio-mobile-app/CLAUDE.md)). The essentials:

- **Mobile.** Clean Architecture per feature (`domain` → `data` → `presentation`). Repositories return `Either<Failure, T>`. Providers use Riverpod annotations. Use `Logger`, never `print()`.
- **Dashboard.** Prettier (single quotes, no semicolons, 80 columns). Import order is enforced. `no-console` is an error. Use the `@/` alias. Keep features self-contained under `src/features/`.
- **Backend.** One Nest module per domain. Entities extend `BaseEntity`. DTOs use `class-validator`. Protect routes with `@Roles(...)` and use `@Public()` only when a route really must be public.
- **Landing.** All copy goes in `messages/{fr,en}.json`, never hard-coded. Don't add testimonials, logos or figures that aren't real.

## Design rules (all UIs)

Every UI change must follow the **Modern Griot** rules: no 1px borders, ambient tinted shadows only, 12px radius (pill for chips), no pure black, Inter with tight headline tracking, and teal reserved for primary CTAs. See [CLAUDE.md → Design System Rules](CLAUDE.md#design-system-rules--the-modern-griot).

## Security rules

[`CLAUDE.md`](CLAUDE.md#security-framework--hard-constraints) defines non-negotiable security constraints (S1–S11): token storage, route guards, password policy, error sanitization, logging redaction, transport security and more. A PR that violates them will not be merged. In short:

- Never log passwords, tokens, OTPs or PII.
- Never render raw server error messages. Map status codes to safe strings.
- Never commit `.env` files or secrets. Only the `.env.example` templates are tracked.
- Dashboard tokens stay in memory, and mobile tokens stay in `FlutterSecureStorage`.

## Reporting security issues

Please don't open a public issue for a vulnerability. Contact the maintainer privately through their GitHub profile ([@Yobson2](https://github.com/Yobson2)).
