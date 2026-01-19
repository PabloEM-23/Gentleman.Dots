$raw = [Console]::In.ReadToEnd()
$data = $raw | ConvertFrom-Json
$filePath = $data.tool_input.file_path

if ($filePath -and $filePath -match '\.(js|ts|jsx|tsx|json|css|scss|md)$') {
    if (Get-Command npx -ErrorAction SilentlyContinue) {
        & npx prettier --write $filePath 2>$null
        Add-Content -Path "$env:TEMP\claude-hooks.log" -Value "PRETTIER: $(Get-Date) - $filePath" -Encoding UTF8
    }
}
