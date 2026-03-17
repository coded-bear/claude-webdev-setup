# CLAUDE.md

This is a **configuration-only repository** — it contains no application code. It provides a reusable Claude Code setup (settings, rules, plugins, hooks) for web development projects. When starting a new web project, application code is created directly in the project root.

## /init Instruction

When running `/init`, first read the contents of all files in `.claude/rules/` to understand what conventions are already defined. Do not duplicate any information that exists in rules files.

## Repository Structure

```
.claude/
├── CLAUDE.md                           # This file — top-level guidance
├── settings.json                       # Shared settings (hooks, permissions, plugins, env)
├── settings.local.json                 # Local overrides (personal permissions, disabled MCP servers)
└── rules/
    ├── base.conventions.md             # Tech stack, code conventions, dev guidelines
    ├── component-conventions.md        # React component folder/file structure
    └── database-conventions.md         # Prisma schema, client, and migration conventions
```

## Plugin Setup

Plugins must be installed before use (settings.json enables them but doesn't install them):

```
/plugin marketplace add coded-bear/claude-webdev-plugin
/plugin install claude-webdev-plugin@claude-webdev-plugin
/plugin install frontend-design@claude-plugins-official
```
