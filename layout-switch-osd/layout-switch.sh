#!/usr/bin/env bash
set -euo pipefail

# Pick qdbus6 (Plasma 6) or qdbus (Plasma 5)
if command -v qdbus6 >/dev/null 2>&1; then
  QDBUS=qdbus6
else
  QDBUS=qdbus
fi

# Plasma 6 DBus service/path (common on Wayland + recent distros)
SVC="org.kde.plasmashell"
PATH_KB="/org/kde/KeyboardLayouts"
IFACE="org.kde.KeyboardLayouts"

# --- switch to next layout ---
# Different Plasma versions expose different method names.
# Try a few in order until one works.
switched=0
for method in switchToNextLayout nextLayout switchToNext; do
  if "$QDBUS" "$SVC" "$PATH_KB" "$IFACE.$method" >/dev/null 2>&1; then
    switched=1
    break
  fi
done

if [[ "$switched" -ne 1 ]]; then
  notify-send -u normal -t 1500 "Layout" "Could not switch (DBus method not found)"
  exit 1
fi

# --- read current layout and show it ---
layout="$("$QDBUS" "$SVC" "$PATH_KB" "$IFACE.currentLayout" 2>/dev/null || true)"

case "$layout" in
  us) label="EN" ;;
  gr) label="EL" ;;
  "") label="UNKNOWN" ;;
  *)  label="$layout" ;;
esac

notify-send -u low -t 900 "Layout" "$label"
