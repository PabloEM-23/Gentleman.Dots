#!/bin/bash
# GentlemanClaude Installer for Linux/macOS
# Installs Claude Code configuration, skills, agents, and hooks

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║        GentlemanClaude Installer - Linux/macOS             ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Create directories
echo "📁 Creating directories..."
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/hooks"
mkdir -p "$CLAUDE_DIR/output-styles"

# Copy CLAUDE.md
echo "📋 Copying CLAUDE.md..."
cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Copy settings
echo "⚙️  Copying settings.json..."
cp "$SCRIPT_DIR/settings.linux.json" "$CLAUDE_DIR/settings.json"

# Copy output-styles
echo "🎨 Copying output styles..."
cp -r "$SCRIPT_DIR/output-styles/"* "$CLAUDE_DIR/output-styles/" 2>/dev/null || true

# Copy skills
echo "📚 Copying skills..."
for skill_dir in "$SCRIPT_DIR/skills/"*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "$CLAUDE_DIR/skills/$skill_name"
    cp -r "$skill_dir"* "$CLAUDE_DIR/skills/$skill_name/"
    echo "   ✓ $skill_name"
done

# Copy agents
echo "🤖 Copying agents..."
for agent_file in "$SCRIPT_DIR/agents/"*.md; do
    if [ -f "$agent_file" ]; then
        agent_name=$(basename "$agent_file")
        cp "$agent_file" "$CLAUDE_DIR/agents/$agent_name"
        echo "   ✓ ${agent_name%.md}"
    fi
done

# Copy hooks (Linux version)
echo "🪝 Copying hooks..."
for hook_file in "$SCRIPT_DIR/hooks/linux/"*.sh; do
    if [ -f "$hook_file" ]; then
        hook_name=$(basename "$hook_file")
        cp "$hook_file" "$CLAUDE_DIR/hooks/$hook_name"
        chmod +x "$CLAUDE_DIR/hooks/$hook_name"
        echo "   ✓ $hook_name"
    fi
done

# Handle MCP servers (don't overwrite existing credentials)
echo "🔌 Configuring MCP servers..."
if [ -f "$CLAUDE_DIR/mcp.json" ]; then
    echo "   ⚠️  mcp.json already exists - preserving your credentials"
    echo "   Template saved to: $CLAUDE_DIR/mcp-servers.template.json"
    cp "$SCRIPT_DIR/mcp-servers.template.json" "$CLAUDE_DIR/mcp-servers.template.json"
else
    echo "   Creating mcp.json from template..."
    cp "$SCRIPT_DIR/mcp-servers.template.json" "$CLAUDE_DIR/mcp.json"
    echo "   ⚠️  IMPORTANT: Edit ~/.claude/mcp.json and add your API tokens!"
fi

# Verify jq is installed (required for hooks)
echo ""
echo "🔍 Checking dependencies..."
if command -v jq &> /dev/null; then
    echo "   ✓ jq installed"
else
    echo "   ⚠️  jq NOT installed - hooks won't work!"
    echo "   Install with: sudo apt install jq (Debian/Ubuntu/Zorin)"
    echo "                 brew install jq (macOS)"
fi

# Verify prettier is available (optional, for format hook)
if command -v npx &> /dev/null; then
    echo "   ✓ npx available (prettier formatting will work)"
else
    echo "   ⚠️  npx not found - prettier formatting hook won't work"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                  Installation Complete!                     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Installed to: $CLAUDE_DIR"
echo ""
echo "Contents:"
echo "  • CLAUDE.md       - Global instructions"
echo "  • settings.json   - Permissions, hooks, language"
echo "  • skills/         - $(ls -1 "$CLAUDE_DIR/skills" 2>/dev/null | wc -l) skills"
echo "  • agents/         - $(ls -1 "$CLAUDE_DIR/agents" 2>/dev/null | wc -l) agents"
echo "  • hooks/          - $(ls -1 "$CLAUDE_DIR/hooks" 2>/dev/null | wc -l) hooks"
echo ""
echo "To enable test-on-stop hook for a project, create:"
echo "  touch /path/to/project/.claude-run-tests"
echo ""
echo "Restart Claude Code to apply changes."
