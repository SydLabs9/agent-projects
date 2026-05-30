#!/usr/bin/env bash
# Delegates to global hook source under ~/tech/AI/cursor/git-hooks/
set -euo pipefail

CURSOR_HOOKS="${HOME}/tech/AI/cursor/git-hooks/install.sh"

if [[ ! -x "$CURSOR_HOOKS" ]]; then
  echo "Missing $CURSOR_HOOKS" >&2
  exit 1
fi

exec "$CURSOR_HOOKS"
