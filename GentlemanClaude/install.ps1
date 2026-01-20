# GentlemanClaude Installer for Windows
# Installs Claude Code configuration, skills, agents, and hooks

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"

Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║          GentlemanClaude Installer - Windows               ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Create directories
Write-Host "📁 Creating directories..." -ForegroundColor Yellow
$dirs = @("skills", "agents", "hooks", "output-styles")
foreach ($dir in $dirs) {
    $path = Join-Path $ClaudeDir $dir
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
    }
}

# Copy CLAUDE.md
Write-Host "📋 Copying CLAUDE.md..." -ForegroundColor Yellow
Copy-Item -Path (Join-Path $ScriptDir "CLAUDE.md") -Destination (Join-Path $ClaudeDir "CLAUDE.md") -Force

# Copy settings
Write-Host "⚙️  Copying settings.json..." -ForegroundColor Yellow
Copy-Item -Path (Join-Path $ScriptDir "settings.windows.json") -Destination (Join-Path $ClaudeDir "settings.json") -Force

# Copy output-styles
Write-Host "🎨 Copying output styles..." -ForegroundColor Yellow
$outputStylesSource = Join-Path $ScriptDir "output-styles"
$outputStylesDest = Join-Path $ClaudeDir "output-styles"
if (Test-Path $outputStylesSource) {
    Get-ChildItem -Path $outputStylesSource -File | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $outputStylesDest -Force
    }
}

# Copy skills
Write-Host "📚 Copying skills..." -ForegroundColor Yellow
$skillsSource = Join-Path $ScriptDir "skills"
$skillsDest = Join-Path $ClaudeDir "skills"
$skillCount = 0
Get-ChildItem -Path $skillsSource -Directory | ForEach-Object {
    $skillName = $_.Name
    $destSkillDir = Join-Path $skillsDest $skillName
    if (-not (Test-Path $destSkillDir)) {
        New-Item -ItemType Directory -Path $destSkillDir -Force | Out-Null
    }
    Copy-Item -Path (Join-Path $_.FullName "*") -Destination $destSkillDir -Recurse -Force
    Write-Host "   ✓ $skillName" -ForegroundColor Green
    $skillCount++
}

# Copy agents
Write-Host "🤖 Copying agents..." -ForegroundColor Yellow
$agentsSource = Join-Path $ScriptDir "agents"
$agentsDest = Join-Path $ClaudeDir "agents"
$agentCount = 0
Get-ChildItem -Path $agentsSource -Filter "*.md" | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $agentsDest -Force
    $agentName = $_.BaseName
    Write-Host "   ✓ $agentName" -ForegroundColor Green
    $agentCount++
}

# Copy hooks (Windows version)
Write-Host "🪝 Copying hooks..." -ForegroundColor Yellow
$hooksSource = Join-Path $ScriptDir "hooks\windows"
$hooksDest = Join-Path $ClaudeDir "hooks"
$hookCount = 0
Get-ChildItem -Path $hooksSource -Filter "*.ps1" | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $hooksDest -Force
    Write-Host "   ✓ $($_.Name)" -ForegroundColor Green
    $hookCount++
}

# Handle MCP servers (don't overwrite existing credentials)
Write-Host "🔌 Configuring MCP servers..." -ForegroundColor Yellow
$mcpJsonPath = Join-Path $ClaudeDir "mcp.json"
$mcpTemplatePath = Join-Path $ScriptDir "mcp-servers.template.json"
if (Test-Path $mcpJsonPath) {
    Write-Host "   ⚠️  mcp.json already exists - preserving your credentials" -ForegroundColor Yellow
    Write-Host "   Template saved to: $ClaudeDir\mcp-servers.template.json" -ForegroundColor Gray
    Copy-Item -Path $mcpTemplatePath -Destination (Join-Path $ClaudeDir "mcp-servers.template.json") -Force
} else {
    Write-Host "   Creating mcp.json from template..." -ForegroundColor Green
    Copy-Item -Path $mcpTemplatePath -Destination $mcpJsonPath -Force
    Write-Host "   ⚠️  IMPORTANT: Edit ~/.claude/mcp.json and add your API tokens!" -ForegroundColor Yellow
}

# Verify dependencies
Write-Host ""
Write-Host "🔍 Checking dependencies..." -ForegroundColor Yellow

# Check npx (for prettier)
if (Get-Command npx -ErrorAction SilentlyContinue) {
    Write-Host "   ✓ npx available (prettier formatting will work)" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  npx not found - prettier formatting hook won't work" -ForegroundColor Yellow
}

# Check node
if (Get-Command node -ErrorAction SilentlyContinue) {
    Write-Host "   ✓ node installed" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  node not found" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                  Installation Complete!                     ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Installed to: $ClaudeDir" -ForegroundColor White
Write-Host ""
Write-Host "Contents:" -ForegroundColor White
Write-Host "  • CLAUDE.md       - Global instructions" -ForegroundColor Gray
Write-Host "  • settings.json   - Permissions, hooks, language" -ForegroundColor Gray
Write-Host "  • skills/         - $skillCount skills" -ForegroundColor Gray
Write-Host "  • agents/         - $agentCount agents" -ForegroundColor Gray
Write-Host "  • hooks/          - $hookCount hooks" -ForegroundColor Gray
Write-Host ""
Write-Host "To enable test-on-stop hook for a project, create:" -ForegroundColor White
Write-Host "  New-Item -Path 'C:\path\to\project\.claude-run-tests' -ItemType File" -ForegroundColor Gray
Write-Host ""
Write-Host "Optional: Install Codex integration" -ForegroundColor White
Write-Host "  cd ..\GentlemanCodex && .\install.ps1" -ForegroundColor Gray
Write-Host ""
Write-Host "Restart Claude Code to apply changes." -ForegroundColor Yellow
