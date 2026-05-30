# agent-workflow

Multi-agent coordination for software development: **PM → Engineering → Review**.

Agents use **PROPOSE → APPROVE → EXECUTE**. GitHub issue labels are the API between agents; Actions handle board/Slack side effects; reviews run in Cursor.

## Agents

| Agent | Activates when | Owns |
|-------|----------------|------|
| **PM** | New requirement, sprint/board queries | Issues, `status: ready-for-eng` |
| **Engineering** | `status: ready-for-eng` | Branch, code, PR, CI, `status: done` |
| **Review** | PR opened/updated (signal) or `Review PR #N` in Cursor | Read-only AC + quality report |

Approval in Cursor: `create`, `start`, `send`, `go`, `approve`.

## Module layout

```
agent-workflow/
├── AGENTS.md                         # copy to target repo root on deploy
├── README.md
├── IMPLEMENTATION.md
├── .cursor/rules/
│   ├── 00-coordination.mdc           # alwaysApply
│   ├── pm-agent.mdc
│   ├── eng-agent.mdc
│   ├── review-agent.mdc
│   └── project-context.mdc           # fill per target repo
└── .github/
    ├── ISSUE_TEMPLATE/pm-issue.md
    ├── pull_request_template.md
    └── workflows/
        ├── agent-router.yml          # issue labels → board + Slack
        └── pr-review.yml             # PR events → Cursor review signal
```

## Deploy to a target repo

After copy, the target should look like:

```
your-repo/
├── AGENTS.md
├── .cursor/rules/          ← five .mdc files
└── .github/
    ├── ISSUE_TEMPLATE/pm-issue.md
    ├── pull_request_template.md
    └── workflows/
        ├── agent-router.yml
        └── pr-review.yml
```

Only `project-context.mdc` differs per repo. Update rules here, then re-sync to projects.

## Setup checklist

- [ ] Copy module files into target repo (see root `README.md` bootstrap)
- [ ] Fill in `project-context.mdc`
- [ ] Run label script in `00-coordination.mdc`
- [ ] Add GitHub secrets (`AGENTS.md`) — Slack optional for first loop
- [ ] Create Project board + column IDs
- [ ] Test: requirement in Cursor → PM draft → `create` → issue

## Docs

- [`AGENTS.md`](./AGENTS.md) — contract, secrets, label flow
- [`IMPLEMENTATION.md`](./IMPLEMENTATION.md) — per-file rationale and AI concept map
