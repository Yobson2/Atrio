# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

Monorepo with two independent sub-projects:

- **`atrio-dashboard-admin/`** — React admin dashboard (TypeScript, Vite, TailwindCSS v4, shadcn/ui)
- **`atrio-mobile-app/`** — Flutter mobile app (Dart, Riverpod, GoRouter, Clean Architecture)

Each has its own package manager, build system, and dependencies. The mobile app has its own `CLAUDE.md` with detailed architecture docs.

---

## atrio-dashboard-admin (React)

### Commands

```bash
cd atrio-dashboard-admin
pnpm install          # Install dependencies
pnpm dev              # Start dev server (Vite)
pnpm build            # Type-check (tsc) + production build
pnpm preview          # Preview production build
pnpm lint             # ESLint (flat config, v9)
pnpm format           # Prettier format
pnpm format:check     # Check formatting
pnpm knip             # Detect unused dependencies/exports
```

### Tech Stack

React 19 + TypeScript 5.8 (strict), Vite 6 with SWC, TailwindCSS v4 (native Vite plugin, theme defined in `src/index.css` via `@theme inline` + CSS custom properties using `oklch()`), shadcn/ui (new-york style, slate base), TanStack Router (file-based with auto code-splitting), TanStack Query v5, TanStack Table, Zustand, React Hook Form + Zod, axios, i18next (en + fr), Framer Motion, Sonner toasts.

### Architecture

**Routing** — File-based via TanStack Router plugin. Routes live in `src/routes/`. Key conventions:
- `_authenticated/` — layout route requiring auth, wraps content in sidebar shell
- `_public/` — public layout with navbar/footer
- `(auth)/` and `(errors)/` — path-group folders (no URL segment)
- Route tree auto-generated in `src/routeTree.gen.ts` — never edit manually
- `defaultPreload: 'intent'` (preloads on hover/focus)
- Router receives `queryClient` via context for use in loaders

**API layer** (`src/api/`):
- `axios-instance.ts` — base URL from `VITE_API_URL`, 30s timeout. Request interceptor injects Bearer token from Zustand auth store. Response interceptor clears auth on 401.
- `endpoints.ts` — typed endpoint constants (`ENDPOINTS.AUTH.LOGIN`, `ENDPOINTS.USERS.DETAIL(id)`, etc.)
- `types.ts` — `ApiResponse<T>`, `PaginatedResponse<T>`, `ApiError`

**State management**:
- Zustand: single `authStore` — stores `user` (in-memory) + `accessToken` (cookie via `js-cookie`, key from `VITE_AUTH_TOKEN_KEY` env var)
- TanStack Query: server state. `QueryClient` in `src/main.tsx` with centralized error handling (401 → clear auth + redirect to `/sign-in`, 500 → navigate to `/500`)
- Feature-level dialogs: React Context + `useDialogState` hook per feature (e.g., `TasksContext`, `UsersContext`)

**Component organization**:
- `src/components/ui/` — shadcn/ui primitives (excluded from ESLint)
- `src/components/layout/` — sidebar, header, main wrapper, nav groups. Sidebar config in `layout/data/sidebar-data.ts`
- `src/components/motion/` — Framer Motion wrappers (page transitions, stagger animations). Variants defined in `src/lib/motion.ts`
- `src/components/command-menu.tsx` — command palette (Cmd+K) via `cmdk`, auto-populated from sidebar nav data
- `src/context/` — ThemeContext (light/dark/system, persisted to localStorage), FontContext (inter/manrope/system), SearchContext (command palette toggle + keyboard shortcut)

**Features** (`src/features/`) — each feature is self-contained with its own components, context, data, and types. Current features use mock static data.

### Code Style

- **ESLint**: `no-console: 'error'`, `no-unused-vars: 'error'` (underscore-prefixed vars ignored)
- **Prettier**: single quotes, no semicolons, 2-space indent, 80 char width, ES5 trailing commas, LF line endings
- **Import order** (enforced by `@trivago/prettier-plugin-sort-imports`): `path` → `vite` → `react` → third-party → `@/api` → `@/stores` → `@/lib` → `@/utils` → ... → `@/features` → relative imports
- **Path alias**: `@` → `./src`

### CI

GitHub Actions (`.github/workflows/ci.yml`): lint → type-check → build on push/PR to main. Uses pnpm 9 + Node 20.

---

