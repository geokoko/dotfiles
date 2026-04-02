#!/usr/bin/env bash
# check-freeze.sh — PreToolUse hook for /freeze
# Reads JSON from stdin, checks if file_path is within the freeze boundary.
# Returns {"permissionDecision":"deny","message":"..."} to block, or {} to allow.
set -euo pipefail

INPUT=$(cat)

# Locate freeze state file
STATE_DIR="${CLAUDE_PLUGIN_DATA:-$HOME/.geo}"
FREEZE_FILE="$STATE_DIR/freeze-dir.txt"

# No freeze file = allow everything
if [ ! -f "$FREEZE_FILE" ]; then
  echo '{}'
  exit 0
fi

FREEZE_DIR=$(tr -d '[:space:]' < "$FREEZE_FILE")

if [ -z "$FREEZE_DIR" ]; then
  echo '{}'
  exit 0
fi

# Extract file_path from tool_input JSON
FILE_PATH=$(printf '%s' "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*:[[:space:]]*"//;s/"$//' || true)

# Python fallback
if [ -z "$FILE_PATH" ]; then
  FILE_PATH=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; print(json.loads(sys.stdin.read()).get("tool_input",{}).get("file_path",""))' 2>/dev/null || true)
fi

if [ -z "$FILE_PATH" ]; then
  echo '{}'
  exit 0
fi

# Resolve to absolute path
case "$FILE_PATH" in
  /*) ;;
  *) FILE_PATH="$(pwd)/$FILE_PATH" ;;
esac

# Normalize
FILE_PATH=$(printf '%s' "$FILE_PATH" | sed 's|/\+|/|g;s|/$||')

# Check boundary
case "$FILE_PATH" in
  "${FREEZE_DIR}"*)
    echo '{}'
    ;;
  *)
    printf '{"permissionDecision":"deny","message":"[freeze] Blocked: %s is outside the freeze boundary (%s). Only edits within the frozen directory are allowed."}\n' "$FILE_PATH" "$FREEZE_DIR"
    ;;
esac
