#!/usr/bin/env bash
# install.sh — Symlink geo skills into Claude Code's skill directory
set -euo pipefail

SKILL_DIR="$HOME/.claude/skills/geo"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -L "$SKILL_DIR" ]; then
  echo "Removing existing symlink: $SKILL_DIR"
  rm "$SKILL_DIR"
elif [ -d "$SKILL_DIR" ]; then
  echo "Error: $SKILL_DIR already exists and is not a symlink."
  echo "Remove it manually if you want to proceed: rm -rf $SKILL_DIR"
  exit 1
fi

mkdir -p "$(dirname "$SKILL_DIR")"
ln -s "$SOURCE_DIR" "$SKILL_DIR"

# Create state directory for freeze/guard
mkdir -p "$HOME/.geo"

echo "Installed: $SOURCE_DIR -> $SKILL_DIR"
echo ""
echo "Skills available:"
echo "  /geo:office-hours     — Brainstorm and pressure-test ideas"
echo "  /geo:plan             — Lock architecture before coding"
echo "  /geo:review           — Pre-landing code review"
echo "  /geo:investigate      — Root-cause debugging"
echo "  /geo:qa               — Adversarial QA testing"
echo "  /geo:cso              — Security audit (OWASP + STRIDE)"
echo "  /geo:ship             — Pre-push checklist and PR creation"
echo "  /geo:document-release — Update docs after shipping"
echo "  /geo:retro            — Weekly retrospective"
echo "  /geo:careful          — Destructive command guardrails"
echo "  /geo:freeze           — Restrict edits to one directory"
echo "  /geo:unfreeze         — Remove freeze boundary"
echo "  /geo:guard            — Maximum safety mode (careful + freeze)"
echo ""
echo "Done. Restart Claude Code to pick up the new skills."
