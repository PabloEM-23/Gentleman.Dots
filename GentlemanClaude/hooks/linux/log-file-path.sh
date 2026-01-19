#!/bin/bash
# Hook: Log file path on Edit/Write
raw=$(cat)
file_path=$(echo "$raw" | jq -r '.tool_input.file_path // empty')
tool_name=$(echo "$raw" | jq -r '.tool_name // empty')

echo "HOOK: $(date) - $tool_name - $file_path" >> /tmp/claude-hooks.log
