#!/bin/bash

# MCP Servers Installation Script for Claude Code
# This script installs Context7 and Playwright MCP servers

set -e

echo "================================"
echo "MCP Servers Installation Script"
echo "================================"
echo ""

# Check for Claude CLI
if ! command -v claude &> /dev/null; then
    echo "Error: Claude CLI is not installed."
    echo "Please install Claude Code first: https://docs.anthropic.com/en/docs/claude-code"
    exit 1
fi

echo "Claude CLI found."

# Check for Node.js
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is not installed."
    echo "Please install Node.js 18+ first: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "Error: Node.js 18+ is required. Current version: $(node -v)"
    exit 1
fi

echo "Node.js $(node -v) found."
echo ""

# Ask for confirmation
echo "This script will install the following MCP servers:"
echo "  - Context7: Up-to-date documentation lookup for libraries"
echo "  - Playwright: Browser automation and testing"
echo ""
read -p "Do you want to continue? (y/N) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "Installing MCP servers..."
echo ""

# Install Context7
echo "[1/2] Installing Context7..."
claude mcp add --transport http context7 https://mcp.context7.com/mcp
echo "Context7 installed successfully."
echo ""

# Install Playwright
echo "[2/2] Installing Playwright..."
claude mcp add playwright -- npx @playwright/mcp@latest
echo "Playwright installed successfully."
echo ""

echo "================================"
echo "Installation Complete!"
echo "================================"
echo ""
echo "To verify the installation, run Claude Code and use:"
echo "  /mcp"
echo ""
echo "This will show all configured MCP servers."
echo ""
echo "Available tools after installation:"
echo "  - Context7: resolve-library-id, query-docs"
echo "  - Playwright: browser_navigate, browser_click, browser_snapshot, etc."
