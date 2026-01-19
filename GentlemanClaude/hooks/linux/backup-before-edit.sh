#!/bin/bash
# Hook: Backup file before Edit/Write
raw=$(cat)
file_path=$(echo "$raw" | jq -r '.tool_input.file_path // empty')

if [[ -n "$file_path" && -f "$file_path" ]]; then
    timestamp=$(date +%Y%m%d%H%M%S)
    backup_path="${file_path}.backup.${timestamp}"
    cp "$file_path" "$backup_path" 2>/dev/null
    echo "BACKUP: $(date) - $file_path -> $backup_path" >> /tmp/claude-hooks.log
fi
