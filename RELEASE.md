# Releasing agent-workflow

HITL loop. No auto-merge. Ask the human before push or tag.

This file is umbrella-only. Do not copy it into consumer repos.

## Source of truth

Canonical kit: `SydLabs9/agent-projects` (`agent-workflow/`).

- Incubate on branches off `main` (`feat/`, `fix/`, `chore/`). Do not tag those branches.
- Ship by merging to `main`, then tagging `main` as `vX.Y.Z` (ask before tagging).
- No fork under sydlab. sydlab repos are products and consumers; they copy a tag, they do not host the kit.
- Consumers pin **org tags**, never `main` and never a feature branch.
- Do not sync a consumer until the human asks. Updating this ledger is allowed without a consumer sync.
- Repo-specific rules stay in that repo's `project-context.mdc`. Promote a rule into this kit only when a second consumer should get it.

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

Umbrella-only files (this file, `CONSUMERS.md`, root `README.md`, `scripts/`) can change without a new tag. A new tag is required only when the copy set above changes.

## Run A — source change

1. Branch from `main` in this repo.
2. Change `agent-workflow/` (and this release kit if needed).
3. Show the human the diff. Commit locally.
4. Push and open a PR only after they say **push** / **send**.
5. Human reviews and merges.

## Run B — tag and sync consumers

1. After merge, tag `main` as `vX.Y.Z` **only if the copy set changed** (ask before creating or pushing the tag).
2. Sync a consumer only when the human asks. Then, for each requested row in `CONSUMERS.md`:

```bash
./scripts/sync-workflow.sh /path/to/consumer-checkout vX.Y.Z
```

3. Open a consumer PR (`chore: pin agent-workflow to vX.Y.Z`) after they review.
4. Keep the pin column in `CONSUMERS.md` accurate even when no sync ran (ledger may catch up to a pin the consumer already has).

## Current line (v0.1.2)

Secret values are not committable, including local-dev passwords. See `agent-workflow/.cursor/rules/00-coordination.mdc`.

Live consumer `sydlab/course-registrations` stays on `v0.1.2` until an explicit sync is requested.
