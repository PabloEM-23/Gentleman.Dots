$raw = [Console]::In.ReadToEnd()
$data = $raw | ConvertFrom-Json
$filePath = $data.tool_input.file_path

if ($filePath -and (Test-Path $filePath)) {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $backupPath = "$filePath.backup.$timestamp"
    Copy-Item -Path $filePath -Destination $backupPath -Force -ErrorAction SilentlyContinue
    Add-Content -Path "$env:TEMP\claude-hooks.log" -Value "BACKUP: $(Get-Date) - $filePath -> $backupPath" -Encoding UTF8
}
