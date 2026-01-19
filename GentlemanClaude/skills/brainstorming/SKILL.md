---
name: brainstorming
description: >
  Structured process for converting ideas into validated designs.
  Trigger: Research, analysis, new features, architecture decisions, product evaluation.
license: MIT
metadata:
  author: obra/superpowers
  version: "1.0"
---

## When to Use This

**BEFORE any creative work:**
- Creating new features
- Building components
- Adding functionality
- Modifying behavior
- Evaluating options
- Architecture decisions

## The Three-Phase Process

### Phase 1: Understanding (Ask First)

```
1. Examine current state of the project
2. Ask questions ONE AT A TIME
3. Prioritize multiple-choice questions
4. Goal: Understand purpose, constraints, success criteria
```

#### Questions to Ask:
- What problem are we solving?
- Who is the user?
- What are the constraints (time, tech, team)?
- How will we measure success?
- What's out of scope?

### Phase 2: Exploration (Propose Options)

```
1. Propose 2-3 DISTINCT approaches
2. List pros/cons for each
3. Start with your recommended option
4. Explain WHY you recommend it
```

#### Example Format:
```markdown
## Option A: Server Components (Recommended)
**Pros:** Better performance, smaller bundle, simpler data fetching
**Cons:** Learning curve, limited interactivity
**Best for:** Content-heavy pages

## Option B: Client Components with React Query
**Pros:** Familiar patterns, full interactivity, caching built-in
**Cons:** Larger bundle, more complexity
**Best for:** Highly interactive dashboards

## Option C: Hybrid Approach
**Pros:** Best of both worlds
**Cons:** More complexity in architecture
**Best for:** Apps with mixed requirements
```

### Phase 3: Presentation (Validate in Chunks)

```
1. Divide design into sections (200-300 words each)
2. Validate after EACH section
3. Cover: architecture, components, data flow, error handling, tests
```

#### Sections to Cover:
1. **Architecture Overview** - High-level structure
2. **Component Breakdown** - What pieces exist
3. **Data Flow** - How data moves through system
4. **Error Handling** - What can go wrong, how to handle
5. **Testing Strategy** - How to verify it works

## After Design is Approved

```
1. Document in docs/plans/YYYY-MM-DD-<topic>-design.md
2. Create detailed implementation plan
3. Break into small, testable tasks
```

## Principles

```
✅ One question per message
✅ YAGNI - eliminate unnecessary features
✅ Explore alternatives before deciding
✅ Validate incrementally
✅ Document decisions and reasoning

❌ Assuming requirements
❌ Jumping to implementation
❌ Single-option proposals
❌ Big-bang reveals
```

## Keywords
brainstorm, research, analyze, evaluate, design, architecture, feature, plan, options
