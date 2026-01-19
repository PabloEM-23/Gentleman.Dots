$raw = [Console]::In.ReadToEnd()
if (-not $raw) { exit 0 }
$data = $raw | ConvertFrom-Json

$project = $env:CLAUDE_PROJECT_DIR
if (-not $project) { $project = $data.cwd }
if (-not $project) { exit 0 }

$optIn = Join-Path $project ".claude-run-tests"
if (-not (Test-Path $optIn)) { exit 0 }

$pkg = Join-Path $project "package.json"
if (-not (Test-Path $pkg)) { exit 0 }

$pkgJson = Get-Content $pkg -Raw | ConvertFrom-Json
if (-not $pkgJson.scripts -or -not $pkgJson.scripts."test:quick") { exit 0 }

Push-Location $project
try {
    npm run test:quick
    $exit = $LASTEXITCODE
} finally {
    Pop-Location
}

if ($exit -ne 0) {
    Write-Error "Tests failed: npm run test:quick"
    exit 2
}
exit 0
