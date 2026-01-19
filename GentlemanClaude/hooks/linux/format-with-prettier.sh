#!/bin/bash
# Hook: Format with prettier after Edit/Write
raw=$(cat)
file_path=$(echo "$raw" | jq -r '.tool_input.file_path // empty')

if [[ -n "$file_path" && "$file_path" =~ \.(js|ts|jsx|tsx|json|css|scss|md)$ ]]; then
    if command -v npx &> /dev/null; then
        npx prettier --write "$file_path" 2>/dev/null
        echo "PRETTIER: $(date) - $file_path" >> /tmp/claude-hooks.log
    fi
fi