## atrio-mobile-app (Flutter)

### Commands

```bash
cd atrio-mobile-app
flutter run                                                    # Run app
dart run build_runner build --delete-conflicting-outputs       # Code generation (or: make gen)
dart run build_runner watch --delete-conflicting-outputs       # Watch mode (or: make watch)
flutter test                                                   # Run tests
flutter test test/features/auth/domain/usecases/login_usecase_test.dart  # Single test
flutter test integration_test                                  # Integration tests
flutter analyze                                                # Lint (very_good_analysis + riverpod_lint)
dart format .                                                  # Format
flutter gen-l10n                                               # Generate l10n
```

See `atrio-mobile-app/Makefile` for shorthand targets (`make gen`, `make test`, `make analyze`, etc.).

### Tech Stack

Flutter 3.6+, Riverpod (with code-gen annotations), GoRouter, Dio, Drift (SQLite), Freezed + json_serializable, dartz (`Either<Failure, T>`), flutter_dotenv, flutter_secure_storage, SharedPreferences, flutter_screenutil (375×812 design size), Google Fonts (Inter), connectivity_plus.

### Architecture

**Clean Architecture per feature** (`lib/features/<name>/`):
- `domain/` — entities (plain immutable Dart), abstract repository interfaces, use cases (`UseCase<T, Params>` base class returning `Future<Either<Failure, T>>`)
- `data/` — models (`@freezed` + `@JsonSerializable` with `toEntity()`), repository implementations, remote/local datasources
- `presentation/` — pages, widgets, Riverpod notifiers, state classes (`@freezed` sealed unions)

**Data flow**: Page → Notifier → UseCase → Repository (checks connectivity, catches exceptions, maps to `Failure`) → DataSource (Dio/Storage)

**DI via Riverpod** — all providers use `@riverpod`/`@Riverpod` annotations (generates `.g.dart`). Core providers are `keepAlive: true`. Chain: `envProvider` → `dioProvider` → datasource → repository → use case → notifier.

**Router** (`lib/core/router/app_router.dart`):
- GoRouter with `StatefulShellRoute.indexedStack` for two shells: client (4 tabs) and owner (4 tabs)
- Auth state bridged to GoRouter via `ValueNotifier` from Riverpod `ref.listen`
- Global redirect handles: auth guards, onboarding check, role-based shell routing

**Network** (`lib/core/network/`):
- `DioClient` with interceptor chain: `LoggingInterceptor` → `AuthInterceptor` (QueuedInterceptor, handles 401 token refresh) → `ErrorInterceptor` (maps to typed exceptions)
- `ApiEndpoints` centralizes all URL paths

**Offline sync** (`lib/core/sync/`):
- Drift-based `SyncQueue` table tracks pending operations
- `SyncEngine` processes queue on reconnect, supports conflict resolution (server-wins on 409), exponential backoff retries

**Error hierarchy**: Data layer throws typed exceptions (`ServerException`, `CacheException`, `NetworkException`, `UnauthorizedException`), repositories catch and map to `Failure` sealed class subtypes.

**Theme** (`lib/core/theme/`): "Editorial Artisan" design — no 1px borders (tonal shifts + spacing instead), Material 3, semantic color tokens for light/dark, full surface container hierarchy. `ThemeModeNotifier` persists preference.

**Environment**: `.env` loaded via `flutter_dotenv`. Switch by copying `.env.development`/`.env.staging`/`.env.production` → `.env`. Mock datasources toggled via `USE_MOCK_AUTH` dotenv flag.

**Code generation**: After changing `@freezed`, `@JsonSerializable`, `@riverpod`, or Drift classes, run `dart run build_runner build --delete-conflicting-outputs`. Generated files: `*.g.dart`, `*.freezed.dart`.

**Localization**: ARB files in `lib/l10n/` (en, fr). Generated via `flutter gen-l10n`.

**Lint rules**: Extends `very_good_analysis` with `riverpod_lint` and `custom_lint`. Disabled: `public_member_api_docs`, `lines_longer_than_80_chars`, `flutter_style_todos`, `one_member_abstracts`. Generated files excluded.

### CI

GitHub Actions: format check → `flutter analyze` → `flutter test` → `flutter build apk --debug`. Uses stable Flutter channel.

---

## Design System Rules — The Modern Griot

