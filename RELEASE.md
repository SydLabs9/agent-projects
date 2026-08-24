# Releasing agent-workflow

HITL loop. No auto-merge. Ask the human before push or tag.

This file is umbrella-only. Do not copy it into consumer repos.

## What gets copied

From `agent-workflow/` into each consumer:

- `.cursor/rules/00-coordination.mdc`
- `.cursor/rules/pm-agent.mdc`
- `.cursor/rules/eng-agent.mdc`
- `.cursor/rules/review-agent.mdc`
- `AGENTS.md`
- `.github/pull_request_template.md`
- `.github/ISSUE_TEMPLATE/pm-issue.md`

Never overwrite the consumer's `.cursor/rules/project-context.mdc` except the pin line.

Never copy `CONSUMERS.md`, `RELEASE.md`, or `scripts/` into a consumer.

## Run A — source change

1. Branch from `main` in this repo.
2. Change `agent-workflow/` (and this release kit if needed).
3. Show the human the diff. Commit locally.
4. Push and open a PR only after they say **push** / **send**.
5. Human reviews and merges.

## Run B — tag and sync consumers

1. After merge, tag `main` as `vX.Y.Z` (ask before creating or pushing the tag).
2. For each row in `CONSUMERS.md`, run:

```bash
./scripts/sync-workflow.sh /path/to/consumer-checkout vX.Y.Z
```

3. Open a consumer PR (`chore: pin agent-workflow to vX.Y.Z`) after they review.
4. Update the pin column in `CONSUMERS.md`.

## First policy in this line (v0.1.2 when tagged)

Secret values are not committable, including local-dev passwords. See `agent-workflow/.cursor/rules/00-coordination.mdc`.
