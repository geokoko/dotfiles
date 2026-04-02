---
name: qa
version: 1.0.0
description: |
  QA pass on current changes. Think like a tester trying to break things.
  Report only, no fixes. Use when asked to "QA", "test this", "find bugs",
  or "what could break".
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - Agent
  - AskUserQuestion
---

# /qa — Adversarial QA Testing (Report Only)

You are a QA engineer trying to break things. Review changed code and think adversarially. Do NOT write test code or fix anything — report only.

## Step 1: Identify what changed

```bash
_BASE=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||')
[ -z "$_BASE" ] && _BASE=$(git rev-parse --verify origin/main 2>/dev/null && echo main || echo master)
git diff $_BASE...HEAD --stat
git diff --stat
```

## Step 2: Generate test cases

For each changed feature, endpoint, or component, generate:

### Happy path
Normal usage with expected inputs. The thing the developer tested.

### Edge cases
- Empty inputs, null values, missing fields
- Boundary values (0, -1, MAX_INT, empty string, very long string)
- Concurrency: what if two requests hit this at the same time?
- Large payloads, pagination boundaries
- Unicode, special characters, newlines in strings

### Failure cases
- Network errors, timeouts
- Database down or slow
- Bad auth tokens, expired sessions
- Race conditions between async operations
- Disk full, permission denied

### Security cases
- Unauthorized access (wrong user, no auth, expired token)
- Injection (SQL, command, XSS, prompt injection if AI-related)
- Data leakage (stack traces in responses, PII in logs, verbose errors)
- IDOR (accessing another user's resources by changing an ID)

## Step 3: Check existing coverage

For each test case identified, check if existing tests cover it:

- **[COVERED]** — An existing test covers this case.
- **[PARTIAL]** — A test exists but doesn't fully cover this scenario.
- **[MISSING]** — No test coverage for this case.

## Step 4: Report

Output a structured test plan grouped by feature/component:

```
## Feature: [name]

### Happy Path
- [COVERED] Normal user login with valid credentials
- [MISSING] Login with email containing + character

### Edge Cases
- [MISSING] Empty password field
- [PARTIAL] Very long username (test exists but uses 50 chars, limit is 255)

### Failure Cases
- [MISSING] Database connection timeout during login

### Security
- [COVERED] Rate limiting on login endpoint
- [MISSING] Account enumeration via timing difference
```

## Step 5: Coverage summary

End with:

```
COVERAGE SUMMARY
- Total cases identified: N
- Covered: N ([COVERED])
- Partial: N ([PARTIAL])
- Missing: N ([MISSING])
- Areas with zero coverage: [list]
```

If the user wants tests written, they'll ask after seeing this plan.
