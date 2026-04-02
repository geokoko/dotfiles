---
name: unfreeze
version: 1.0.0
description: |
  Remove the active freeze boundary set by /freeze, allowing edits to all
  directories again. Use when asked to "unfreeze", "unlock edits", "remove
  freeze", or "allow all edits".
allowed-tools:
  - Bash
  - Read
---

# /unfreeze — Remove Freeze Boundary

Remove the active edit restriction.

```bash
STATE_DIR="${CLAUDE_PLUGIN_DATA:-$HOME/.geo}"
rm -f "$STATE_DIR/freeze-dir.txt" 2>/dev/null
echo "Freeze lifted."
```

Confirm to the user: **"Freeze lifted. All files are editable."**