Both sub-projects share the "Editorial Artisan" design philosophy (detailed in `atrio-mobile-app/ressources/precision_groom/DESIGN.md`). These are **hard constraints** for all UI work:

- **No 1px borders.** Define boundaries through background color shifts (tonal layering) and generous spacing. If a border is required for accessibility (e.g., input focus), use a "Ghost Border": `outline_variant` at 15% opacity.
- **No default Tailwind/Material drop shadows.** Use ambient shadows only: `0px 12px 32px rgba(25, 28, 30, 0.06)`. Shadows must never be pure black — tint with the surface color at ultra-low opacity.
- **No sharp corners.** Buttons and cards use 12px radius; chips use pill radius (9999px).
- **No `#000000` or pure black.** Use the semantic foreground tokens (`foreground`, `on_surface`, `textPrimary`).
- **Whitespace is structural.** When a section feels crowded, add 16–24px padding rather than a divider.
- **Primary colors used sparingly.** Deep teal (`#00685F` mobile) / brand tokens (dashboard) are for high-impact CTAs only.
- **Hero CTAs use subtle gradients** (primary → primary_container), not flat fills.
- **Floating nav uses glassmorphism** (surface at 80% opacity + 20px backdrop-blur).
- **Inter font** is the primary typeface across both projects. Headlines use tight letter-spacing (-0.02em).

---

## Skills — When & How to Use

Both skills **must respect the "Design System Rules — atrio" section above as hard constraints**. Never suggest or generate UI that violates those rules.

### `frontend-design` (build)
- **Invoke before** creating new components, new pages, or making significant visual changes (layout shifts, new interaction patterns, new sections).
- **Do NOT invoke** for trivial edits: padding tweaks, copy changes, translation fixes, import reordering, bug fixes that don't alter visual output.

### `ui-ux-pro-max` (plan + review)
- **Invoke to plan** before building any new feature or page — define UX flow, layout strategy, interaction states, responsive breakpoints, and accessibility requirements first.
- **Invoke to review** after building — audit for accessibility (WCAG AA), responsive consistency, animation quality, color contrast, and Modern Griot conformance.
- **Invoke to improve** existing pages when asked to polish, optimize, or fix UX issues.

### Ideal workflow for new features
1. `ui-ux-pro-max` → **plan** (UX flow, layout, states, a11y)
2. `frontend-design` → **build** (distinctive, production-grade code)
3. `ui-ux-pro-max` → **review** (audit output against design system + UX best practices)

---

## Security Framework — Hard Constraints

These rules are **non-negotiable** for all code changes. Every PR, feature, and bugfix must comply. Violations must be fixed before merge. The framework is tailored to this monorepo's stack: React 19 + Vite + axios + Zustand + js-cookie (dashboard) and Flutter + Dio + Drift + SecureStorage (mobile).

---

### S1. Authentication & Token Management [CRITICAL]

**Why:** Tokens in JS-accessible cookies are trivially stealable via XSS. Mock auth in production means zero authentication. Leaked credentials in logs are a data breach.

**Dashboard rules (`atrio-dashboard-admin/`):**

- **Never store tokens in cookies or localStorage.** Access tokens must live in Zustand in-memory state only. Remove all `js-cookie` token persistence from `src/stores/authStore.ts`. The backend should set HttpOnly + Secure + SameSite=Strict cookies via `Set-Cookie` headers if cookie-based auth is needed — never set auth cookies from client-side JS.

```typescript
// src/stores/authStore.ts — CORRECT: in-memory only
interface AuthSlice {
  accessToken: string
  user: User | null
  setAccessToken: (token: string) => void
  reset: () => void
}

// NO Cookies.set(), NO localStorage.setItem() for tokens
const createAuthSlice: StateCreator<AuthSlice> = (set) => ({
  accessToken: '',
  user: null,
  setAccessToken: (token) => set({ accessToken: token }),
  reset: () => set({ accessToken: '', user: null }),
})
```

- **Add token expiry checking.** Before attaching the Bearer token in `src/api/axios-instance.ts`, decode the JWT and check `exp`. If expired, attempt a refresh or redirect to sign-in. The mobile app already does this via `AuthInterceptor` — the dashboard must match.

- **Add idle session timeout.** Clear tokens after 15 minutes of inactivity. Use a `setTimeout` reset on user interaction events (click, keypress, scroll).

