$raw = [Console]::In.ReadToEnd()
$data = $raw | ConvertFrom-Json
$line = "HOOK: $(Get-Date) - $($data.tool_name) - $($data.tool_input.file_path)"
Add-Content -Path "$env:TEMP\claude-hooks.log" -Value $line -Encoding UTF8
