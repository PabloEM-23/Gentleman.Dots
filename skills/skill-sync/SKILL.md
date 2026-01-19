---
name: skill-sync
description: >
  Synchronizes skill metadata to AGENTS.md tables.
  Trigger: After creating/modifying a skill, regenerate Auto-invoke tables.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
  scope: [root]
  auto_invoke: "Regenerate AGENTS.md Auto-invoke tables"
allowed-tools: Bash, Read, Edit, Write
---

## When to Use

Use after:
- Creating a new skill
- Modifying a skill's `auto_invoke` field
- Adding/removing skills from a project

## Usage

```bash
# From repo root
./skills/skill-sync/assets/sync.sh

# Custom paths
./skills/skill-sync/assets/sync.sh GentlemanClaude/skills AGENTS.md
```

## What It Does

1. Scans all `SKILL.md` files in the skills directory
2. Extracts `auto_invoke` and `description` from frontmatter
3. Generates two tables:
   - **Available Skills** - Name, description, link
   - **Auto-invoke Skills** - Action → Skill mapping

## Output Format

```markdown
## Available Skills
| Skill | Description | File |
|-------|-------------|------|
| `react-19` | React 19 patterns | [SKILL.md](...) |

## Auto-invoke Skills
| Action | Skill |
|--------|-------|
| Writing React components | `react-19` |
```

## After Running

1. Copy the generated tables
2. Paste into AGENTS.md replacing existing tables
3. Commit changes