- **Never log sensitive data.** The `no-console: 'error'` ESLint rule is already set, but there are `eslint-disable` overrides that log passwords and full error objects:
  - `src/features/auth/sign-up/components/sign-up-form.tsx` — `console.log(data)` logs password. Remove it.
  - `src/utils/handle-server-error.ts` — `console.log(error)` leaks full axios error including auth headers. Replace with a structured logger that redacts sensitive fields.

**Mobile rules (`atrio-mobile-app/`):**

- Tokens already use `FlutterSecureStorage` (Keychain/Keystore). **Keep it that way.** Never move tokens to SharedPreferences.

- **Mock auth must be compile-time unreachable in release builds.** A `.env` flag alone (`USE_MOCK_AUTH`) is insufficient — it can be toggled on production APKs. Add a `kReleaseMode` hard-guard:

```dart
// lib/features/auth/presentation/providers/auth_providers.dart
Provider<AuthRemoteDataSource>((ref) {
  // Mock datasource ONLY in debug mode AND when env flag is set
  if (!kReleaseMode && env.useMockAuth) {
    return MockAuthRemoteDataSource();
  }
  return AuthRemoteDataSourceImpl(dioClient: ref.read(dioProvider));
})
```

**Common mistakes:**
- Storing tokens in `document.cookie` via `js-cookie` (XSS-accessible)
- Using `localStorage` for tokens (persists across sessions, XSS-accessible)
- Logging full error objects that contain `Authorization` headers
- Using `.env` flags alone to gate mock auth (can be changed at runtime)

---

### S2. Route Protection & Authorization [CRITICAL]

**Why:** Without route guards, unauthenticated users can navigate directly to `/dashboard`, `/users`, etc. Open redirects enable phishing attacks.

**Dashboard rules:**

- **Add `beforeLoad` guard to `_authenticated/route.tsx`.** This is currently missing — the layout renders for anyone.

```typescript
// src/routes/_authenticated/route.tsx
import { createFileRoute, redirect } from '@tanstack/react-router'
import { useAuthStore } from '@/stores/authStore'

export const Route = createFileRoute('/_authenticated')({
  beforeLoad: () => {
    const token = useAuthStore.getState().auth.accessToken
    if (!token) {
      throw redirect({
        to: '/sign-in',
        search: { redirect: window.location.pathname },
      })
    }
  },
  component: AuthenticatedLayout,
})
```

- **Sanitize the `?redirect=` query parameter** in `src/main.tsx` (lines 55-57). Validate it starts with `/` and does not contain `//` or external URLs:

```typescript
function getSafeRedirect(url: string | undefined): string {
  if (!url) return '/dashboard'
  // Must be relative, no protocol, no double slashes
  if (/^\/[a-zA-Z0-9\-_/]*$/.test(url)) return url
  return '/dashboard'
}
```

**Mobile rules:**

- GoRouter auth guards already exist (good). When adding deep links, validate all path parameters and query strings against an allowlist of known routes. Never navigate to arbitrary URLs from push notification payloads without validation.

**Common mistakes:**
- Checking auth state only in the component (client-side redirect flashes protected content)
- Redirecting to `?redirect=` without validation (open redirect to `//evil.com`)
- Protecting pages but not API routes (users can still call unguarded endpoints via devtools)

---

### S3. Input Validation & Output Sanitization [HIGH]

**Why:** Weak passwords are brute-forceable. Unsanitized server error messages can leak internal details (SQL errors, stack traces) or contain XSS payloads.

**Password validation — both apps:**

- Minimum **12 characters**, require uppercase + lowercase + digit + special character. Max 128 characters (prevent DoS with megabyte-length strings).

```typescript
// Dashboard — Zod schema
const passwordSchema = z
  .string()
  .min(12, 'Password must be at least 12 characters')
  .max(128, 'Password must be at most 128 characters')
  .regex(/[A-Z]/, 'Must contain an uppercase letter')
  .regex(/[a-z]/, 'Must contain a lowercase letter')
  .regex(/[0-9]/, 'Must contain a digit')
  .regex(/[^A-Za-z0-9]/, 'Must contain a special character')
```

```dart
// Mobile — lib/core/utils/validators.dart (update existing)
static String? password(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 12) return 'Password must be at least 12 characters';
  if (value.length > 128) return 'Password is too long';
  if (!value.contains(RegExp(r'[A-Z]'))) return 'Must contain an uppercase letter';
  if (!value.contains(RegExp(r'[a-z]'))) return 'Must contain a lowercase letter';
  if (!value.contains(RegExp(r'[0-9]'))) return 'Must contain a digit';
  if (!value.contains(RegExp(r'[^A-Za-z0-9]'))) return 'Must contain a special character';
  return null;
}
```

