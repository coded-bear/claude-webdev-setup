# Database Conventions (Prisma)

## Schema Conventions

- Place schema in `prisma/schema.prisma`
- Use camelCase for field names in the schema, but **explicitly** add `@map("snake_case_column")` to every field and `@@map("snake_case_table")` to every model — Prisma does not do this automatically
- Use `@id` with `@default(cuid(2))` for primary keys — globally unique and unguessable. If you need time-sortable IDs instead, use `uuid(7)` or `ulid()` (cuid2 is intentionally not sortable)
- Always add `createdAt` and `updatedAt` fields to every model:
  ```prisma
  createdAt DateTime @default(now()) @map("created_at")
  updatedAt DateTime @updatedAt      @map("updated_at")
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

Define these scripts in `package.json` once:

```json
"scripts": {
  "db:migrate": "prisma migrate dev",
  "db:push": "prisma db push",
  "db:seed": "prisma db seed",
  "postinstall": "prisma generate"
}
```

1. Edit `schema.prisma`
2. Run `pnpm db:migrate` (creates migration + applies it) for production-ready changes
3. Run `pnpm db:push` for rapid prototyping (no migration file created)

Both `db:migrate` and `db:push` regenerate Prisma Client automatically. The `postinstall` hook keeps types in sync after `git pull` / fresh installs — without it, a pulled schema change yields stale types until you remember to run `prisma generate`.

## Seeding

- Place seed script in `prisma/seed.ts`
- Configure in `package.json`: `"prisma": { "seed": "tsx prisma/seed.ts" }`
- Use `pnpm db:seed` to run

## Best Practices

- Never use raw SQL unless absolutely necessary — Prisma's query builder is type-safe
- Use transactions (`db.$transaction`) for operations that must be atomic
- Use Zod schemas that mirror Prisma models for API input validation
- **Serverless/edge deployments (Vercel) require a connection pooler** — Prisma Accelerate, Supabase Pooler, Neon, or PgBouncer. Without one, concurrent function instances exhaust the database connection limit under load.
- Soft delete (`deletedAt DateTime?`): if you use it, **every** query must include `where: { deletedAt: null }` — one forgotten filter and deleted records leak back to users. Prefer hard delete + audit log unless you have a concrete reason for soft delete.
