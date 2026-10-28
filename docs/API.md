# API reference

The REST API served by [`atrio-backend`](../atrio-backend/). This page summarizes what the code currently exposes. For request/response schemas and to try calls interactively, use the Swagger UI the server generates:

- **Swagger UI:** `http://localhost:3000/api/docs`
- **Base URL (local):** `http://localhost:3000`

Every path below is relative to the base URL. All resource routes live under `/api`; the health check does not.

## Conventions

### Authentication

A global `AuthGuard` protects every route. Routes marked `@Public()` are the only exceptions. Send the access token as a Bearer header:

```http
Authorization: Bearer <accessToken>
```

| Token | Lifetime | Obtained from |
| --- | --- | --- |
| Access token | 15 minutes (`900s`) | `register`, `login`, `refresh` |
| Refresh token | 7 days | `register`, `login`, `refresh` |

The JWT payload carries `{ userId, role }`.

### Roles

| Role | Meaning |
| --- | --- |
| `SUPER_ADMIN` | Full platform access across all tenants |
| `ADMIN` | Platform staff with operational access |
| `MANAGER` | Salon owner/manager: manages their own salon |
| `CASHIER` | Front-desk staff: queue and bookings |
| `CLIENT` | End user who books services (default on registration) |

Source: [`src/common/constants/roles.constant.ts`](../atrio-backend/src/common/constants/roles.constant.ts)

### Pagination

List endpoints accept `?page=` (default `1`) and `?limit=` (default `10`) and return:

```json
{
  "data": [],
  "meta": { "page": 1, "limit": 10, "total": 0, "totalPages": 0 }
}
```

### Errors

A global exception filter normalizes errors. Validation failures (from the global `ValidationPipe`, which rejects unknown fields) return `message: "Validation failed"` with one entry per problem:

```json
{
  "message": "Validation failed",
  "errors": [{ "message": "email must be an email", "code": "VALIDATION_ERROR" }]
}
```

In production, unexpected exceptions are reduced to `"Internal server error"` and never include stack traces.

### Rate limiting

A global throttler applies three windows per client: **10 req/s**, **100 req/min**, and **1,000 req/h**.

## Endpoints

Legend: 🌐 public · 🔑 any authenticated user · otherwise the roles listed.

### Health

| Method | Path | Access | Description |
| --- | --- | --- | --- |
| `GET` | `/health` | 🌐 | Health check |

### Auth: `/api/auth`

| Method | Path | Access | Body | Description |
| --- | --- | --- | --- | --- |
| `POST` | `/api/auth/register` | 🌐 | `email`, `password`, `firstName?`, `lastName?`, `phone?` | Create a `CLIENT` account and return tokens |
| `POST` | `/api/auth/login` | 🌐 | `email`, `password` | Return `{ user, accessToken, refreshToken }` |
| `POST` | `/api/auth/refresh` | 🌐 | `refreshToken` | Rotate tokens |

The registration password must be 12–128 characters with upper case, lower case, a digit and a special character. Inactive users cannot log in.

```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"jane@example.com","password":"Str0ng#Password"}'
```

### Users: `/api/users`

| Method | Path | Access | Description |
| --- | --- | --- | --- |
| `POST` | `/api/users` | `SUPER_ADMIN`, `ADMIN` | Create a user |
| `GET` | `/api/users` | `SUPER_ADMIN`, `ADMIN` | List users (paginated) |
| `GET` | `/api/users/:id` | 🔑 | Get a user |
| `PATCH` | `/api/users/:id` | 🔑 | Update a user |
| `DELETE` | `/api/users/:id` | `SUPER_ADMIN` | Deactivate a user (`isActive = false`) |

### Salons: `/api/salons`

| Method | Path | Access | Description |
| --- | --- | --- | --- |
| `POST` | `/api/salons` | `SUPER_ADMIN`, `ADMIN` | Create a salon (`name`, `address?`, `phone?`, `email?`, `description?`, `imageUrl?`, `galleryUrls?`, `latitude?`, `longitude?`, `tags?`, `tier?`) |
| `GET` | `/api/salons` | 🔑 | List salons (paginated) |
| `GET` | `/api/salons/:id` | 🔑 | Get a salon |
| `PATCH` | `/api/salons/:id` | `SUPER_ADMIN`, `ADMIN`, `MANAGER` | Update a salon |
| `DELETE` | `/api/salons/:id` | `SUPER_ADMIN` | Soft-delete a salon |

### Services

| Method | Path | Access | Description |
| --- | --- | --- | --- |
| `POST` | `/api/salons/:salonId/services` | `SUPER_ADMIN`, `ADMIN`, `MANAGER` | Add a service to a salon |
| `GET` | `/api/salons/:salonId/services` | 🔑 | List a salon's services |
| `GET` | `/api/services/:id` | 🔑 | Get a service |
| `PATCH` | `/api/services/:id` | `SUPER_ADMIN`, `ADMIN`, `MANAGER` | Update a service |
| `DELETE` | `/api/services/:id` | `SUPER_ADMIN`, `ADMIN`, `MANAGER` | Soft-delete a service |

