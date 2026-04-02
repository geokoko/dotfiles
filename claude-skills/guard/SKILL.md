---
name: guard
version: 1.0.0
description: |
  Maximum safety mode. Activates both /careful (destructive command warnings)
  and /freeze (directory-scoped edits) together. Use for production debugging,
  overnight autonomous runs, or any high-stakes session. Use when asked to
  "guard", "max safety", "safe mode", or "lockdown".
allowed-tools:
  - Bash
  - Read
  - AskUserQuestion
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/../careful/bin/check-careful.sh"
          statusMessage: "Checking for destructive commands..."
    - matcher: "Edit"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/../freeze/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
    - matcher: "Write"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/../freeze/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
---

# /guard — Maximum Safety Mode

Both safety guardrails are now active:

1. **Destructive command warnings** — every bash command checked for dangerous patterns (same as `/geo:careful`)
2. **Directory-scoped edits** — Edit and Write blocked outside a specified directory (same as `/geo:freeze`)

## Setup

The destructive command guardrails activate immediately.

For the freeze boundary: ask the user which directory to restrict edits to.

Use AskUserQuestion:
- Question: "Which directory should I restrict edits to? (Leave empty to skip freeze and only use destructive command warnings)"
- Text input — the user types a path.

If the user provides a directory:

```bash
FREEZE_DIR=$(cd "<user-provided-path>" 2>/dev/null && pwd)
FREEZE_DIR="${FREEZE_DIR%/}/"
STATE_DIR="${CLAUDE_PLUGIN_DATA:-$HOME/.geo}"
mkdir -p "$STATE_DIR"
echo "$FREEZE_DIR" > "$STATE_DIR/freeze-dir.txt"
echo "Guard active: destructive command warnings ON + edits locked to $FREEZE_DIR"
```

If the user skips the directory, only destructive command warnings are active.

## To deactivate

- End the session, or
- Run `/geo:unfreeze` to remove only the freeze boundary (careful stays active)
