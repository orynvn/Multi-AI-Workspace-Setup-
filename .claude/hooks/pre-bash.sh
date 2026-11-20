#!/usr/bin/env bash
# PreToolUse hook (Bash) — block destructive shell commands before execution.
# Shared by Claude Code (.claude/settings.json) and Codex (.codex/hooks.json).
# Input: hook JSON on stdin → tool_input.command. Exit 2 + stderr = block.
set -uo pipefail

CMD=$(python3 -c 'import sys,json; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null || true)
[ -z "$CMD" ] && exit 0

BLOCKED=""
check()  { echo "$CMD" | grep -qE  "$1" && BLOCKED="$2"; }   # case-sensitive (git/rm flags)
checki() { echo "$CMD" | grep -qiE "$1" && BLOCKED="$2"; }   # case-insensitive (SQL)
# Command position: line start or after ; & | ( then optional sudo/xargs/env — avoids matching text inside strings/docs
AT='(^|[;&|(])[[:space:]]*((sudo|xargs|env|command)[[:space:]]+)*'

# Destructive DB operations
checki 'DROP[[:space:]]+(TABLE|DATABASE|SCHEMA)' "DROP TABLE/DATABASE/SCHEMA"
checki 'TRUNCATE[[:space:]]+' "TRUNCATE"
if echo "$CMD" | grep -qiE 'DELETE[[:space:]]+FROM' && ! echo "$CMD" | grep -qi 'WHERE'; then
  BLOCKED="DELETE FROM without WHERE"
fi

# Destructive git operations
check "$AT"'git[[:space:]]+push.*(--force|[[:space:]]-f([[:space:]]|$))' "git push --force"
check "$AT"'git[[:space:]]+reset[[:space:]]+--hard' "git reset --hard"
check "$AT"'git[[:space:]]+clean[[:space:]]+-[a-z]*f' "git clean -f"
check "$AT"'git[[:space:]]+branch[[:space:]]+-[a-z]*D' "git branch -D"

# Destructive filesystem
check "$AT"'rm[[:space:]]+(-[a-z]*r[a-z]*f|-[a-z]*f[a-z]*r|--recursive)' "rm -rf"

if [ -n "$BLOCKED" ]; then
  echo "BLOCKED: destructive operation '$BLOCKED'. Ask the user to confirm and run it manually. Command: $CMD" >&2
  exit 2
fi
exit 0
