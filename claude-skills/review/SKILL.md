---
name: review
version: 1.0.0
description: |
  Thorough code review of current changes. Find bugs that pass CI but blow up
  in production. Use when asked to "review", "code review", "check my diff",
  or "pre-landing review".
allowed-tools:
  - Bash
  - Read
  - Edit
  - Write
  - Grep
  - Glob
  - Agent
  - AskUserQuestion
---

# /review — Pre-Landing Code Review

You are reviewing code changes for structural issues that tests don't catch. Report only — do not apply fixes unless explicitly asked.

## Step 0: Detect scope

Determine what to diff against:

- If the user passed `--base <ref>`, diff against that.
- Otherwise, detect the base branch:

```bash
git remote get-url origin 2>/dev/null
_BASE=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||')
[ -z "$_BASE" ] && _BASE=$(git rev-parse --verify origin/main 2>/dev/null && echo main || echo master)
echo "BASE: $_BASE"
```

If there are no committed changes vs base, fall back to uncommitted changes (`git diff` + `git diff --cached`).

## Step 1: Get the diff

```bash
git diff $_BASE...HEAD --stat
git diff $_BASE...HEAD
```

Also check for any uncommitted changes:

```bash
git diff --stat
git diff --cached --stat
```

## Step 2: Check prior review history

```bash
git log --oneline $_BASE..HEAD | head -20
```

If there are review-driven refactors or reverts on this branch, be MORE aggressive reviewing those areas.

## Step 3: Review

For every changed file, check:

**Correctness**
- Logic errors, off-by-one, wrong comparisons
- Unhandled edge cases and error paths
- Async/concurrency issues, race conditions
- Missing null/undefined checks where data could be absent

**Security**
- Injection: SQL, command, prompt injection
- Auth bypass, missing auth checks, IDOR
- Data exposure: API keys in code, PII in logs or error messages
- Missing input validation

**Consistency**
- New code should look like it belongs in the repo
- Follow existing patterns — don't introduce new conventions without reason

**Hygiene**
- Debug code: console.log, print(), debugger statements
- Hardcoded values that should be config
- TODOs left unintentionally
- New env vars or config values that aren't documented

**Completeness**
- Missing error handling on external calls, DB operations, file I/O
- New endpoints without input validation or proper error responses
- Changed public APIs without updated docs

## Step 4: Report

Output a structured list grouped by severity:

- **CRITICAL** — Must fix before ship. Bugs, security issues, data loss risks.
- **WARNING** — Should fix. Missing error handling, inconsistencies, incomplete work.
- **SUGGESTION** — Nice to have. Style, minor improvements, optional refactors.

For each finding:
1. File and line number
2. What the issue is
3. Why it matters
4. The fix (stated clearly, not applied)

If nothing to flag, say so explicitly: **"No issues found. LGTM."**

## Completion

Report status:
- **PASS** — No critical or warning findings.
- **PASS WITH WARNINGS** — No critical findings, but warnings exist.
- **FAIL** — Critical findings that must be addressed before shipping.
