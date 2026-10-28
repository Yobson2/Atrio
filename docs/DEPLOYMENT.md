# Deployment

How to build and ship each Atrio project. The repository has **no live deployment configuration beyond what is listed here**: there is no infrastructure-as-code, hosting account or CD pipeline in the repo. These steps use only the artifacts that exist (Dockerfiles, `nginx.conf`, `vercel.json`, Flutter build commands).

- [Backend API](#backend-api)
- [Admin dashboard](#admin-dashboard)
- [Landing page](#landing-page)
- [Mobile app](#mobile-app)
- [Continuous integration](#continuous-integration)
- [Pre-release checklist](#pre-release-checklist)

---

## Backend API

**Artifact:** [`atrio-backend/Dockerfile`](../atrio-backend/Dockerfile). It is a three-stage build (deps → build → production) on `node:20-alpine`, runs as non-root user `appuser` (uid 1001), sets `NODE_ENV=production` and `RUNNING_IN_DOCKER=true`, copies `dist/` and `templates/`, and exposes **port 3000**.

```bash
cd atrio-backend
docker build -t atrio-backend .
docker run -d -p 3000:3000 --env-file .env.production atrio-backend
```

With `RUNNING_IN_DOCKER=true` (or when `/.dockerenv` exists), the app **does not read a `.env` file**. All configuration must come from runtime environment variables (`--env-file`, orchestrator secrets, etc.). Outside Docker, a `.env` file is required, and the app exits if it is missing.

### Backing services

`docker-compose.yml` starts **infrastructure only** (PostgreSQL 16, Redis 7, MinIO, Adminer) for local development. It does not run the API itself. In production, use managed services:

| Service | Purpose | Notes |
| --- | --- | --- |
| PostgreSQL 16 | Primary database | Set `DB_SSL_REJECT_UNAUTHORIZED` / `DB_CA_CERT` for managed TLS |
| Redis | Cache, BullMQ, Socket.IO bridge | Set `REDIS_PASSWORD` and `REDIS_SSL_REJECT_UNAUTHORIZED` for managed TLS |
| S3-compatible storage | File uploads | AWS S3, DigitalOcean Spaces or MinIO |
| SMTP | Transactional email | Templates in `templates/` |
| Firebase | Push notifications | Optional: the app starts without it |

### Database schema

`synchronize` is **off** outside `development`/`test`. Before the first production deploy, generate and commit an initial migration, then run migrations on every release:

```bash
yarn migration:generate   # writes to src/common/database/migrations/
yarn migration:run
```

> No migrations are committed yet, so a fresh production database will have no tables until you create one.

### Health check

`GET /health` is public. Use it for load-balancer and orchestrator probes. The Dockerfile does not define a `HEALTHCHECK`, so configure the probe on your platform.

### Backend environment reference

From [`atrio-backend/.env.example`](../atrio-backend/.env.example) and the config code:

| Variable | Required | Default / example | Description |
| --- | --- | --- | --- |
| `NODE_ENV` | ✓ | `development` | `development` \| `test` \| `staging` \| `production` |
| `PORT` | | `3000` | HTTP port |
| `CORS_ORIGINS` | ✓ prod | `localhost:3000,4200` fallback | Comma-separated allowed origins (also used by Socket.IO) |
| `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASS`, `DB_NAME` | ✓ | `localhost`, `5432`, `postgres`, `password`, `app_db` | PostgreSQL connection |
| `DB_SSL_REJECT_UNAUTHORIZED`, `DB_CA_CERT` | | — | TLS for managed Postgres |
| `DB_POOL_SIZE`, `DB_MAX_QUERY_TIME`, `DB_RETRY_ATTEMPTS`, `DB_RETRY_DELAY` | | — | Pool and retry tuning |
| `JWT_SECRET` | ✓ prod | — | Access-token signing secret. **Startup fails in `production`/`staging` if missing** |
| `JWT_REFRESH_SECRET` | ✓ prod | — | Refresh-token signing secret |
| `REDIS_HOST`, `REDIS_PORT`, `REDIS_PASSWORD` | ✓ | `localhost`, `6379`, empty | Redis connection |
| `REDIS_SSL_REJECT_UNAUTHORIZED` | | — | TLS for managed Redis |
| `S3_ENDPOINT`, `S3_REGION`, `S3_BUCKET` | ✓ | MinIO at `:9000`, `us-east-1`, `app-storage` | Object storage |
| `S3_ACCESS_KEY_ID`, `S3_SECRET_ACCESS_KEY` | ✓ | `minioadmin` (dev only) | Storage credentials |
| `S3_FORCE_PATH_STYLE`, `S3_PUBLIC_URL` | | `true`, `http://localhost:9000` | Path-style URLs (MinIO) and public base URL |
| `MAX_FILE_SIZE` | | `10485760` | Upload limit in bytes |
| `FIREBASE_PROJECT_ID`, `FIREBASE_PRIVATE_KEY`, `FIREBASE_CLIENT_EMAIL` | | — | Option 1 for Firebase credentials |
| `FIREBASE_SERVICE_ACCOUNT_BASE64` | | — | Option 2: base64 service-account JSON (option 3: `serviceAccountKey.json` in the project root) |
| `MAIL_HOST`, `MAIL_PORT`, `MAIL_USER`, `MAIL_PASS`, `MAIL_FROM` | ✓ for email | Mailtrap example | SMTP |
| `RUNNING_IN_DOCKER` | | `false` (`true` in the image) | Skip `.env` loading |

---

## Admin dashboard

The dashboard is a static SPA (`pnpm build` → `dist/`). Pick one of two targets.

### Option A: Docker + nginx

**Artifacts:** [`Dockerfile`](../atrio-dashboard-admin/Dockerfile) and [`nginx.conf`](../atrio-dashboard-admin/nginx.conf). The build stage runs `pnpm install --frozen-lockfile && pnpm run build`, and the runtime stage serves `dist/` from `nginx:alpine` as a non-root user, with a `HEALTHCHECK`.

```bash
cd atrio-dashboard-admin
docker build -t atrio-dashboard .
docker run -d -p 8080:80 atrio-dashboard
```

`nginx.conf` already provides:

- SPA fallback (`try_files … /index.html`)
- Security headers: CSP, `X-Frame-Options: DENY`, `X-Content-Type-Options`, `Referrer-Policy`, `Permissions-Policy`, HSTS, and `server_tokens off`
- Long-lived immutable caching for static assets

> **Before deploying,** replace the placeholder `connect-src 'self' https://*.your-api-domain.com` in `nginx.conf` with your real API origin. The `<meta>` CSP in `index.html` has no `connect-src`, so it falls back to `default-src 'self'` and blocks a cross-origin API. Add the API origin there too.

### Option B: Vercel

[`vercel.json`](../atrio-dashboard-admin/vercel.json) sets `framework: vite`, `pnpm install`, `pnpm run build`, output `dist`, and an SPA rewrite to `/index.html`. Set the project's **Root Directory** to `atrio-dashboard-admin`. With Vercel, security headers come only from the CSP `<meta>` tag in `index.html`, because `nginx.conf` is not used.

### Build-time variables

Vite inlines these at **build time**, so set them before `pnpm build` (or as Vercel environment variables):

| Variable | Notes |
| --- | --- |
| `VITE_API_URL` | Must start with `https://` in production builds, or the app throws at startup. Include the `/api` prefix. |
| `VITE_APP_NAME` | Display name |

---

## Landing page

A standard Next.js 16 app with no Dockerfile or `vercel.json`, so platform defaults apply.

```bash
cd atrio-landing-page
npm ci
npm run build
npm run start            # serves on :3000 by default
```

On Vercel, set the Root Directory to `atrio-landing-page`. Before launch (see the [landing README](../atrio-landing-page/README.md#before-launch)):

- `NEXT_PUBLIC_SITE_URL`: canonical origin for metadata, sitemap and JSON-LD
- `stores.appStore` / `stores.googlePlay` in `app/lib/constants.ts`: the badges show "coming soon" until set
- `email` in `app/lib/constants.ts`: hidden while empty

---

## Mobile app

### Environment

Copy the right env file to `.env` **before building**, because it is bundled into the app as an asset:

```bash
cp .env.production .env   # create it from .env.example first; it is git-ignored
```

For production, set `ENV_NAME=production`, an `https://` `BASE_URL` (including `/api`), `ENABLE_LOGGING=false` and `SHOW_DEBUG_BANNER=false`. Mock auth is unreachable in release builds whatever `USE_MOCK_AUTH` says.

### Android

```bash
make gen
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info   # Play Store
flutter build apk       --release --obfuscate --split-debug-info=build/debug-info   # sideload
```

Keep `build/debug-info/` (but don't commit it): you need it to symbolize obfuscated crash stack traces.

> **Before publishing:** the `applicationId`/`namespace` in `android/app/build.gradle*` is still `com.example.flutter_templates`. The Play Store rejects `com.example.*` IDs, so change it to your own reverse-domain ID and configure a release signing key. Neither is in the repository.

### iOS

```bash
make gen
flutter build ipa --release --obfuscate --split-debug-info=build/debug-info
```

Requires macOS + Xcode, an Apple Developer account, and a bundle ID and signing configured in `ios/Runner.xcodeproj`.

---

## Continuous integration

GitHub Actions workflows exist for each project, but they are stored **inside the sub-project folders**:

| File | What it does |
| --- | --- |
| `atrio-dashboard-admin/.github/workflows/ci.yml` | pnpm install (frozen) → `pnpm audit --audit-level=high` → lint → `tsc -b` → build; gitleaks secrets scan |
| `atrio-mobile-app/.github/workflows/ci.yml` | `dart format` check → `dart pub audit` → `flutter analyze` → `flutter test`; then an obfuscated release APK build |
| `atrio-landing-page/.github/workflows/action.yml` | Creates a GitHub Release on `v*` tags |

GitHub runs workflows **only from the repository root's `.github/workflows/`**, so these currently never trigger. To activate them, move them to the root. They already set `working-directory` / `cache-dependency-path` to the sub-project. `action.yml` also needs re-indenting first: `push:` and `release:` are not nested under `on:` / `jobs:`, and consider adding path filters (`on.push.paths`) so each workflow runs only when its project changes. The backend has no CI workflow yet.

---

## Pre-release checklist

The authoritative security checklist is **S11 in [`CLAUDE.md`](../CLAUDE.md#s11-security-verification-checklist)**. Deployment-specific items:

- [ ] Strong, unique `JWT_SECRET` and `JWT_REFRESH_SECRET`; no `minioadmin` or default DB credentials
- [ ] `NODE_ENV=production` and an initial migration created and applied
- [ ] `CORS_ORIGINS` limited to the real dashboard and app origins
- [ ] The authorization gaps listed in [API.md](API.md#authorization-gaps-known-issues) are fixed
- [ ] Dashboard `VITE_API_URL` uses `https://`, and the CSP `connect-src` allows the API origin
- [ ] Mobile `.env` uses production values; package/bundle IDs renamed; release signing configured
- [ ] CI workflows moved to the root and passing
