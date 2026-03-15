# CLAUDE.md

This repository contains personal Claude Code configuration files for web development workflows. All configuration files are stored in the `.claude/` directory. Application code lives directly in the project root.

## Available MCP Servers (from `claude-webdev-plugin`)

- **Context7** - Up-to-date documentation for libraries/frameworks. Use when implementing new features or external APIs.
- **Playwright** - Browser automation for testing, scraping, screenshots, and UI verification.
- **shadcn** — UI component registry, configured with tweakcn.com theme registry (`REGISTRY_URL`)

## Available Skills

- **/frontend-design** - Creates distinctive, production-grade frontend interfaces. Use this skill when building web components, pages, or applications to produce polished, creative output.
- **/content-write** (from `claude-webdev-plugin`) - Creates website content (copy, headlines, CTAs, meta tags) tailored to page type, industry, and audience. Use this skill when writing text content for web pages.

## Available Agents

Delegate to agents via Task tool. Use foreground for URL audits (needs Playwright), background for file-based work.

- **content-auditor** — Audits content for language, tone, SEO, and accessibility issues.
- **performance-reviewer** — Finds React/Next.js performance issues (re-renders, bundle size, data fetching).
- **a11y-auditor** — Audits for WCAG compliance and accessibility barriers.
- **code-reviewer** — Reviews code quality, finds bugs, checks patterns, audits commits.

## Tech Stack

These are the preferred technologies for new projects. They are not strict constraints — use judgment based on project needs.

### Frameworks & Build Tools

- Next.js, React, Vite
- TypeScript in strict mode — never use `// @ts-ignore` or `as any`
- Never use the `any` type — use `unknown`, generics, or proper type narrowing instead
- Prefer `@ts-expect-error` over `@ts-ignore` only when suppression is truly necessary (with explanatory comment)
- Use App Router (not Pages Router) for new Next.js projects
- Prefer React Server Components by default — add `"use client"` only when using hooks, event handlers, or browser APIs
- Never use `useEffect` to compute derived state — use `useMemo` or compute inline during render
- Use Server Actions for mutations; Route Handlers (`app/api/`) only for webhooks or external API endpoints

### Styling & UI

- Tailwind CSS
- shadcn/ui
- Theme configuration: https://tweakcn.com or custom themes

### Testing

- React Testing Library + Vitest
- IMPORTANT: YOU MUST write unit tests for every component and utility function
- Test user behavior, not implementation details (no testing internal state or private methods)

### Data Validation

- Use Zod for runtime validation and type inference (`z.infer<typeof schema>`)
- Use Zod schemas for validating API inputs and form data

### Database & CMS

- Prisma (database adapter) — see @.claude/rules/database-conventions.md for detailed conventions
- Payload CMS (when a CMS is needed)

### Package Manager

- pnpm — use `pnpm` for all install/run commands
- Always use `pnpm dlx` instead of `npx`

### Common Commands <!-- Adjust per project -->

- `pnpm dev` / `pnpm build` — dev server / production build
- `pnpm test` / `pnpm test:watch` — run tests (Vitest)
- `pnpm lint` — run ESLint
- `pnpm db:push` / `pnpm db:migrate` / `pnpm db:seed` — Prisma database commands

### Deployment: Docker or Vercel

### Preferred Libraries

When choosing libraries for common tasks, prefer these unless the project already uses alternatives:

- Forms: React Hook Form + Zod resolver
- Animations/transitions: Framer Motion
- Icons: Lucide React
- Date handling: date-fns
- Data fetching (when client-side needed): TanStack Query
- Tables: TanStack Table
- Toast notifications: Sonner
- Email: React Email + Resend

## Code Conventions

### Naming Conventions

- Files: PascalCase for components (`UserProfile.tsx`), camelCase for utilities (`formatDate.ts`), kebab-case for non-component directories (`user-profile/`)
- Named exports for all components and utilities — default exports only for Next.js pages/layouts/route handlers (required by framework)
- Variables/functions: camelCase; types/interfaces: PascalCase; constants: UPPER_SNAKE_CASE

### Component Structure

@.claude/rules/component-conventions.md

### Imports

- Use `@/` path alias for absolute imports from project root
- Import order: external packages → internal modules (`@/`) → relative imports → styles; separated by blank lines

