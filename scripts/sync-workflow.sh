#!/usr/bin/env bash
# Copy shared agent-workflow files into a consumer checkout.
# Does not overwrite project-context.mdc. Updates the pin string if a tag is given.

set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "usage: $0 <consumer-repo-path> [tag]" >&2
  exit 1
fi

CONSUMER="$(cd "$1" && pwd)"
TAG="${2:-}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MODULE="$ROOT/agent-workflow"

if [[ ! -d "$MODULE/.cursor/rules" ]]; then
  echo "sync-workflow: missing $MODULE/.cursor/rules" >&2
  exit 1
fi

mkdir -p "$CONSUMER/.cursor/rules" "$CONSUMER/.github/ISSUE_TEMPLATE"

cp "$MODULE/.cursor/rules/00-coordination.mdc" "$CONSUMER/.cursor/rules/"
cp "$MODULE/.cursor/rules/pm-agent.mdc" "$CONSUMER/.cursor/rules/"
cp "$MODULE/.cursor/rules/eng-agent.mdc" "$CONSUMER/.cursor/rules/"
cp "$MODULE/.cursor/rules/review-agent.mdc" "$CONSUMER/.cursor/rules/"
cp "$MODULE/AGENTS.md" "$CONSUMER/AGENTS.md"
cp "$MODULE/.github/pull_request_template.md" "$CONSUMER/.github/"
cp "$MODULE/.github/ISSUE_TEMPLATE/pm-issue.md" "$CONSUMER/.github/ISSUE_TEMPLATE/"

if [[ -n "$TAG" && -f "$CONSUMER/.cursor/rules/project-context.mdc" ]]; then
  perl -pi -e "s/agent-workflow tag \\*\\*v[0-9.]+\\*\\*/agent-workflow tag **${TAG}**/g" \
    "$CONSUMER/.cursor/rules/project-context.mdc"
  perl -pi -e "s/Pin agent-workflow reference to v[0-9.]+/Pin agent-workflow reference to ${TAG}/g" \
    "$CONSUMER/.cursor/rules/project-context.mdc"
  if [[ -f "$CONSUMER/README.md" ]]; then
    perl -pi -e "s/agent-workflow\` @ \`v[0-9.]+/agent-workflow\` @ \`${TAG}/g" \
      "$CONSUMER/README.md"
  fi
fi

echo "synced agent-workflow into $CONSUMER${TAG:+ (pin $TAG)}"
