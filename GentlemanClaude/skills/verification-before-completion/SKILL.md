---
name: verification-before-completion
description: >
  Non-negotiable protocol for claiming work is complete.
  Trigger: Before marking ANY task as complete, before saying "done", "fixed", "working".
license: MIT
metadata:
  author: obra/superpowers
  version: "1.0"
---

## Core Principle (NON-NEGOTIABLE)

**NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE**

You CANNOT claim something passes without actively executing the proof command in that exact moment.

## The Gate Function (5-Step Process)

Before ANY success claim, you MUST:

1. **IDENTIFY** - What verification command proves this works?
2. **RUN** - Execute it completely (fresh execution, not cached)
3. **READ** - Full output AND exit codes
4. **VERIFY** - Output actually matches your claim
5. **REPORT** - Make assertion WITH evidence

Skipping steps = dishonesty, not efficiency.

## Red Flags - STOP IMMEDIATELY If You Catch Yourself:

```
❌ "Should work now"           → Run the test first
❌ "Probably fixed"            → Verify it's fixed
❌ "Seems to be working"       → Prove it's working
❌ "Done!"                     → Show the evidence
❌ "I've fixed the issue"      → Run verification
❌ Committing without tests    → Tests first, commit second
❌ Trusting previous run       → Run it AGAIN
```

## Verification Evidence Examples

### For Tests:
```bash
# ✅ CORRECT: Show actual output
npm test
# Output: 47 passed, 0 failed ✓

# ❌ WRONG: "Tests should pass now"
```

### For Builds:
```bash
# ✅ CORRECT: Show exit code
npm run build && echo "Exit code: $?"
# Exit code: 0

# ❌ WRONG: "Build is fixed"
```

### For Bug Fixes:
```bash
# ✅ CORRECT: Reproduce original bug, show it's gone
# Before: Error X happened
# After: [actual output showing no error]

# ❌ WRONG: "The bug is fixed"
```

## Why This Matters

False completion claims:
- Break trust
- Ship broken code
- Waste time on "it works on my machine"
- Violate core values about honesty

## Keywords
verification, completion, done, fixed, working, tests pass, build succeeds