**Error sanitization — both apps:**

- **Never render server error messages directly in UI.** Map HTTP status codes to safe, user-facing strings. If the server returns `"SQLSTATE[42S02]: Base table or view not found"`, the user should see `"Something went wrong. Please try again."`.

```typescript
// Dashboard — src/utils/handle-server-error.ts
const SAFE_MESSAGES: Record<number, string> = {
  400: 'Invalid request. Please check your input.',
  401: 'Session expired. Please sign in again.',
  403: 'You do not have permission to perform this action.',
  404: 'The requested resource was not found.',
  409: 'A conflict occurred. Please refresh and try again.',
  422: 'Please check your input and try again.',
  429: 'Too many requests. Please wait a moment.',
  500: 'Something went wrong. Please try again later.',
}

export function handleServerError(error: AxiosError): string {
  const status = error.response?.status ?? 500
  return SAFE_MESSAGES[status] ?? SAFE_MESSAGES[500]
}
```

**XSS prevention:**
- React's JSX escaping handles most cases. **Never use `dangerouslySetInnerHTML`** unless the HTML comes from a trusted, sanitized source (e.g., DOMPurify).
- In Flutter, never use the `Html` widget or `WebView` to render unescaped server content.
- Add `max` length to all `<input>` and `TextField` fields to prevent payload injection via oversized inputs.

**Common mistakes:**
- Displaying `error.response?.data.title` or `error.response?.data.message` directly in toasts
- Password min length of 7 (too weak) or no max length (DoS vector)
- Using `dangerouslySetInnerHTML` for markdown/rich text without DOMPurify

---

### S4. Transport Security [HIGH]

**Why:** Without certificate pinning, MITM proxies (corporate, malicious WiFi) can intercept all mobile traffic. Cleartext HTTP allows passive sniffing. Missing CSRF protection enables cross-site request forgery.

**Mobile rules:**

- **Add certificate pinning** to `lib/core/network/dio_client.dart`. Pin to the intermediate CA SHA-256 fingerprint, not the leaf certificate (leaf certs rotate frequently):

```dart
// lib/core/network/dio_client.dart — add to Dio initialization
import 'dart:io';

SecurityContext createSecurityContext() {
  final context = SecurityContext(withTrustedRoots: false);
  // Add your CA certificate (PEM format)
  context.setTrustedCertificatesBytes(caCertBytes);
  return context;
}

// Apply to Dio's HttpClientAdapter
(dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
  final client = HttpClient(context: createSecurityContext());
  client.badCertificateCallback = (cert, host, port) => false; // reject bad certs
  return client;
};
```

- **Enforce HTTPS on Android.** Add to `android/app/src/main/AndroidManifest.xml` `<application>` tag:

```xml
<application
    android:usesCleartextTraffic="false"
    ...>
```

- **Verify iOS ATS.** Default ATS requires HTTPS (good). Do not add `NSAllowsArbitraryLoads = true` to `Info.plist`.

**Dashboard rules:**

- **CSRF protection.** If the backend issues CSRF tokens, send them via `X-CSRF-Token` header on all state-changing requests (POST, PUT, PATCH, DELETE). Add to `src/api/axios-instance.ts`:

```typescript
api.interceptors.request.use((config) => {
  if (['post', 'put', 'patch', 'delete'].includes(config.method ?? '')) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')
      ?.getAttribute('content')
    if (csrfToken) config.headers['X-CSRF-Token'] = csrfToken
  }
  return config
})
```

- **Enforce HTTPS for API URL.** In production, validate that `VITE_API_URL` starts with `https://`. Never allow `http://` in production builds.

**Common mistakes:**
- Pinning to leaf certificates (breaks on cert renewal)
- Adding `NSAllowsArbitraryLoads = true` to test against local servers (use `NSExceptionDomains` instead)
- Forgetting CSRF on non-GET requests when using cookie-based auth

---

### S5. Data Storage Security [HIGH]

**Why:** On rooted/jailbroken devices, SharedPreferences (plain XML on Android, plist on iOS) and unencrypted SQLite databases are trivially readable. PII exposure violates GDPR/privacy regulations.