### Barbers

| Method | Path | Access | Description |
| --- | --- | --- | --- |
| `POST` | `/api/salons/:salonId/barbers` | `SUPER_ADMIN`, `ADMIN`, `MANAGER` | Add a barber to a salon |
| `GET` | `/api/salons/:salonId/barbers` | 🔑 | List a salon's barbers |
| `GET` | `/api/barbers/:id` | 🔑 | Get a barber |
| `PATCH` | `/api/barbers/:id` | `SUPER_ADMIN`, `ADMIN`, `MANAGER` | Update a barber |
| `DELETE` | `/api/barbers/:id` | `SUPER_ADMIN`, `ADMIN`, `MANAGER` | Soft-delete a barber |

### Bookings: `/api/bookings`

| Method | Path | Access | Description |
| --- | --- | --- | --- |
| `POST` | `/api/bookings` | 🔑 | Create a booking for the caller (`salonId`, `serviceId`, `barberId?`, `date`, `startTime`, `notes?`) |
| `GET` | `/api/bookings` | 🔑 | List bookings (paginated) |
| `GET` | `/api/bookings/:id` | 🔑 | Get a booking |
| `PATCH` | `/api/bookings/:id` | 🔑 | Update a booking |
| `POST` | `/api/bookings/:id/cancel` | 🔑 | Cancel a booking (optional `reason`) |

Booking status values: `pending`, `confirmed`, `completed`, `cancelled`, `rescheduled`.

### Reviews

| Method | Path | Access | Description |
| --- | --- | --- | --- |
| `POST` | `/api/salons/:salonId/reviews` | `CLIENT` | Review a salon (`rating`, `content?`, `barberId?`, `bookingId?`) |
| `GET` | `/api/salons/:salonId/reviews` | 🔑 | List a salon's reviews (paginated) |
| `GET` | `/api/reviews/:id` | 🔑 | Get a review |
| `PATCH` | `/api/reviews/:id/reply` | `SUPER_ADMIN`, `ADMIN`, `MANAGER` | Reply to a review |
| `PATCH` | `/api/reviews/:id/flag` | `SUPER_ADMIN`, `ADMIN` | Flag or unflag a review |
| `DELETE` | `/api/reviews/:id` | `SUPER_ADMIN`, `ADMIN` | Soft-delete a review |

### Audit log: `/api/audit-log`

| Method | Path | Access | Description |
| --- | --- | --- | --- |
| `GET` | `/api/audit-log` | `SUPER_ADMIN` | List audit entries (paginated) |

## Real-time (Socket.IO)

The server exposes a Socket.IO gateway on namespace **`/events`** (`websocket` and `polling` transports, CORS from `CORS_ORIGINS`). A Redis bridge backs it so events fan out across instances. On connection the server emits `connected`. Domain events (for example, live queue updates) are not defined yet.

Source: [`src/common/websockets/`](../atrio-backend/src/common/websockets/)

## Authorization gaps (known issues)

The role guards check **which role** a caller has, not **which resources they own**. Fix these before production:

| Endpoint | Issue |
| --- | --- |
| `PATCH /api/users/:id` | Any authenticated user can update any user. `UpdateUserDto` includes `role`, which allows privilege escalation (for example, setting your own role to `SUPER_ADMIN`). |
| `GET /api/users/:id` | Any authenticated user can read any user's profile. |
| `GET /api/bookings` | Not scoped by role: every authenticated user sees all bookings, even though Swagger says "filtered by role scope". |
| `PATCH /api/bookings/:id`, `POST /api/bookings/:id/cancel`, `GET /api/bookings/:id` | No ownership check: any authenticated user can read, change or cancel any booking. |
| `PATCH /api/salons/:id`, service/barber writes | A `MANAGER` is not restricted to their own salon. |

## Client compatibility

The mobile app's [`ApiEndpoints`](../atrio-mobile-app/lib/core/network/api_endpoints.dart) and the dashboard's [`ENDPOINTS`](../atrio-dashboard-admin/src/api/endpoints.ts) reference routes the backend does not implement yet:

- Auth: `/auth/forgot-password`, `/auth/send-otp`, `/auth/verify-otp`, `/auth/verify-phone-otp`, `/auth/logout`, `/auth/me`
- Mobile refresh uses `/auth/refresh-token`; the backend route is `/auth/refresh`
- Notes, tasks, `/settings/*`, plus the queue, loyalty, notification and chat resources

Set the clients' base URL to include the `/api` prefix (for example, `VITE_API_URL=http://localhost:3000/api`).
