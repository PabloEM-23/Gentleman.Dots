# GentlemanCodex Installation Script for Windows
# Installs and configures OpenAI Codex CLI with Gentleman settings

$ErrorActionPreference = "Stop"

Write-Host "Installing GentlemanCodex..." -ForegroundColor Cyan

# Check if npm is available
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "Error: npm is not installed. Please install Node.js first." -ForegroundColor Red
    exit 1
}

# Install Codex CLI globally
Write-Host "Installing Codex CLI..." -ForegroundColor Yellow
npm install -g @openai/codex

# Create config directory if it doesn't exist
$codexConfigDir = "$env:USERPROFILE\.codex"
if (-not (Test-Path $codexConfigDir)) {
    New-Item -ItemType Directory -Path $codexConfigDir -Force | Out-Null
}

# Copy config.toml
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Copy-Item "$scriptDir\config.toml" "$codexConfigDir\config.toml" -Force

Write-Host "Codex config installed to: $codexConfigDir\config.toml" -ForegroundColor Green

# Add Codex MCP server to Claude Code (if claude is available)
if (Get-Command claude -ErrorAction SilentlyContinue) {
    Write-Host "Adding Codex MCP server to Claude Code..." -ForegroundColor Yellow

    # Get the codex.js path
    $npmRoot = (npm root -g).Trim()
    $codexPath = "$npmRoot\@openai\codex\bin\codex.js"

    if (Test-Path $codexPath) {
        # Remove existing if present
        claude mcp remove codex --scope user 2>$null

        # Add with web_search enabled
        claude mcp add --transport stdio --scope user codex -- node $codexPath mcp-server -c "features.web_search=true"

        Write-Host "Codex MCP server added to Claude Code!" -ForegroundColor Green
    } else {
        Write-Host "Warning: Could not find codex.js at $codexPath" -ForegroundColor Yellow
    }
} else {
    Write-Host "Claude Code not found. Skipping MCP server setup." -ForegroundColor Yellow
    Write-Host "To add manually later, run:" -ForegroundColor Yellow
    Write-Host '  claude mcp add --transport stdio --scope user codex -- node "<path-to-codex.js>" mcp-server -c "features.web_search=true"' -ForegroundColor Gray
}

Write-Host ""
Write-Host "GentlemanCodex installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Configuration:" -ForegroundColor Cyan
Write-Host "  - Model: gpt-5.2-codex" -ForegroundColor Gray
Write-Host "  - Sandbox: danger-full-access (internet enabled)" -ForegroundColor Gray
Write-Host "  - Approval: on-failure (auto-approve, ask on failure)" -ForegroundColor Gray
Write-Host "  - Web Search: enabled" -ForegroundColor Gray
Write-Host ""
Write-Host "Restart Claude Code to use the Codex MCP integration." -ForegroundColor Yellow
