# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## /init Instruction

When running `/init`, first read all files in `.claude/rules/` — they define conventions that MUST NOT be repeated in CLAUDE.md. Specifically, rules already cover:

- **Tech stack, preferred libraries, package manager** (`base.conventions.md`)
- **Code style**: naming, imports, file size limits, export patterns (`base.conventions.md`)
- **Component structure**: folder convention, categories, index re-exports (`component-conventions.md`)
- **Database**: Prisma schema, client, migrations, seeding (`database-conventions.md`)
- **Development guidelines**: state management, error handling, SEO, performance, dependency policy, env vars, git conventions (`base.conventions.md`)
- **Security, accessibility, common gotchas** (`base.conventions.md`)
- **MCP servers, skills, agents** (`base.conventions.md`)

CLAUDE.md should only contain project-specific information: setup steps, commands, architecture, data flows, and integration details.

## Repository Purpose

This is a **configuration-only repository** — it contains no application code. It provides a reusable Claude Code setup (settings, rules, plugins, hooks) for web development projects.

The intended workflow: clone this repo, then build the web application **directly in the project root** (no nested `app/` directory). The `.claude/` folder travels with the project and drives Claude Code's behavior.

## Repository Structure

```
.claude/
├── CLAUDE.md                  # This file — meta-guidance and pointers
├── settings.json              # Shared (hooks, permissions, enabled plugins, env)
├── settings.local.json        # Local overrides — GITIGNORED, never commit
└── rules/
    ├── base.conventions.md            # Tech stack, code conventions, MCP/skills/agents
    ├── component-conventions.md       # React component folder/file structure
    └── database-conventions.md        # Prisma schema, client, migrations
.gitignore
LICENSE
README.md                      # Human-facing setup guide
```

CLAUDE.md lives under `.claude/` (not repo root) intentionally — all Claude Code configuration is colocated there. Do not move it back to the root.

## Where conventions live

**Do not add tech stack, coding, component, or database rules to this file.** They belong in `.claude/rules/*.md`, which `base.conventions.md` imports via `@.claude/rules/...` references. Adding the same information here creates drift.

When you need a new project-wide rule, edit the matching file in `.claude/rules/`. Create a new rules file only if the topic doesn't fit any existing one.

## Plugin Setup

`settings.json` enables plugins but doesn't install them. Run once per machine:

```
/plugin marketplace add coded-bear/claude-webdev-plugin
/plugin install claude-webdev-plugin@claude-webdev-plugin
/plugin install frontend-design@claude-plugins-official
```

To refresh a plugin after the author publishes a new version, run `/plugin marketplace update <name>` — `/plugin marketplace add` is a no-op for already-added marketplaces and will not fetch new versions.

After installing, verify with `/plugin list` and `/mcp` — both plugins should appear enabled and the `claude-webdev-plugin` MCP servers (Context7, Playwright, shadcn) should be connected.

## Hooks

A Stop hook in `settings.json` runs `npx prettier --write .` at the end of every turn. Do not run Prettier manually, and do not disable this hook without asking — it's the project's auto-formatting contract.

## Local overrides

`.claude/settings.local.json` is gitignored and holds per-developer permissions and disabled MCP servers. Never commit it, and never move its contents into `settings.json`.