**Data classification rule:**

| Data Type | Dashboard Storage | Mobile Storage |
|-----------|-------------------|----------------|
| Auth tokens | In-memory Zustand only | `FlutterSecureStorage` |
| User profile (name, email, phone) | In-memory Zustand only | `FlutterSecureStorage` |
| Theme, locale, onboarding flags | `localStorage` | `SharedPreferences` |
| Sidebar state, font preference | `localStorage` (cookie OK) | `SharedPreferences` |
| Bookings, notes, sync queue | N/A | Encrypted Drift DB |

**Mobile — fix cached user profile.** Move from SharedPreferences to SecureStorage in `lib/features/auth/data/datasources/auth_local_datasource.dart`:

```dart
// BEFORE (insecure — plain SharedPreferences)
final jsonString = json.encode(user.toJson());
await _localStorage.setString(_cachedUserKey, jsonString);

// AFTER (secure — encrypted Keychain/Keystore)
final jsonString = json.encode(user.toJson());
await _secureStorage.write(key: _cachedUserKey, value: jsonString);
```

**Mobile — encrypt the Drift database.** Use `sqlcipher_flutter_libs` + `encrypted_drift` to encrypt SQLite at rest. Store the encryption key in `SecureStorage`:

```dart
// lib/core/database/app_database.dart
import 'package:drift/native.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbKey = await secureStorage.read(key: 'db_encryption_key');
    // Generate key on first launch, store in SecureStorage
    final key = dbKey ?? _generateAndStoreKey();
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'atrio.db'));
    return NativeDatabase.createInBackground(
      file,
      setup: (db) => db.execute("PRAGMA key = '$key';"),
    );
  });
}
```

**Common mistakes:**
- Caching user email/phone in SharedPreferences "for convenience"
- Using unencrypted SQLite for offline sync payloads containing PII
- Storing the DB encryption key alongside the database file (defeats the purpose)

---

### S6. Logging & Information Leakage [MEDIUM]

**Why:** Logs containing passwords, tokens, or PII are a data breach if the device is compromised, logs are shipped to a monitoring service, or crash reports include them.

**Sensitive data that must NEVER be logged:**
- Passwords, OTP codes, PIN codes
- Access tokens, refresh tokens, API keys
- Email addresses, phone numbers, full names
- Credit card numbers, bank account details
- Any field from a login/register request body

**Dashboard rules:**

- Audit and remove all `eslint-disable.*no-console` overrides that log sensitive data.
- Replace raw `console.log(error)` in `src/utils/handle-server-error.ts` with a structured logger that redacts `Authorization` headers and request/response bodies on auth endpoints.
- In production builds, all logging should be no-ops or ship to a secure monitoring service (Sentry, Datadog) with PII scrubbing enabled.

**Mobile rules:**

- `LoggingInterceptor` at `lib/core/network/interceptors/logging_interceptor.dart` logs `options.data` (request body) which includes passwords on `/login` and `/register`. **Add field redaction:**

```dart
String _redactSensitiveFields(dynamic data) {
  if (data is Map<String, dynamic>) {
    final redacted = Map<String, dynamic>.from(data);
    const sensitiveKeys = {'password', 'token', 'otp', 'pin', 'secret',
                           'accessToken', 'refreshToken', 'credit_card'};
    for (final key in sensitiveKeys) {
      if (redacted.containsKey(key)) redacted[key] = '***REDACTED***';
    }
    return redacted.toString();
  }
  return data.toString();
}
```

- **Hard-guard logging in release builds.** The `ENABLE_LOGGING` env var defaults to `true`. Add a safety net in `lib/core/utils/logger.dart`:

```dart
static void debug(String message, {String? tag}) {
  if (kReleaseMode) return; // Hard-guard: NEVER log in release
  if (!AppConfig.enableLogging) return;
  log(message, name: tag ?? 'APP', level: 0);
}
```

**Common mistakes:**
- Logging full axios/Dio error objects (they contain request headers with Bearer tokens)
- Shipping debug logs to production crash reporting without PII filters
- Using `print()` in Dart (bypasses all log level controls, goes straight to stdout)

---

### S7. HTTP Security Headers & CSP [MEDIUM]

**Why:** Without CSP, injected scripts run freely. Without X-Frame-Options, the dashboard can be iframed for clickjacking attacks. These headers are the last line of defense if XSS bypasses other controls.

