# Gentleman.Dots AI Agent Skills

> **Single Source of Truth** - This file is the master for all AI assistants.
> Run `./skills/setup.sh` to sync to Claude, Gemini, Copilot, and Codex formats.

This repository provides AI agent skills for Claude Code, OpenCode, and other AI assistants.
Skills provide on-demand context and patterns for working with this codebase.

## Quick Start

When working on this project, Claude Code automatically loads relevant skills based on context.
For manual loading, read the SKILL.md file directly.

## Available Skills

### Gentleman.Dots Specific (Repository Skills)

| Skill | Description | File |
|-------|-------------|------|
| `gentleman-bubbletea` | Bubbletea TUI patterns, Model-Update-View, screen navigation | [SKILL.md](skills/gentleman-bubbletea/SKILL.md) |
| `gentleman-trainer` | Vim Trainer RPG system, exercises, progression, boss fights | [SKILL.md](skills/gentleman-trainer/SKILL.md) |
| `gentleman-installer` | Installation steps, interactive/non-interactive modes | [SKILL.md](skills/gentleman-installer/SKILL.md) |
| `gentleman-e2e` | Docker-based E2E testing, multi-platform validation | [SKILL.md](skills/gentleman-e2e/SKILL.md) |
| `gentleman-system` | OS detection, command execution, cross-platform support | [SKILL.md](skills/gentleman-system/SKILL.md) |
| `go-testing` | Go testing patterns, table-driven tests, Bubbletea testing | [SKILL.md](skills/go-testing/SKILL.md) |

### Generic Skills (User Installation → ~/.claude/skills/)

These skills are copied to user's Claude/OpenCode config via the installer.

| Skill | Description | Source |
|-------|-------------|--------|
| `react-19` | React 19 patterns, hooks, components | [GentlemanClaude/skills/react-19](GentlemanClaude/skills/react-19/SKILL.md) |
| `nextjs-15` | Next.js 15, App Router, Server Components | [GentlemanClaude/skills/nextjs-15](GentlemanClaude/skills/nextjs-15/SKILL.md) |
| `typescript` | TypeScript patterns, types, generics | [GentlemanClaude/skills/typescript](GentlemanClaude/skills/typescript/SKILL.md) |
| `tailwind-4` | Tailwind CSS v4 patterns | [GentlemanClaude/skills/tailwind-4](GentlemanClaude/skills/tailwind-4/SKILL.md) |
| `zod-4` | Zod validation schemas | [GentlemanClaude/skills/zod-4](GentlemanClaude/skills/zod-4/SKILL.md) |
| `zustand-5` | Zustand state management | [GentlemanClaude/skills/zustand-5](GentlemanClaude/skills/zustand-5/SKILL.md) |
| `ai-sdk-5` | Vercel AI SDK 5 | [GentlemanClaude/skills/ai-sdk-5](GentlemanClaude/skills/ai-sdk-5/SKILL.md) |
| `django-drf` | Django REST Framework | [GentlemanClaude/skills/django-drf](GentlemanClaude/skills/django-drf/SKILL.md) |
| `playwright` | Playwright E2E testing | [GentlemanClaude/skills/playwright](GentlemanClaude/skills/playwright/SKILL.md) |
| `pytest` | Python pytest patterns | [GentlemanClaude/skills/pytest](GentlemanClaude/skills/pytest/SKILL.md) |
| `jira-task` | Create Jira tasks/tickets | [GentlemanClaude/skills/jira-task](GentlemanClaude/skills/jira-task/SKILL.md) |
| `jira-epic` | Create Jira epics for large features | [GentlemanClaude/skills/jira-epic](GentlemanClaude/skills/jira-epic/SKILL.md) |
| `skill-creator` | Create new AI agent skills | [GentlemanClaude/skills/skill-creator](GentlemanClaude/skills/skill-creator/SKILL.md) |

### Maintenance Skills

| Skill | Description | File |
|-------|-------------|------|
| `skill-sync` | Regenerate Auto-invoke tables from SKILL.md | [SKILL.md](skills/skill-sync/SKILL.md) |

## Auto-invoke Skills

When performing these actions, **ALWAYS** invoke the corresponding skill FIRST:

### Repository-Specific (Gentleman.Dots)

| Action | Skill |
|--------|-------|
| Adding new TUI screen | `gentleman-bubbletea` |
| Creating Vim exercises | `gentleman-trainer` |
| Adding installation step | `gentleman-installer` |
| Writing E2E tests | `gentleman-e2e` |
| Adding OS support | `gentleman-system` |
| Writing Go tests | `go-testing` |

### Generic Skills (Any Project)

| Action | Skill |
|--------|-------|
| Writing React components | `react-19` |
| App Router / Server Actions | `nextjs-15` |
| Writing TypeScript types/interfaces | `typescript` |
| Working with Tailwind classes | `tailwind-4` |
| Creating Zod schemas | `zod-4` |
| Using Zustand stores | `zustand-5` |
| Building AI chat features | `ai-sdk-5` |
| Building REST APIs with Django | `django-drf` |
| Writing Playwright E2E tests | `playwright` |
| Writing Python tests with pytest | `pytest` |
| Creating Jira tasks/tickets | `jira-task` |
| Creating Jira epics | `jira-epic` |
| Creating new skills | `skill-creator` |
| Regenerate Auto-invoke tables | `skill-sync` |

## How Skills Work

1. **Auto-detection**: Claude Code reads CLAUDE.md which contains skill triggers
2. **Context matching**: When editing Go/TUI code, gentleman-bubbletea loads
3. **Pattern application**: AI follows the exact patterns from the skill
4. **First-time-correct**: No trial and error - skills provide exact conventions

## Skill Structure

```
skills/                              # Repository-specific skills
├── setup.sh                         # Sync script
├── gentleman-bubbletea/SKILL.md     # TUI patterns
├── gentleman-trainer/SKILL.md       # Vim trainer
└── ...

GentlemanClaude/skills/              # User-installable skills
├── react-19/SKILL.md                # Copied to ~/.claude/skills/
├── typescript/SKILL.md
└── ...
```

## Contributing

### Adding a Repository Skill (for this codebase)
1. Read the `skill-creator` skill first
2. Create skill directory under `skills/`
3. Add SKILL.md following the template
4. Register in this file under "Gentleman.Dots Specific"
5. Run `./skills/setup.sh --all` to regenerate

### Adding a User Skill (for Claude/OpenCode users)
1. Create skill directory under `GentlemanClaude/skills/`
2. Add SKILL.md following the template
3. Register in this file under "Generic Skills"
4. The installer will copy it to user's config

## Project Overview

**Gentleman.Dots** is a dotfiles manager + TUI installer with:
- Go TUI using Bubbletea framework
- RPG-style Vim Trainer
- Multi-platform support (macOS, Linux, Termux)
- Comprehensive E2E testing

See [README.md](README.md) for full documentation.
