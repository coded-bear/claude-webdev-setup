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

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed
- [Node.js](https://nodejs.org/) 18 or higher
- npm (comes with Node.js)

## The `app/` Directory

The `app/` directory is the working directory where you create or clone web projects. It keeps project files separate from the configuration files in the repo root.

## Preferred Tech Stack

This setup is optimized for the following technologies. They are configured as defaults in `CLAUDE.md` — not strict constraints.

- **Frameworks** — Next.js, React, Vite
- **Language** — TypeScript (strict mode)
- **Styling** — Tailwind CSS, shadcn/ui
- **Testing** — React Testing Library
- **Database** — Prisma
- **CMS** — Payload CMS
- **Deployment** — Docker or Vercel

## MCP Servers

MCP servers are provided by the `claude-webdev-plugin` and are automatically available when you open Claude Code in this directory.

### Context7

Provides up-to-date documentation and code examples for any programming library or framework. Useful because Claude's training data has a cutoff date, so library APIs may have changed.

**Available tools:** `resolve-library-id`, `query-docs`

### Playwright

Browser automation for testing, scraping, and interacting with web pages. Allows Claude to control a browser, take screenshots, fill forms, click elements, and navigate websites.

**Available tools:** `browser_navigate`, `browser_click`, `browser_type`, `browser_snapshot`, `browser_take_screenshot`, and more.

### shadcn

UI component registry integration. Configured with [tweakcn.com](https://tweakcn.com) theme registry. Allows Claude to search, view, and install shadcn/ui components.

**Available tools:** `search_items_in_registries`, `view_items_in_registries`, `get_add_command_for_items`, and more.

## Skills

Skills are invoked with slash commands inside Claude Code.

- **`/frontend-design`** — Creates distinctive, production-grade frontend interfaces. Use when building web components, pages, or applications. Provided by the `frontend-design` plugin (`claude-plugins-official`).
- **`/content-write`** — Creates website content (copy, headlines, CTAs, meta tags) tailored to page type, industry, and target audience. Provided by `claude-webdev-plugin`.

## Agents

Agents are specialized sub-processes that handle specific tasks autonomously. They are provided by `claude-webdev-plugin`.

- **code-reviewer** — Reviews code quality, finds bugs, suggests improvements, checks patterns, and audits recent commits.
- **a11y-auditor** — Audits web pages and code for WCAG compliance and accessibility issues.
- **performance-reviewer** — Analyzes React/Next.js code for performance issues including unnecessary re-renders, bundle size, and data fetching patterns.
- **content-auditor** — Audits website content for language errors, tone consistency, SEO issues, and accessibility.

## Settings

Configured in `.claude/settings.json`:

### Security Deny Rules

Blocks destructive and sensitive commands:

- **Destructive commands** — `rm -rf`, `sudo`, `mkfs`, `dd`, `git push --force`, `git reset --hard`
- **Pipe-to-shell** — `curl | bash`, `wget | bash`
- **Shell config edits** — `~/.bashrc`, `~/.zshrc`
- **Credential file access** — `~/.ssh/`, `~/.aws/`, `~/.gnupg/`, `~/.git-credentials`, `~/.docker/config.json`, `~/.npmrc`, `~/.pypirc`, and more

### Prettier Hook

Prettier runs automatically via a Stop hook whenever Claude finishes a response. All code in the working directory gets formatted with `npx prettier --write .`.

### Plugins

Two plugins are enabled in `enabledPlugins`:

- **`frontend-design`** — provides the `/frontend-design` skill
  - Marketplace: `anthropics/claude-plugins-official` (official, available by default)
  - Install: `/plugin install frontend-design@claude-plugins-official`
- **`claude-webdev-plugin`** — provides MCP servers, `/content-write` skill, and agents
  - Marketplace: `coded-bear/claude-webdev-plugin` (custom, must be added first)
  - Add marketplace: `/plugin marketplace add coded-bear/claude-webdev-plugin`
  - Install: `/plugin install claude-webdev-plugin@claude-webdev-plugin`

### Extended Thinking

`alwaysThinkingEnabled` is set to `true` so Claude uses extended thinking for deeper reasoning on every request.

### Project MCP Servers

`enableAllProjectMcpServers` is set to `false` — MCP servers from `.mcp.json` files are not auto-approved. Servers are provided through the plugin instead.

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
├── LICENSE                     # MIT License
└── .gitignore                  # Git ignore rules
```

## Configuration Files

### .claude/settings.json

Shared project settings committed to the repo. Contains security deny rules, hooks, plugin configuration (`enabledPlugins`), environment variables, and `enableAllProjectMcpServers` flag. These apply to anyone who clones the repository.

### .claude/settings.local.json

Local permissions for Claude Code. This file contains machine-specific overrides and is not meant to be shared (path-specific).

### CLAUDE.md

Instructions that Claude Code reads when working in this repository. Contains guidelines for development workflows, available tools, and tech stack preferences.

## Author

Lukasz Warchol

## License

MIT License - see [LICENSE](LICENSE) for details.
