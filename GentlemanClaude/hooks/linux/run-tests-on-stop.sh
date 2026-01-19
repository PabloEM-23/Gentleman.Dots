#!/bin/bash
# Hook: Run tests on SessionEnd (opt-in via .claude-run-tests file)
raw=$(cat)
if [[ -z "$raw" ]]; then exit 0; fi

project="${CLAUDE_PROJECT_DIR:-$(echo "$raw" | jq -r '.cwd // empty')}"
if [[ -z "$project" ]]; then exit 0; fi

opt_in="$project/.claude-run-tests"
if [[ ! -f "$opt_in" ]]; then exit 0; fi

pkg="$project/package.json"
if [[ ! -f "$pkg" ]]; then exit 0; fi

# Check if test:quick script exists
if ! jq -e '.scripts["test:quick"]' "$pkg" &>/dev/null; then exit 0; fi

cd "$project" || exit 0
npm run test:quick
exit_code=$?

if [[ $exit_code -ne 0 ]]; then
    echo "Tests failed: npm run test:quick" >&2
    exit 2
fi
exit 0
