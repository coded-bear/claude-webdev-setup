# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository contains personal Claude Code configuration files for web development workflows. Configuration files are stored in the `.claude/` directory. Web projects live in the `app/` directory.

## Available MCP Servers

This repository is configured with the following MCP servers:

- **Context7** - Fetches up-to-date documentation for libraries and frameworks. Use it when implementing new features or working with external APIs.
- **Playwright** - Browser automation for testing and web interactions. Use it for scraping, form filling, screenshots, and UI testing.

## Available Skills

- **/frontend-design** - Creates distinctive, production-grade frontend interfaces. Use this skill when building web components, pages, or applications to produce polished, creative output.
- **/content-write** - Creates website content (copy, headlines, CTAs, meta tags) tailored to page type, industry, and audience. Use this skill when writing text content for web pages.
- **/content-audit** - Audits website content for language errors, tone consistency, SEO issues, and accessibility. Use this skill to review existing content, whether written by humans or AI.

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

- React Testing Library
- Full test coverage for business logic

### Database & CMS

- Prisma (database adapter)
- Payload CMS (when a CMS is needed)

### Deployment

- Docker or Vercel

## Development Guidelines

### Working Directory

The `app/` directory is where web projects are created and developed. Use it as the base for any new project work.

### Documentation Lookup

Use Context7 to check up-to-date documentation when implementing new libraries or frameworks, or adding features using them. This ensures working with current API patterns rather than potentially outdated knowledge.

### Code Formatting

Prettier runs automatically when Claude stops (configured as a Stop hook). Code will be auto-formatted, so there is no need to run Prettier manually.

### Visual Verification

Use Playwright to take screenshots and verify UI changes visually. This is especially useful after making styling or layout changes to confirm the result matches expectations.
