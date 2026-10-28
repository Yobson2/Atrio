# Atrio Backend

REST + WebSocket API for [Atrio](../README.md), the salon booking and live-queue platform. It is a NestJS modular monolith covering auth, users, salons, services, barbers, bookings, reviews and an audit log.

> Endpoint reference with role requirements: [docs/API.md](../docs/API.md) · Deployment: [docs/DEPLOYMENT.md](../docs/DEPLOYMENT.md#backend-api)

## Tech Stack

- **NestJS 11** — TypeScript framework
- **TypeORM + PostgreSQL 16** — Database ORM with auto-sync in development, migration CLI for production
- **Redis (ioredis)** — Caching and pub/sub
- **BullMQ** — Background job queues
- **JWT** — Authentication with access + refresh tokens
- **Socket.IO** — WebSocket gateway with Redis bridge
- **S3 Storage** — MinIO (dev) / DigitalOcean Spaces / AWS S3
- **Firebase Admin** — Push notifications
- **Nodemailer + Handlebars** — Email templating
- **Swagger** — Auto-generated API documentation
- **Docker** — PostgreSQL, Redis, MinIO, Adminer

## Quick Start

```bash
# 1. Install dependencies
yarn install

# 2. Create environment file
cp .env.example .env

# 3. Start infrastructure (PostgreSQL, Redis, MinIO)
docker compose up -d

# 4. Start the application
yarn start:dev

# 5. Open Swagger docs
open http://localhost:3000/api/docs
```

## Project Structure

```
src/
├── main.ts                        # Bootstrap (Helmet, CORS, Swagger, Validation)
├── app.module.ts                  # Root module
├── common/                        # Shared infrastructure
│   ├── config/                    # Environment loader (Docker-aware)
│   ├── database/                  # TypeORM config, BaseEntity
│   ├── redis/                     # Redis provider (TLS-aware)
│   ├── storage/                   # S3-compatible storage
│   ├── firebase/                  # Push notifications
│   ├── mail/                      # Email with Handlebars templates
│   ├── websockets/                # WebSocket gateway + Redis bridge
│   ├── queues/                    # BullMQ configuration
│   ├── constants/                 # Error codes, roles
│   ├── decorators/                # @GetUser, @Roles, @Public
│   ├── dto/                       # Pagination DTOs
│   ├── exceptions/                # Domain exceptions
│   ├── filters/                   # Global exception filter
│   ├── guards/                    # Auth guard, Roles guard
│   ├── middleware/                # JWT authentication
│   └── utils/                     # Error context utility
├── modules/
│   ├── auth/                      # JWT auth (register, login, refresh)
│   ├── users/                     # User management
│   ├── salons/                    # Salons
│   ├── services/                  # Salon service catalog
│   ├── barbers/                   # Barbers / staff
│   ├── bookings/                  # Booking lifecycle
│   ├── reviews/                   # Reviews, replies, moderation
│   ├── audit-log/                 # Immutable activity trail
│   └── health/                    # Health check endpoint
templates/                         # Handlebars email templates
```

## Available Scripts

```bash
yarn start:dev       # Development with hot-reload
yarn build           # Compile TypeScript
yarn start:prod      # Run compiled app
yarn test            # Unit tests
yarn test:watch      # Tests in watch mode
yarn test:cov        # Test coverage
yarn test:e2e        # End-to-end tests
yarn lint            # ESLint
yarn format          # Prettier
yarn migration:generate  # Generate a TypeORM migration from entity changes
yarn migration:run       # Apply pending migrations
yarn migration:revert    # Revert the last migration
```

## Docker

```bash
docker compose up -d      # Start PostgreSQL + Redis + MinIO + Adminer
docker compose down        # Stop all
docker compose logs -f     # View logs
```

| Service | URL |
|---------|-----|
| PostgreSQL | `localhost:5432` |
| Redis | `localhost:6379` |
| MinIO Console | `http://localhost:9001` |
| Adminer | `http://localhost:8080` |

## API Endpoints

| Resource | Paths |
|----------|-------|
| Health | `GET /health` (public) |
| Auth | `POST /api/auth/{register,login,refresh}` (public) |
| Users | `/api/users`, `/api/users/:id` |
| Salons | `/api/salons`, `/api/salons/:id` |
| Services | `/api/salons/:salonId/services`, `/api/services/:id` |
| Barbers | `/api/salons/:salonId/barbers`, `/api/barbers/:id` |
| Bookings | `/api/bookings`, `/api/bookings/:id`, `POST /api/bookings/:id/cancel` |
| Reviews | `/api/salons/:salonId/reviews`, `/api/reviews/:id`, `/reply`, `/flag` |
| Audit log | `GET /api/audit-log` (super admin) |

Roles: `SUPER_ADMIN`, `ADMIN`, `MANAGER`, `CASHIER`, `CLIENT`. The full method-by-role table and known authorization gaps are in [docs/API.md](../docs/API.md).

## Adding a New Module

```bash
# 1. Generate the module
nest generate module modules/products
nest generate controller modules/products
nest generate service modules/products

# 2. Create entity extending BaseEntity
# src/modules/products/entities/product.entity.ts

# 3. Register in module with TypeOrmModule.forFeature([Product])

# 4. Import the module in app.module.ts
```

### Entity Pattern

```typescript
import { Entity, Column } from 'typeorm';
import { BaseEntity } from '@common/database/base.entity';

@Entity('products')
export class Product extends BaseEntity {
  @Column()
  name: string;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  price: number;

  @Column({ default: true })
  isActive: boolean;
}
```

### Protecting Routes

```typescript
import { Public } from '@common/decorators/public.decorator';
import { Roles } from '@common/decorators/roles.decorator';
import { UserRole } from '@common/constants/roles.constant';

@Public()           // Skip authentication
@Roles(UserRole.ADMIN)  // Require admin role
```

## Environment Variables

See [.env.example](.env.example) for all available variables.

Key variables:
- `DB_*` — PostgreSQL connection
- `JWT_SECRET` / `JWT_REFRESH_SECRET` — Token signing
- `REDIS_*` — Redis connection
- `S3_*` — Object storage
- `FIREBASE_*` — Push notifications
- `MAIL_*` — SMTP email

## Production Build

```bash
# Build Docker image
docker build -t atrio-backend .

# Run container (env vars are injected at runtime; .env is not read inside Docker)
docker run -p 3000:3000 --env-file .env atrio-backend
```

## License

MIT
