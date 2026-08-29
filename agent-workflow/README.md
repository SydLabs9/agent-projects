# agent-workflow

Multi-agent coordination for software development: **PM → Engineering → Review**.

Agents use **PROPOSE → APPROVE → EXECUTE** in Cursor. GitHub issues and labels coordinate handoffs; issue/PR templates keep structure consistent.

## Agents

| Agent | Activates when | Owns |
|-------|----------------|------|
| **PM** | New requirement, sprint/board queries | Issues, `status: ready-for-eng` |
| **Engineering** | `status: ready-for-eng` | Branch, code, PR, CI, `status: done` |
| **Review** | `Review PR #N` in Cursor (or PR opened) | Read-only AC + quality report |

Approval in Cursor: `create`, `start`, `send`, `go`, `approve`.

## Module layout

```
agent-workflow/
├── AGENTS.md
├── README.md
├── IMPLEMENTATION.md
├── .cursor/rules/
│   ├── 00-coordination.mdc
│   ├── pm-agent.mdc
│   ├── eng-agent.mdc
│   ├── review-agent.mdc
│   └── project-context.mdc
└── .github/
    ├── ISSUE_TEMPLATE/pm-issue.md
    └── pull_request_template.md
```

## Deploy to a target repo

```
your-repo/
├── AGENTS.md
├── .cursor/rules/          ← five .mdc files
└── .github/
    ├── ISSUE_TEMPLATE/pm-issue.md
    └── pull_request_template.md
```

Only `project-context.mdc` differs per repo. Update rules here, then re-sync to projects.

Releases, tags, and consumer sync live in the parent repo ([`CONSUMERS.md`](../CONSUMERS.md), [`RELEASE.md`](../RELEASE.md), [`scripts/sync-workflow.sh`](../scripts/sync-workflow.sh)). Do not copy those files into target repos.

## Setup checklist

- [ ] Copy module files into target repo (see root `README.md`)
- [ ] Fill in `project-context.mdc` (see [`examples/project-context.example.mdc`](./examples/project-context.example.mdc))
- [ ] Run label script in `00-coordination.mdc`
- [ ] Create GitHub labels + Project board (manual or `gh` — see `AGENTS.md`)
- [ ] Test: requirement in Cursor → PM draft → `create` → issue
- [ ] On Windows: create/edit issues with `gh … --body-file` (UTF-8) so emoji headings render
- [ ] Before push: `git log -1` has no vendor co-author trailers or "Made with …" footers
- [ ] Before/after `gh pr create` (and other GitHub body writes): body has no vendor footers; strip immediately if a tool appended one

Optional later: GitHub Actions for Slack/board automation (not included in this module yet).

## Docs

- [`AGENTS.md`](./AGENTS.md) — contract, labels, setup
- [`examples/project-context.example.mdc`](./examples/project-context.example.mdc) — sample filled context
- [`IMPLEMENTATION.md`](./IMPLEMENTATION.md) — per-file rationale and AI concept map
