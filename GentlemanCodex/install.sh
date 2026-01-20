#!/bin/bash
# GentlemanCodex Installation Script for Linux/macOS
# Installs and configures OpenAI Codex CLI with Gentleman settings

set -e

echo -e "\033[36mInstalling GentlemanCodex...\033[0m"

# Check if npm is available
if ! command -v npm &> /dev/null; then
    echo -e "\033[31mError: npm is not installed. Please install Node.js first.\033[0m"
    exit 1
fi

# Install Codex CLI globally
echo -e "\033[33mInstalling Codex CLI...\033[0m"
npm install -g @openai/codex

# Create config directory if it doesn't exist
CODEX_CONFIG_DIR="$HOME/.codex"
mkdir -p "$CODEX_CONFIG_DIR"

# Copy config.toml
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/config.toml" "$CODEX_CONFIG_DIR/config.toml"

echo -e "\033[32mCodex config installed to: $CODEX_CONFIG_DIR/config.toml\033[0m"

# Add Codex MCP server to Claude Code (if claude is available)
if command -v claude &> /dev/null; then
    echo -e "\033[33mAdding Codex MCP server to Claude Code...\033[0m"

    # Get the codex.js path
    NPM_ROOT=$(npm root -g)
    CODEX_PATH="$NPM_ROOT/@openai/codex/bin/codex.js"

    if [ -f "$CODEX_PATH" ]; then
        # Remove existing if present
        claude mcp remove codex --scope user 2>/dev/null || true

        # Add with web_search enabled
        claude mcp add --transport stdio --scope user codex -- node "$CODEX_PATH" mcp-server -c "features.web_search=true"

        echo -e "\033[32mCodex MCP server added to Claude Code!\033[0m"
    else
        echo -e "\033[33mWarning: Could not find codex.js at $CODEX_PATH\033[0m"
    fi
else
    echo -e "\033[33mClaude Code not found. Skipping MCP server setup.\033[0m"
    echo -e "\033[33mTo add manually later, run:\033[0m"
    echo -e '\033[90m  claude mcp add --transport stdio --scope user codex -- node "<path-to-codex.js>" mcp-server -c "features.web_search=true"\033[0m'
fi

echo ""
echo -e "\033[32mGentlemanCodex installation complete!\033[0m"
echo ""
echo -e "\033[36mConfiguration:\033[0m"
echo -e "\033[90m  - Model: gpt-5.2-codex\033[0m"
echo -e "\033[90m  - Sandbox: danger-full-access (internet enabled)\033[0m"
echo -e "\033[90m  - Approval: on-failure (auto-approve, ask on failure)\033[0m"
echo -e "\033[90m  - Web Search: enabled\033[0m"
echo ""
echo -e "\033[33mRestart Claude Code to use the Codex MCP integration.\033[0m"