## Development Guidelines

### Before Starting New Features

1. Check existing components in `components/` and `features/` — reuse before creating new
2. Look up documentation via Context7 for unfamiliar APIs
3. After implementation: write tests, then delegate to **a11y-auditor**
4. For auth/data features: delegate to **code-reviewer**

### Working Directory

Application code lives directly in the project root. Create and develop web projects here.

### Code Formatting & Visual Verification

- Prettier runs automatically when Claude stops (Stop hook). No need to run it manually.
- Never run Playwright unless explicitly asked by the user.

### State Management

- Local state (`useState`) for component-scoped state
- React Context for shared UI state (theme, sidebar open/close)
- Server state via React Server Components + Server Actions — avoid client-side fetching libraries unless necessary

### Error Handling

- Wrap page-level components with React Error Boundaries
- Use Next.js `error.tsx` and `not-found.tsx` conventions
- API routes: return structured error responses `{ error: string, status: number }`

### SEO & Metadata

- Use Next.js Metadata API (`generateMetadata` / `metadata` export) — not manual `<head>` tags
- Every page must have unique `title` and `description`
- Include Open Graph (`og:title`, `og:description`, `og:image`) for shareable pages
- Use semantic heading hierarchy (single `h1` per page, sequential `h2` -> `h3`)
- Add `robots.txt` and `sitemap.xml` via Next.js conventions (`app/robots.ts`, `app/sitemap.ts`)

### Performance

- Use `next/image` with appropriate `sizes` prop instead of `<img>` for automatic optimization
- Lazy-load heavy client components with `next/dynamic` (charts, editors, maps)
- Use `loading.tsx` for streaming/suspense boundaries
- Avoid barrel files (`index.ts` re-exporting everything) in large feature directories — they break tree-shaking (individual component `index.ts` re-exports are fine)

### Dependency Policy

- Prefer existing dependencies over adding new ones — check `package.json` first
- Avoid large utility libraries (lodash, moment) — use native JS or lightweight alternatives
- Before adding a package, verify: bundle size, maintenance status, TypeScript support

### Environment Variables

- Use `.env` for local secrets (never commit — must be in `.gitignore`)
- Prefix client-side variables with `NEXT_PUBLIC_`
- Document required env vars in `.env.example`

### Git Conventions

- Commit messages: Conventional Commits format (`feat:`, `fix:`, `chore:`, `docs:`, `refactor:`, `test:`)
- Commits in English
- Branch naming: `feat/short-description`, `fix/short-description`
- Never create branches, commit, or push changes unless explicitly asked by the user

### Common Gotchas

- `"use client"` is contagious — if a parent is a Client Component, all children are too. Keep client boundaries as low as possible.
- Next.js caches aggressively — use `revalidatePath()` / `revalidateTag()` after mutations
- Tailwind classes are purged at build time — never construct classes dynamically (`bg-${color}-500`). Use complete class names or `clsx`/`cva`.
- Server Actions can only be called from Client Components — but can be defined in Server Component files
- `next/image` requires explicit `width` and `height` (or `fill` with a sized parent)

### IMPORTANT: Accessibility (WCAG 2.2 AA)

- Use semantic HTML elements (`button`, `nav`, `main`, `section`) — never `div`/`span` with click handlers
- All interactive elements must be keyboard accessible with visible focus indicators
- Images require descriptive `alt` text (decorative images use `alt=""`)
- Form inputs must have associated `<label>` elements — not just placeholders
- Color contrast: 4.5:1 for normal text, 3:1 for large text

### IMPORTANT: Security

- Never hardcode secrets, API keys, or credentials — always use `process.env`
- Validate and sanitize all user inputs on both client and server
- Use parameterized queries for database access (Prisma handles this by default)
- Configure security headers (CSP, X-Frame-Options, X-Content-Type-Options) in Next.js `next.config`
- Never use `dangerouslySetInnerHTML` with unsanitized data

### IMPORTANT: File Size & Modularity

- Maximum ~150 lines per file — split into modules when exceeded
- One component per file; extract sub-components, hooks, and utilities into separate files
- Group related code in feature directories (`features/auth/`, `features/dashboard/`)
- Separate concerns: API calls, business logic, and UI in distinct files
