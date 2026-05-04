#!/usr/bin/env bash
# session-stop.sh
# VS Code Agent Hook — Stop event
# Reminds user to update .context/HISTORY.md when the session ends

set -euo pipefail

INPUT=$(cat)

# Check if stop_hook_active to avoid infinite loops
if command -v jq &>/dev/null; then
  ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // false' 2>/dev/null || echo "false")
  if [[ "$ACTIVE" == "true" ]]; then
    echo '{}'
    exit 0
  fi
fi

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
HISTORY="$ROOT/.context/HISTORY.md"
ACTIVE="$ROOT/.context/ACTIVE.md"

# Only remind if HISTORY.md has not been updated today
TODAY=$(date +%Y-%m-%d)
if [[ -f "$HISTORY" ]] && grep -q "^\[$TODAY\]" "$HISTORY" 2>/dev/null; then
  # Auto-update Recent Context in ACTIVE.md (last 3 HISTORY entries)
  if [[ -f "$ACTIVE" ]] && command -v grep &>/dev/null; then
    RECENT=$(grep "^\[" "$HISTORY" | tail -3 || echo "(none)")
    # Replace the Recent Context section
    if grep -q "^## Recent Context" "$ACTIVE" 2>/dev/null; then
      awk -v recent="$RECENT" '
        /^## Recent Context/ { print; print ""; split(recent, lines, "\n"); for(i in lines) print "- " lines[i]; skip=1; next }
        skip && /^## / { skip=0 }
        !skip { print }
      ' "$ACTIVE" > "$ACTIVE.tmp" && mv "$ACTIVE.tmp" "$ACTIVE"
    fi
  fi
  echo '{}'
else
  MSG="Session ended. Please update .context/HISTORY.md and .context/ACTIVE.md before closing."
  printf '{"hookSpecificOutput":{"hookEventName":"Stop","decision":"block","reason":"%s"}}' "$MSG"
fi