**Dashboard — add security headers to `nginx.conf`:**

```nginx
server {
    listen 80;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;

    # Security Headers
    add_header Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: blob:; connect-src 'self' https://*.your-api-domain.com; frame-ancestors 'none'; base-uri 'self'; form-action 'self';" always;
    add_header X-Frame-Options "DENY" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Permissions-Policy "camera=(), microphone=(), geolocation=(), payment=()" always;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

    # Remove server version header
    server_tokens off;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

**Dashboard — add CSP meta tag to `index.html` as fallback** (for non-nginx deployments like Vercel):

```html
<head>
  <meta http-equiv="Content-Security-Policy"
    content="default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: blob:; frame-ancestors 'none';">
  <!-- ... existing head content ... -->
</head>
```

**Common mistakes:**
- Using `unsafe-eval` in CSP (allows `eval()`, defeats XSS protection)
- Setting `X-Frame-Options: SAMEORIGIN` when framing is never needed (use `DENY`)
- Forgetting to add `always` to nginx `add_header` directives (headers not sent on error responses)

---

### S8. Container & Deployment Security [MEDIUM]

**Why:** Containers running as root grant full system access if RCE occurs. Unobfuscated APKs reveal API structure, model classes, and business logic. Backups enabled on Android allow data extraction via `adb backup`.

**Dashboard — Dockerfile hardening (`atrio-dashboard-admin/Dockerfile`):**

```dockerfile
# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN corepack enable && pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

# Production stage — non-root user
FROM nginx:alpine AS production
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN chown -R appuser:appgroup /usr/share/nginx/html \
    && chown -R appuser:appgroup /var/cache/nginx \
    && chown -R appuser:appgroup /var/log/nginx \
    && touch /var/run/nginx.pid \
    && chown -R appuser:appgroup /var/run/nginx.pid
USER appuser
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s CMD wget -q --spider http://localhost/ || exit 1
CMD ["nginx", "-g", "daemon off;"]
```

**Mobile — Android hardening:**

- Add to `android/app/src/main/AndroidManifest.xml` `<application>` tag:

```xml
<application
    android:allowBackup="false"
    android:usesCleartextTraffic="false"
    android:fullBackupContent="false"
    ...>
```

- **Fix ProGuard rules** (`android/app/proguard-rules.pro`): Remove the blanket keep rule `keep class com.example.flutter_templates.** { *; }` — this keeps ALL app classes unobfuscated, defeating R8. Only keep what Flutter and serialization require.

- **Enable Flutter obfuscation** in release builds:

```bash
flutter build apk --release --obfuscate --split-debug-info=build/debug-info
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info
```

**Common mistakes:**
- Running nginx as root in Docker (default if no `USER` directive)
- Keeping `allowBackup="true"` (default) — allows `adb backup` data extraction
- Keeping all model classes unobfuscated via blanket ProGuard rules

---

### S9. CI/CD Security Pipeline [MEDIUM]

**Why:** CI is the last automated gate before production. Without dependency audits, known CVEs ship. Without secrets scanning, leaked credentials enter the git history permanently.

**Dashboard CI — add to `.github/workflows/ci.yml`:**

```yaml
jobs:
  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install dependencies
        run: pnpm install --frozen-lockfile

      - name: Dependency audit
        run: pnpm audit --audit-level=high

      - name: Lint (with security plugin)
        run: pnpm lint

      - name: Secrets scan
        uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

- **Add `eslint-plugin-security`** to the dashboard ESLint config (`eslint.config.js`):

```bash
pnpm add -D eslint-plugin-security
```

```javascript
// eslint.config.js — add to plugins and rules
import security from 'eslint-plugin-security'

export default [
  // ... existing config
  {
    plugins: { security },
    rules: {
      ...security.configs.recommended.rules,
    },
  },
]
```

**Mobile CI — add to `.github/workflows/ci.yml`:**

```yaml
      - name: Dependency audit
        run: dart pub audit
        working-directory: atrio-mobile-app

      - name: Build with obfuscation
        run: flutter build apk --release --obfuscate --split-debug-info=build/debug-info
        working-directory: atrio-mobile-app
```

- **Fix the working directory** in the mobile CI config — it currently references `flutter_templates` instead of `atrio-mobile-app`.

