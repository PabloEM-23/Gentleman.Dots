---
name: systematic-debugging
description: >
  Structured 4-phase debugging methodology for root cause analysis.
  Trigger: Debugging, bug fixing, troubleshooting, error investigation.
license: MIT
metadata:
  author: obra/superpowers
  version: "1.0"
---

## Iron Law (NON-NEGOTIABLE)

**NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST**

Random fixes = wasted time. Find the WHY before touching code.

## Phase 1: Root Cause Investigation

```
1. Parse error messages and stack traces CAREFULLY
2. Reproduce the issue consistently (document exact steps)
3. Review recent changes (git diff, git log)
4. Add diagnostic logging at component boundaries
5. Trace data flow BACKWARD from symptom to origin
```

### Questions to Answer:
- When did this start happening?
- What changed recently?
- Can I reproduce it 100% of the time?
- Where exactly does the error originate?

## Phase 2: Pattern Analysis

```
1. Find WORKING implementations of similar functionality
2. Read reference implementations COMPLETELY
3. Compare working vs broken SYSTEMATICALLY
4. Document ALL differences (none are insignificant)
```

### Example:
```typescript
// Working endpoint:
app.get('/users', async (req, res) => {
  const users = await db.users.findMany();
  res.json(users);  // Returns array
});

// Broken endpoint:
app.get('/posts', async (req, res) => {
  const posts = await db.posts.findMany();
  res.send(posts);  // ← Different method!
});
```

## Phase 3: Hypothesis and Testing

```
1. Formulate SINGLE, SPECIFIC hypothesis
2. Test with MINIMAL changes (one variable at a time)
3. Verify results BEFORE proceeding
4. If unsure → investigate more, don't guess
```

### Bad vs Good Hypotheses:
```
❌ "Something's wrong with the database"
✅ "The posts query returns null because findMany() has no where clause for active: true"

❌ "Maybe it's a caching issue"
✅ "The stale data appears because Redis TTL is set to 24h but data updates hourly"
```

## Phase 4: Implementation

```
1. Write FAILING test that reproduces the bug
2. Implement SINGLE fix for identified root cause
3. Verify ALL existing tests still pass
4. If 3+ fixes fail → STOP and question architecture
```

### The Test-Fix Pattern:
```typescript
// 1. First, write test that FAILS
it('should return active posts only', () => {
  expect(getPosts()).not.toContainInactive();
});

// 2. Then implement fix
const getPosts = () => db.posts.findMany({ where: { active: true } });

// 3. Test now passes ✓
```

## Red Flags - STOP If You See These:

```
❌ Proposing multiple fixes at once
❌ "Let's try this and see"
❌ Fixing without understanding why it broke
❌ Third failed fix attempt (time to step back)
❌ Skipping test creation
❌ "It works now" without knowing why
```

## Keywords
debug, debugging, bug, error, fix, broken, not working, issue, problem, investigate
