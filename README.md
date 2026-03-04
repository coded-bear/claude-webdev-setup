# claude-webdev-setup

My personal Claude Code configuration for productive web development.

## What's Included

- **claude-webdev-plugin** — provides MCP servers (Context7, Playwright, shadcn), skills (`/content-write`), and agents (code-reviewer, a11y-auditor, performance-reviewer, content-auditor)
- **frontend-design plugin** — `/frontend-design` skill for building polished web UIs (from `claude-plugins-official`)
- **Prettier hook** — auto-formats code when Claude stops
- **Security deny rules** — blocks destructive commands and credential file access
- **Preferred tech stack** — Next.js, TypeScript (strict), Tailwind CSS, shadcn/ui, Prisma
- **Extended thinking** — always enabled for deeper reasoning

## Quick Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/coded-bear/claude-webdev-setup.git
   cd claude-webdev-setup
   ```

2. **Install plugins** (inside Claude Code):

   ```
   /plugin marketplace add coded-bear/claude-webdev-plugin
   /plugin install claude-webdev-plugin@claude-webdev-plugin
   /plugin install frontend-design@claude-plugins-official
   ```

   The `settings.json` file enables these plugins, but they must be installed first. `frontend-design` comes from the official marketplace (available by default). `claude-webdev-plugin` requires adding a custom marketplace first.

3. **Verify setup:**
   ```
   /plugin list
   /mcp
   ```

## Preferred Tech Stack

This setup is optimized for the following technologies. They are configured as defaults in `CLAUDE.md` — not strict constraints.

- **Frameworks** — Next.js, React, Vite
- **Language** — TypeScript (strict mode)
- **Styling** — Tailwind CSS, shadcn/ui
- **Testing** — React Testing Library
- **Database** — Prisma
- **CMS** — Payload CMS
- **Deployment** — Docker or Vercel

## Repository Structure

```
claude-webdev-setup/
├── app/                        # Working directory for web projects
│   └── .gitkeep
├── .claude/
│   ├── settings.json           # Shared Claude Code settings (security, hooks, plugins)
│   └── settings.local.json     # Local Claude Code permissions (not shared)
├── CLAUDE.md                   # Instructions for Claude Code
├── README.md                   # This file
├── LICENSE                     # License
└── .gitignore                  # Git ignore rules
```

## Author

Lukasz Warchol

## License

MIT License - see [LICENSE](LICENSE) for details.
