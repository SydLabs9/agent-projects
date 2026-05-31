# Multi-Agent System — Implementation Summary

Module: **`agent-workflow`**. Copy into each **target project repo** per [README.md](./README.md).

## What This System Is

Semi-autonomous dev workflow in **Cursor** with GitHub issues/PRs as shared state. Three agents, HITL on every write. Slack/GitHub Actions automation is optional and not shipped in this module yet.

---

## The 8 Artifacts

Paths relative to `agent-workflow/` (or `.cursor/rules/` / `.github/` after deploy).

### 1–5. `.cursor/rules/*.mdc`

| File | Role |
|------|------|
| `00-coordination.mdc` | Shared constitution, HITL, labels |
| `pm-agent.mdc` | Product Owner, issues |
| `eng-agent.mdc` | Implementation, PR lifecycle |
| `review-agent.mdc` | Read-only PR review |
| `project-context.mdc` | Per-repo stack, personas, board |

### 6. `AGENTS.md`

Roster, label contract, setup — copy to target repo root.

### 7. `.github/ISSUE_TEMPLATE/pm-issue.md`

Structured issue schema (PM → Eng contract).

### 8. `.github/pull_request_template.md`

PR grounding (`Closes #N`, AC coverage).

---

## Concept map

```
System Prompting  → coordination + agent .mdc files
Agent Personas    → pm / eng / review
Tool Use          → GitHub API (Slack optional, manual for now)
Structured Output → issue + PR templates
HITL              → PROPOSE → APPROVE → EXECUTE
RAG (lite)        → review agent + issue + PR
Multi-agent coord → labels + AGENTS.md
Dynamic context   → project-context.mdc
```

## How pieces connect

```
You (Cursor) → .mdc personas → GitHub issues / PRs / labels
Review: ask "Review PR #N" in Cursor (or add Actions later for PR comments)
```

---

## Build next

**Short term:** Fill `project-context.mdc`, one full loop in a target repo.

**Optional:** Add `.github/workflows/` (label → Slack, PR activation) when you need automation.

**Medium term:** Memory, PM issue RAG, evals, LangGraph/CrewAI if you outgrow rules-only.

---

See [README.md](./README.md), [AGENTS.md](./AGENTS.md).
