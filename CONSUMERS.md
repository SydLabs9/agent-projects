# agent-workflow consumers

Repos that copy `agent-workflow/` (except `project-context.mdc`) and pin a release tag.

| Repo | Pin | Notes |
|------|-----|--------|
| [sydlab/course-registrations](https://github.com/sydlab/course-registrations) | `v0.1.1` | Update pin when syncing |

Do not copy this file into consumers. It lives only in this umbrella repo.

To add a consumer, append a row, then run `scripts/sync-workflow.sh`.
