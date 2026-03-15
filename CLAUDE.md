# CLAUDE.md

This repository contains personal Claude Code configuration files for web development workflows. Configuration files are stored in the `.claude/` directory. Web projects live in the `app/` directory.

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

### Styling & UI

- Tailwind CSS
- shadcn/ui
- Theme configuration: https://tweakcn.com or custom themes

### Testing

- React Testing Library + Vitest
- IMPORTANT: YOU MUST write unit tests for every component and utility function
- Place test files next to source files (`Button.test.tsx` beside `Button.tsx`)
- Test user behavior, not implementation details (no testing internal state or private methods)

### Database & CMS

- Prisma (database adapter)
- Payload CMS (when a CMS is needed)

### Deployment

- Docker or Vercel

## Development Guidelines

### Working Directory

The `app/` directory is where web projects are created and developed. Use it as the base for any new project work.

### Documentation Lookup

Use Context7 to check up-to-date documentation when implementing or adding features with external libraries/frameworks.

### Code Formatting

Prettier runs automatically when Claude stops (Stop hook). No need to run it manually.

### Visual Verification

Use Playwright to take screenshots and verify UI changes visually after styling or layout modifications.

### IMPORTANT: Accessibility (WCAG 2.2 AA)

- Use semantic HTML elements (`button`, `nav`, `main`, `section`) — never `div`/`span` with click handlers
- All interactive elements must be keyboard accessible with visible focus indicators
- Images require descriptive `alt` text (decorative images use `alt=""`)
- Form inputs must have associated `<label>` elements — not just placeholders
- Color contrast: 4.5:1 for normal text, 3:1 for large text
- After building or modifying UI components, automatically delegate to **a11y-auditor**

### IMPORTANT: Security

- Never hardcode secrets, API keys, or credentials — always use `process.env`
- Validate and sanitize all user inputs on both client and server
- Use parameterized queries for database access (Prisma handles this by default)
- Configure security headers (CSP, X-Frame-Options, X-Content-Type-Options) in Next.js `next.config`
- Never use `dangerouslySetInnerHTML` with unsanitized data
- After implementing features involving auth or data handling, automatically delegate to **code-reviewer**

### IMPORTANT: File Size & Modularity

- Maximum ~150 lines per file — split into modules when exceeded
- One component per file; extract sub-components, hooks, and utilities into separate files
- Group related code in feature directories (`features/auth/`, `features/dashboard/`)
- Separate concerns: API calls, business logic, and UI in distinct files