**Both projects:**
- Consider adding CodeQL or SonarQube for SAST (static application security testing).
- Add `SECURITY.md` at repo root with responsible disclosure policy and security contact.

**Common mistakes:**
- Using `--no-frozen-lockfile` in CI (allows lockfile drift, supply chain risk)
- Not failing the build on high-severity audit findings
- Running secrets scanning only on PRs (miss direct pushes to main)

---

### S10. Dependency & Supply Chain Security [LOW-MEDIUM]

**Why:** Dependencies are the largest attack surface in modern apps. A single compromised package can exfiltrate tokens, inject miners, or backdoor the entire app.

**Rules:**

- **Lock files must always be committed.** Currently done for both projects (good). Never add lock files to `.gitignore`.
- **CI must use frozen installs.** Dashboard already uses `pnpm install --frozen-lockfile` (good). Never use `--no-frozen-lockfile` in CI.
- **Pin exact versions for security-critical packages**: auth libraries, crypto packages, HTTP clients. Use `"axios": "1.8.4"` not `"axios": "^1.8.4"` for these.
- **Review before adding dependencies.** Check: npm/pub scores, maintenance status (last publish date, open issues), known CVEs, download count, GitHub stars. Prefer well-maintained packages with active security teams.
- **Run audits locally before merging PRs:**

```bash
# Dashboard
cd atrio-dashboard-admin && pnpm audit

# Mobile
cd atrio-mobile-app && dart pub audit
```

- **Remove hardcoded fallback URLs** that point to real environments. In `lib/core/config/app_config.dart`, the fallback `https://api-dev.example.com/v1` should be a clearly fake domain like `https://not-configured.invalid` — or better, throw an error if `.env` is missing in release mode.

**Common mistakes:**
- Using `*` or `latest` for dependency versions
- Not reviewing changelogs when updating major versions
- Ignoring `pnpm audit` warnings because "they're just dev dependencies" (dev deps can compromise the build pipeline)
- Hardcoding fallback API URLs that accidentally point to development servers in production

---

### S11. Security Verification Checklist

Run this checklist before every production release. Every item must pass.

**Dashboard (`atrio-dashboard-admin/`):**

- [ ] Auth tokens stored in in-memory Zustand only (no cookies, no localStorage)
- [ ] `beforeLoad` auth guard present on `_authenticated/route.tsx`
- [ ] `?redirect=` query param validated (relative paths only, no external URLs)
- [ ] No `console.log` with sensitive data (search: `eslint-disable.*no-console`)
- [ ] Password validation: min 12 chars + uppercase + lowercase + digit + special
- [ ] Server error messages mapped to safe user-facing strings (not raw server responses)
- [ ] `nginx.conf` includes all security headers (CSP, X-Frame-Options, HSTS, etc.)
- [ ] `index.html` has CSP `<meta>` tag
- [ ] Dockerfile uses non-root user (`USER appuser`)
- [ ] CI runs `pnpm audit --audit-level=high`
- [ ] `eslint-plugin-security` enabled in ESLint config
- [ ] No mock auth logic reachable in production build
- [ ] Session timeout implemented (15 min idle)
- [ ] `VITE_API_URL` enforced as `https://` in production
- [ ] No `dangerouslySetInnerHTML` without DOMPurify

**Mobile (`atrio-mobile-app/`):**

- [ ] Certificate pinning configured in `DioClient`
- [ ] `android:allowBackup="false"` in AndroidManifest.xml
- [ ] `android:usesCleartextTraffic="false"` in AndroidManifest.xml
- [ ] Drift database encrypted with SqlCipher
- [ ] User profile stored in `SecureStorage`, not `SharedPreferences`
- [ ] `MockAuthRemoteDataSource` unreachable in release builds (`kReleaseMode` guard)
- [ ] `LoggingInterceptor` redacts password/token/otp fields
- [ ] `ENABLE_LOGGING=false` in production `.env` + `kReleaseMode` hard-guard in logger
- [ ] ProGuard rules do NOT blanket-keep app model classes
- [ ] Flutter build uses `--obfuscate --split-debug-info`
- [ ] Deep links validated against route allowlist
- [ ] No hardcoded credentials in any non-mock file
- [ ] `dart pub audit` runs in CI with zero high-severity findings
- [ ] Sync queue payloads encrypted at rest (via encrypted Drift DB)
- [ ] iOS ATS enforces HTTPS (no `NSAllowsArbitraryLoads = true`)
