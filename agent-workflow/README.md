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

## Setup checklist

- [ ] Copy module files into target repo (see root `README.md`)
- [ ] Fill in `project-context.mdc`
- [ ] Run label script in `00-coordination.mdc`
- [ ] Create GitHub labels + Project board (manual or `gh` — see `AGENTS.md`)
- [ ] Test: requirement in Cursor → PM draft → `create` → issue

Optional later: GitHub Actions for Slack/board automation (not included in this module yet).

## Docs

- [`AGENTS.md`](./AGENTS.md) — contract, labels, secrets reference
- [`IMPLEMENTATION.md`](./IMPLEMENTATION.md) — per-file rationale and AI concept map
