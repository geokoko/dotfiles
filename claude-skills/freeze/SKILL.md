---
name: freeze
version: 1.0.0
description: |
  Restrict file edits to a specific directory for the session. Blocks Edit and
  Write outside the allowed path. Use when debugging to prevent accidentally
  "fixing" unrelated code, or when you want to scope changes to one module.
  Use when asked to "freeze", "restrict edits", "only edit this folder",
  or "lock down edits".
allowed-tools:
  - Bash
  - Read
  - AskUserQuestion
hooks:
  PreToolUse:
    - matcher: "Edit"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
    - matcher: "Write"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
---

# /freeze — Restrict Edits to a Directory

Lock file edits to a specific directory. Any Edit or Write targeting a file outside the allowed path will be **blocked**.

## Setup

Ask the user which directory to restrict edits to. Use AskUserQuestion:

- Question: "Which directory should I restrict edits to? Files outside this path will be blocked from editing."
- Text input — the user types a path.

Once the user provides a directory path:

1. Resolve to absolute path:
```bash
FREEZE_DIR=$(cd "<user-provided-path>" 2>/dev/null && pwd)
echo "$FREEZE_DIR"
```

2. Save to state file:
```bash
FREEZE_DIR="${FREEZE_DIR%/}/"
STATE_DIR="${CLAUDE_PLUGIN_DATA:-$HOME/.geo}"
mkdir -p "$STATE_DIR"
echo "$FREEZE_DIR" > "$STATE_DIR/freeze-dir.txt"
echo "Freeze boundary set: $FREEZE_DIR"
```

Tell the user: "Edits are now restricted to `<path>/`. Any Edit or Write outside this directory will be blocked. Run `/geo:unfreeze` to remove the boundary."

## How it works

The hook reads `file_path` from Edit/Write tool input and checks if it starts with the freeze directory. If not, it returns `permissionDecision: "deny"` to block the operation.

## Notes

- Trailing `/` prevents `/src` from matching `/src-old`
- Freeze applies to Edit and Write only — Read, Bash, Glob, Grep are unaffected
- To change the boundary, run `/geo:freeze` again
- To remove, run `/geo:unfreeze` or end the session
