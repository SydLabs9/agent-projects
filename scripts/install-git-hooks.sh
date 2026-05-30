#!/usr/bin/env bash
# Per-repo hook override — rarely needed. Prefer global install.
set -euo pipefail

echo "Prefer global hooks:" >&2
echo "  ~/tech/AI/cursor/git-hooks/install.sh" >&2
echo "" >&2
echo "To override only this repo, copy hooks from ~/tech/AI/cursor/git-hooks/ to .githooks/ and run:" >&2
echo "  git config core.hooksPath .githooks" >&2
exit 1
