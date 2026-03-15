# Database Conventions (Prisma)

## Schema Conventions

- Place schema in `prisma/schema.prisma`
- Use camelCase for field names — Prisma maps to snake_case with `@map`
- Use `@id` with `@default(cuid())` for primary keys (prefer CUID over UUID for sortability)
- Always add `createdAt` and `updatedAt` fields to every model:
  ```prisma
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  ```
- Use explicit relation names when a model has multiple relations to the same table
- Add `@@index` for fields frequently used in `where` clauses

## Naming

- Models: PascalCase singular (`User`, `Post`, `OrderItem`)
- Enums: PascalCase with UPPER_SNAKE_CASE values
- Relations: descriptive names (`author`, `posts`, `orderItems`)

## Client Usage

- Create a single shared Prisma client instance in `lib/db.ts`:

  ```typescript
  import { PrismaClient } from "@prisma/client";

  const globalForPrisma = globalThis as unknown as { prisma: PrismaClient };

  export const db = globalForPrisma.prisma || new PrismaClient();

  if (process.env.NODE_ENV !== "production") globalForPrisma.prisma = db;
  ```

- Import as `db` (not `prisma`) for clarity: `import { db } from "@/lib/db"`
- Use `select` or `include` explicitly — avoid fetching entire records when only a few fields are needed

## Migration Workflow

1. Edit `schema.prisma`
2. Run `pnpm db:migrate` (creates migration + applies it) for production-ready changes
3. Run `pnpm db:push` for rapid prototyping (no migration file created)
4. After schema changes, Prisma Client regenerates automatically

## Seeding

- Place seed script in `prisma/seed.ts`
- Configure in `package.json`: `"prisma": { "seed": "tsx prisma/seed.ts" }`
- Use `pnpm db:seed` to run

## Best Practices

- Never use raw SQL unless absolutely necessary — Prisma's query builder is type-safe
- Use transactions (`db.$transaction`) for operations that must be atomic
- Use Zod schemas that mirror Prisma models for API input validation
- Soft delete pattern: add `deletedAt DateTime?` field instead of hard deleting records
