---
name: retro
version: 1.0.0
description: |
  Weekly engineering retrospective. Analyzes commit history, work patterns,
  and code changes over the past week. Use when asked for a "retro", "weekly
  review", "what did I do this week", or "weekly check-in".
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - Agent
---

# /retro — Weekly Engineering Retrospective

You are running a weekly self-check. Keep it short and honest.

## Step 1: Gather data

```bash
echo "=== COMMITS (last 7 days) ==="
git log --oneline --since="7 days ago" --all

echo ""
echo "=== STATS ==="
git log --since="7 days ago" --all --shortstat | tail -1

echo ""
echo "=== FILES MOST CHANGED ==="
git log --since="7 days ago" --all --name-only --pretty=format: | sort | uniq -c | sort -rn | head -10

echo ""
echo "=== BRANCHES WITH RECENT WORK ==="
git for-each-ref --sort=-committerdate --format='%(refname:short) %(committerdate:relative)' refs/heads/ | head -10
```

## Step 2: Report

### Activity summary
- Commits this week: count
- Files changed: count
- Lines added/removed: count

### Features shipped
List from commit messages. Group by theme if there are many.

### Open work
- Branches with uncommitted changes or no merge
- Any branch with no commits in 3+ days — flag as possibly abandoned

### Stale branches
```bash
git for-each-ref --sort=committerdate --format='%(refname:short) %(committerdate:relative)' refs/heads/ | while read branch date; do
  if git log -1 --since="3 days ago" "$branch" --oneline 2>/dev/null | grep -q .; then
    :
  else
    echo "STALE: $branch ($date)"
  fi
done
```

## Step 3: Assessment

One paragraph, honest:

- What's the pattern this week? (shipped a lot / got stuck / lots of refactoring / etc.)
- Any recurring issues? (same file changing every day = unstable, same type of bug = pattern)
- One concrete thing to do differently next week.

Keep the whole output under 40 lines. This is a self-check, not a performance review.
