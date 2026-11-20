#!/usr/bin/env bash
# PostToolUse hook (Edit|Write) — auto-format/lint the edited file based on detected stack.
# Input: hook JSON on stdin → tool_input.file_path. Never blocks (always exit 0).
set -uo pipefail

FILE=$(python3 -c 'import sys,json; print(json.load(sys.stdin).get("tool_input",{}).get("file_path",""))' 2>/dev/null || true)
[ -z "$FILE" ] || [ ! -f "$FILE" ] && exit 0

has_eslint() { ls .eslintrc.js .eslintrc.cjs .eslintrc.json eslint.config.js eslint.config.mjs eslint.config.cjs eslint.config.ts >/dev/null 2>&1; }

case "${FILE##*.}" in
  php)
    [ -x vendor/bin/pint ] && vendor/bin/pint "$FILE" --quiet ;;
  ts|tsx|js|jsx|mjs|cjs)
    has_eslint && npx --no-install eslint "$FILE" --fix --quiet ;;
  py)
    command -v ruff >/dev/null && { ruff check --fix --quiet "$FILE"; ruff format --quiet "$FILE"; } ;;
  go)
    command -v gofmt >/dev/null && gofmt -w "$FILE" ;;
  rb)
    command -v rubocop >/dev/null && rubocop --autocorrect --format quiet "$FILE" ;;
esac >/dev/null 2>&1

exit 0
