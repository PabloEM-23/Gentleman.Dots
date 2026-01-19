#!/bin/bash
# skill-sync: Generate Auto-invoke tables from SKILL.md frontmatter
# Usage: ./sync.sh [skills_dir] [output_file]

set -e

SKILLS_DIR="${1:-GentlemanClaude/skills}"
OUTPUT_FILE="${2:-AGENTS.md}"
TEMP_FILE=$(mktemp)

echo "🔍 Scanning skills in $SKILLS_DIR..."

# Extract auto_invoke from all SKILL.md files
generate_auto_invoke_table() {
    echo "| Action | Skill |"
    echo "|--------|-------|"

    for skill_dir in "$SKILLS_DIR"/*/; do
        skill_file="$skill_dir/SKILL.md"
        if [[ -f "$skill_file" ]]; then
            skill_name=$(basename "$skill_dir")

            # Extract auto_invoke from frontmatter using awk
            auto_invoke=$(awk '
                /^---$/ { in_frontmatter = !in_frontmatter; next }
                in_frontmatter && /auto_invoke:/ {
                    gsub(/.*auto_invoke:[[:space:]]*"?/, "")
                    gsub(/"[[:space:]]*$/, "")
                    print
                }
            ' "$skill_file")

            if [[ -n "$auto_invoke" ]]; then
                echo "| $auto_invoke | \`$skill_name\` |"
            fi
        fi
    done
}

# Generate skills table
generate_skills_table() {
    echo "| Skill | Description | File |"
    echo "|-------|-------------|------|"

    for skill_dir in "$SKILLS_DIR"/*/; do
        skill_file="$skill_dir/SKILL.md"
        if [[ -f "$skill_file" ]]; then
            skill_name=$(basename "$skill_dir")

            # Extract description (first line after description:)
            description=$(awk '
                /^---$/ { in_frontmatter = !in_frontmatter; next }
                in_frontmatter && /^description:/ {
                    getline
                    gsub(/^[[:space:]]+/, "")
                    gsub(/\.$/, "")
                    print
                    exit
                }
            ' "$skill_file")

            if [[ -n "$description" ]]; then
                echo "| \`$skill_name\` | $description | [SKILL.md]($SKILLS_DIR/$skill_name/SKILL.md) |"
            fi
        fi
    done
}

echo ""
echo "📋 Available Skills:"
echo ""
generate_skills_table

echo ""
echo "🚀 Auto-invoke Skills:"
echo ""
generate_auto_invoke_table

echo ""
echo "✅ Done! Copy the tables above to your AGENTS.md"
