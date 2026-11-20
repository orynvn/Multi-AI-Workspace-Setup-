#!/usr/bin/env bash
# Stop hook — ask the agent to log today's work in .context/HISTORY.md before stopping.
# Shared by Claude Code and Codex. Blocks (decision: block) only when:
#   - the working tree has changes outside .context/, AND
#   - HISTORY.md has no entry dated today, AND
#   - we are not already continuing because of this hook (stop_hook_active).
set -uo pipefail

INPUT=$(cat)
ACTIVE=$(echo "$INPUT" | python3 -c 'import sys,json; print(str(json.load(sys.stdin).get("stop_hook_active", False)).lower())' 2>/dev/null || echo false)
[ "$ACTIVE" = "true" ] && exit 0

ROOT="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"
cd "$ROOT" || exit 0
HISTORY=".context/HISTORY.md"
[ -f "$HISTORY" ] || exit 0

grep -q "^\[$(date +%Y-%m-%d)\]" "$HISTORY" && exit 0
git status --porcelain 2>/dev/null | grep -qv ' \.context/' || exit 0

cat <<'JSON'
{"decision": "block", "reason": "Files changed this session but .context/HISTORY.md has no entry for today. Run: bash .context/log.sh \"<type>: <description> — <files>\" (it also syncs ACTIVE.md Recent Context). Update .context/FILE-INDEX.md / ERRORS.md / DECISIONS.md if relevant, then stop."}
JSON
exit 0
