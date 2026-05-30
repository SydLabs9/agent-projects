# AGENTS.md

This file lives at the root of every repo in this system.
All agents read it on activation. It is the master coordination contract.

---

## Agent Roster

| Agent | Rules File | Activates When | Owns |
|-------|-----------|---------------|------|
| **PM Agent** | `.cursor/rules/pm-agent.mdc` | New requirement given / Slack input / board query | Issue creation, board, milestones, sprint |
| **Engineering Agent** | `.cursor/rules/eng-agent.mdc` | Issue labeled `status: ready-for-eng` | Branch, implementation, PR, CI, `status: done` |
| **Review Agent** | `.cursor/rules/review-agent.mdc` | PR opened or updated | Read-only review, AC coverage, Slack report |

---

## Semi-Autonomous Operation

Every agent uses **PROPOSE → APPROVE → EXECUTE**.

No agent executes any action — create issue, start branch, open PR, merge —
without explicit human approval. Approval words: `create`, `start`, `send`, `go`, `approve`.

---

## The Label Contract

```
PM Agent Sets                    Engineering Agent Reacts
──────────────────────           ────────────────────────────
status: backlog                  (no reaction)
status: refinement               (no reaction)
status: ready-for-eng     ──►   Pickup trigger

Engineering Agent Sets           PM Agent Reacts
──────────────────────           ────────────────────────────
status: in-progress       ──►   Move board card
status: in-review         ──►   Move card + Slack notify
status: done              ──►   Close issue + milestone
status: blocked           ──►   Slack escalation
status: needs-clarification ──► Re-open for scoping
```

---

## Issue Body Ownership

| Section | Owner | Other agent... |
|---------|-------|----------------|
| `## 📋 Business Requirement` | PM | reads only |
| `## 🎯 Acceptance Criteria` | PM | reads only |
| `## 📐 Scope` | PM | reads only |
| `## 🔗 Business Context` | PM | reads only |
| `## 🤝 Engineering Handoff` | **Engineering** | PM reads only |
| `## 🏷️ Metadata` | PM (initial) | Eng updates `status` field only |

---

## Multi-Repo Rules

- `00-coordination.mdc`, `pm-agent.mdc`, `eng-agent.mdc`, `review-agent.mdc` — identical across all repos
- `project-context.mdc` — unique per repo (stack, personas, board IDs, channels)
- When agent rules are updated in `agents-config`, sync copies to all project repos

---

## Required GitHub Secrets (per repo)

```
GITHUB_TOKEN                 # PAT: repo + projects + issues scopes
SLACK_BOT_TOKEN              # xoxb-... Bot OAuth token
SLACK_CHANNEL_DEV            # Channel ID for dev work
SLACK_CHANNEL_TRACKING       # Channel ID for project tracking
IN_PROGRESS_COLUMN_ID        # GitHub Project column ID
IN_REVIEW_COLUMN_ID          # GitHub Project column ID
DONE_COLUMN_ID               # GitHub Project column ID
```

---

## Setup Checklist (new repo)

- [ ] Copy all 5 `.cursor/rules/*.mdc` files from `agents-config`
- [ ] Fill in `project-context.mdc` for this repo
- [ ] Copy `.github/workflows/agent-router.yml`
- [ ] Copy `.github/ISSUE_TEMPLATE/pm-issue.md`
- [ ] Copy `.github/pull_request_template.md`
- [ ] Run label creation script from `00-coordination.mdc`
- [ ] Add all required secrets to repo settings
- [ ] Create GitHub Project board with 6 columns
- [ ] Fill in column IDs in `project-context.mdc` and secrets
- [ ] Test: type a requirement in Cursor → verify PM Agent proposes an issue
