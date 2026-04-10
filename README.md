# claude-webdev-setup

My personal Claude Code configuration for productive web development.

## What's Included

- **claude-webdev-plugin** — provides MCP servers, skills, agents and Spec-Driven Development workflow
- **frontend-design plugin** — `/frontend-design` skill for building polished web UIs (from `claude-plugins-official`)
- **Settings** — Prettier auto-formatting on stop, always-thinking mode, telemetry disabled, security deny-list for destructive commands and sensitive paths
- **Convention rules** (`.claude/rules/`) — coding standards that extend `CLAUDE.md`: base conventions (tech stack, code style, MCP servers, skills, agents), React component structure, and Prisma database conventions
- **Preferred tech stack** — Next.js, TypeScript (strict), Tailwind CSS, shadcn/ui, Prisma

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

This setup is optimized for the following technologies. They are configured as defaults in `.claude/CLAUDE.md` — not strict constraints.

- **Frameworks** — Next.js, React, Vite
- **Language** — TypeScript (strict mode)
- **Styling** — Tailwind CSS, shadcn/ui, tweakcn (themes)
- **Validation** — Zod
- **Testing** — Vitest, React Testing Library
- **Database** — Prisma
- **CMS** — Payload CMS
- **Package Manager** — pnpm
- **Deployment** — Docker or Vercel

## Author

Łukasz Warchoł

## License

MIT License - see [LICENSE](LICENSE) for details.
