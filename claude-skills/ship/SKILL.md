---
name: ship
version: 1.0.0
description: |
  Pre-push checklist and PR creation. Runs tests, checks for debug code and
  secrets, runs /review, and creates the PR. Use when asked to "ship", "push",
  "create a PR", or "merge and push".
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Agent
  - AskUserQuestion
---

# /ship — Pre-Push Checklist & PR Creation

You are running the ship workflow. This is mostly automated — only stop for blockers.

## Step 0: Detect base branch

```bash
git remote get-url origin 2>/dev/null
_BRANCH=$(git branch --show-current 2>/dev/null)
echo "CURRENT: $_BRANCH"
```

Detect base branch (try `gh pr view`, then `gh repo view`, then git-native fallback):

```bash
_BASE=$(gh pr view --json baseRefName -q .baseRefName 2>/dev/null)
[ -z "$_BASE" ] && _BASE=$(gh repo view --json defaultBranchRef -q .defaultBranchRef.name 2>/dev/null)
[ -z "$_BASE" ] && _BASE=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||')
[ -z "$_BASE" ] && _BASE=main
echo "BASE: $_BASE"
```

**If on the base branch: ABORT.** Do not ship from main/master.

## Step 1: Pre-ship checklist

Run through each item. Report PASS / FAIL / SKIP:

### 1.1 Clean working tree
```bash
git status --short
```
No unintentional uncommitted changes.

### 1.2 No debug statements
Search changed files for `console.log`, `print()`, `debugger`, `binding.pry`, `import pdb`:
```bash
git diff $_BASE...HEAD | grep -E '^\+.*(console\.log|debugger|print\(|binding\.pry|import pdb|breakpoint\(\))' || echo "CLEAN"
```

### 1.3 No hardcoded secrets
Search for patterns that look like API keys, tokens, or localhost URLs in changed files:
```bash
git diff $_BASE...HEAD | grep -E '^\+.*(sk-[a-zA-Z0-9]{20,}|AKIA[A-Z0-9]{16}|ghp_[a-zA-Z0-9]{36}|localhost:[0-9]{4,5})' || echo "CLEAN"
```

### 1.4 Env vars documented
If new env vars were added, check that `.env.example` or equivalent is updated.

### 1.5 Migrations exist
If database schema changed, verify a migration file exists.

### 1.6 Tests pass
Detect and run the test command:
```bash
# Detect test runner
if [ -f "Makefile" ] && grep -q "^test:" Makefile; then echo "make test"
elif [ -f "pyproject.toml" ]; then echo "pytest"
elif [ -f "package.json" ] && grep -q '"test"' package.json; then echo "npm test"
elif [ -f "Cargo.toml" ]; then echo "cargo test"
else echo "NO_TEST_RUNNER"
fi
```

Run the detected test command and report pass/fail with test count.

### 1.7 Run /geo:review
Run the review skill internally. If any CRITICAL findings exist, **BLOCK the ship**.

### 1.8 Stale docs check
Check if README, ARCHITECTURE, CLAUDE.md, or similar docs are stale relative to changes. If so, flag and offer to run `/geo:document-release`.

## Step 2: Verdict

Give a one-line verdict:

- **READY TO SHIP** — all checks pass, no blockers.
- **NEEDS ATTENTION** — list the blockers.

## Step 3: Create PR (if READY)

If READY (or user explicitly overrides blockers):

1. Push the branch:
```bash
git push -u origin $_BRANCH
```

2. Create the PR with `gh pr create`:
- Clear title summarizing what changed
- Body with: what changed, why, how to test, known limitations
- Use HEREDOC for the body to preserve formatting

```bash
gh pr create --title "title" --body "$(cat <<'EOF'
## Summary
- ...

## Test plan
- ...
EOF
)"
```

3. Output the PR URL.

If NEEDS ATTENTION: list blockers. Do not create the PR until resolved (unless user overrides).
