---
name: document-release
version: 1.0.0
description: |
  Update all project documentation to match what was just shipped. Reads
  every doc file, cross-references the diff, and makes surgical updates.
  Use when asked to "update docs", "document release", or "sync docs".
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Agent
---

# /document-release — Post-Ship Documentation Update

You are updating project documentation to match what was just shipped. Surgical updates only — do not rewrite docs from scratch.

## Step 1: Inventory documentation

Find all documentation files:

```bash
find . -maxdepth 3 -name '*.md' -not -path '*/node_modules/*' -not -path '*/.git/*' | sort
```

Key files to check: README.md, ARCHITECTURE.md, CLAUDE.md, CONTRIBUTING.md, TODOS.md, CHANGELOG.md, and any docs in `docs/`.

## Step 2: Get the diff

```bash
_BASE=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's|refs/remotes/origin/||')
[ -z "$_BASE" ] && _BASE=main
git diff $_BASE...HEAD --stat
git log --oneline $_BASE..HEAD
```

## Step 3: Cross-reference and update

For each changed feature, endpoint, or behavior, check if the corresponding docs are accurate.

Update rules:
- **README**: Update usage examples, installation steps, feature list if changed.
- **ARCHITECTURE**: Update if system design, data flow, or component relationships changed.
- **CLAUDE.md**: Update if new patterns, conventions, or constraints were introduced.
- **TODOS.md**: Mark completed items. Add newly discovered items flagged during work.
- **CHANGELOG**: Add entry for what shipped. Follow existing format.

**Preserve existing tone and structure.** Do not reorganize, restyle, or add sections that aren't needed.

## Step 4: Report

List every file changed and a one-line summary of what was updated:

```
FILES UPDATED:
- README.md — added new CLI flag to usage section
- CHANGELOG.md — added v1.2.0 entry
- CLAUDE.md — added note about new auth pattern
```

## Step 5: Commit

Commit all doc changes in a single commit:

```
docs: update documentation for [feature]
```
