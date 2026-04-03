#!/usr/bin/env bash
# install.sh — Copy geo skills into Claude Code's skill directory
set -euo pipefail

# Resolve the target user's home directory.
# - If run with sudo, install for the invoking user, not root.
# - Otherwise, install for the current user running the script.
if [ -n "${SUDO_USER:-}" ] && [ "${SUDO_USER}" != "root" ]; then
	TARGET_USER="$SUDO_USER"
else
	TARGET_USER="$(id -un)"
fi

if command -v getent >/dev/null 2>&1; then
	USER_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
else
	USER_HOME="$(python3 - <<PY
	import pwd
	print(pwd.getpwnam("${TARGET_USER}").pw_dir)
PY
)"
fi

if [ -z "${USER_HOME:-}" ] || [ ! -d "$USER_HOME" ]; then
	echo "Could not determine a valid home directory for user: $TARGET_USER" >&2
	exit 1
fi

SKILLS_DIR="$USER_HOME/.claude/skills"
GEO_DIR="$SKILLS_DIR/geo"
STATE_DIR="$USER_HOME/.geo"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Sub-skills to install (directories containing SKILL.md)
SKILLS=(
	careful cso document-release freeze guard investigate
	office-hours plan qa retro review ship unfreeze
)

# Clean up stale sub-skill dirs from previous installs that nested inside geo/
if [ -d "$GEO_DIR" ]; then
	for skill in "${SKILLS[@]}"; do
		rm -rf "$GEO_DIR/$skill"
	done
fi

mkdir -p "$GEO_DIR"

# Copy root skill manifest and all sub-skills into geo/
cp "$SOURCE_DIR/SKILL.md" "$GEO_DIR/SKILL.md"

for skill in "${SKILLS[@]}"; do
	src="$SOURCE_DIR/$skill"
	if [ -d "$src" ] && [ -f "$src/SKILL.md" ]; then
		dest="$GEO_DIR/$skill"
		mkdir -p "$dest"
		cp "$src/SKILL.md" "$dest/SKILL.md"
		# Copy bin directory if present (hook scripts for careful, freeze, etc.)
		if [ -d "$src/bin" ]; then
			cp -r "$src/bin" "$dest/bin"
			chmod +x "$dest/bin/"*.sh 2>/dev/null || true
		fi
		# Symlink into top-level skills/ so Claude Code discovers it
		ln -sfn "geo/$skill" "$SKILLS_DIR/$skill"
		echo "  Installed: $skill"
	else
		echo "  Skipped (not found): $skill"
	fi
done

# Create state directory for freeze/guard
mkdir -p "$STATE_DIR"

echo ""
echo "Installed for user: $TARGET_USER"
echo "Skills installed to: $GEO_DIR"
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
echo "Done. This repo can be safely removed. Restart Claude Code to pick up the new skills."
