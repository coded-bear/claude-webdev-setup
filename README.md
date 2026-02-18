# claude-webdev-setup

My personal Claude Code configuration for productive web development.

## What's Included

- **MCP Servers** — Context7 (documentation lookup) and Playwright (browser automation)
- **frontend-design plugin** — `/frontend-design` skill for building polished web UIs
- **Prettier hook** — auto-formats code when Claude stops
- **Security deny rules** — blocks destructive commands and credential file access
- **Preferred tech stack** — Next.js, TypeScript (strict), Tailwind CSS, shadcn/ui, Prisma
- **Extended thinking** — always enabled for deeper reasoning

## Quick Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/claude-webdev-setup.git
   cd claude-webdev-setup
   ```

2. **Install MCP servers:**

   ```bash
   chmod +x install-mcp.sh
   ./install-mcp.sh
   ```

3. **Verify installation:**
   ```bash
   claude
   # Then type: /mcp
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

This repository configures two MCP (Model Context Protocol) servers that extend Claude Code capabilities.

### Context7

**Purpose:** Provides up-to-date documentation and code examples for any programming library or framework.

**Why use it:** Claude's training data has a cutoff date, so library APIs may have changed. Context7 fetches current documentation to ensure accurate, working code.

**Installation:**

```bash
claude mcp add --transport http context7 https://mcp.context7.com/mcp
```

**Usage in Claude Code:**

- Ask Claude to look up documentation for any library
- Claude will automatically use `resolve-library-id` and `query-docs` tools
- Example: "How do I use React Query's useQuery hook?"

**Available tools:**

- `resolve-library-id` - Find the correct library ID
- `query-docs` - Query documentation for a specific library

### Playwright

**Purpose:** Browser automation for testing, scraping, and interacting with web pages.

**Why use it:** Allows Claude to control a browser, take screenshots, fill forms, click elements, and navigate websites.

**Installation:**

```bash
claude mcp add playwright -- npx @playwright/mcp@latest
```

**Usage in Claude Code:**

- Ask Claude to navigate to a website
- Take screenshots of pages
- Fill forms and click buttons
- Extract data from web pages

**Available tools:**

- `browser_navigate` - Go to a URL
- `browser_click` - Click elements
- `browser_type` - Type text into fields
- `browser_snapshot` - Capture accessibility tree
- `browser_take_screenshot` - Take page screenshots
- And many more...

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

### frontend-design Plugin

The `frontend-design` plugin is enabled, providing the `/frontend-design` skill for building production-grade, polished web interfaces.

### Extended Thinking

`alwaysThinkingEnabled` is set to `true` so Claude uses extended thinking for deeper reasoning on every request.

## Repository Structure

```
claude-webdev-setup/
├── app/                        # Working directory for web projects
│   └── .gitkeep
├── .claude/
│   ├── settings.json           # Shared Claude Code settings (security, hooks, plugins)
│   └── settings.local.json     # Local Claude Code permissions (not shared)
├── .mcp.json                   # Project-level MCP server configuration
├── CLAUDE.md                   # Instructions for Claude Code
├── README.md                   # This file
├── install-mcp.sh              # MCP servers installation script
├── LICENSE                     # MIT License
└── .gitignore                  # Git ignore rules
```

## Configuration Files

### .mcp.json

Project-level MCP configuration. When you open Claude Code in this directory, these servers are automatically available. This file can be committed to share MCP configuration with your team.

### .claude/settings.json

Shared project settings committed to the repo. Contains security deny rules, hooks, plugin configuration, and environment variables. These apply to anyone who clones the repository.

### .claude/settings.local.json

Local permissions for Claude Code. This file contains machine-specific overrides and is not meant to be shared (path-specific).

### CLAUDE.md

Instructions that Claude Code reads when working in this repository. Contains guidelines for development workflows.

## Author

Lukasz Warchol

## License

MIT License - see [LICENSE](LICENSE) for details.
