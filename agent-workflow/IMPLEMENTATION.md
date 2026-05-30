# Multi-Agent System — Implementation Summary

Module name: **`agent-workflow`**. Canonical source lives under `agent-projects/agent-workflow/`. Copy into each **target project repo** per [README.md](./README.md).

## What This System Is

A semi-autonomous AI agent system for software development across GitHub, Slack, and Cursor. Three agents coordinate through a shared event contract. You approve every write action.

---

## The 10 Artifacts

Paths are relative to `agent-workflow/` (or `.cursor/rules/` / `.github/` after deploy).

### 1. `.cursor/rules/00-coordination.mdc`

Shared constitution: HITL loop, label ownership, Slack format, forbidden actions.

**Patterns:** System prompt + shared context, Human-in-the-Loop.

### 2. `.cursor/rules/pm-agent.mdc`

Product Owner persona: issue drafts, sprint/board queries, structured issue output.

**Patterns:** Agent persona, structured output as inter-agent contract, tool use (GitHub API).

### 3. `.cursor/rules/eng-agent.mdc`

Engineer persona: pickup at `ready-for-eng`, implementation plan, branch/PR/CI lifecycle.

**Patterns:** Multi-step agentic reasoning, controlled interruption on scope/CI failures.

### 4. `.cursor/rules/review-agent.mdc`

Read-only reviewer: PR diff + issue ACs → structured report.

**Patterns:** RAG-lite (ground in PR + issue), evals as AC coverage checks.

### 5. `.cursor/rules/project-context.mdc`

Per-repo only: stack, personas, board IDs, channels.

**Patterns:** Dynamic context injection — one rule set, many repos.

### 6. `AGENTS.md`

Human-readable state machine: roster, labels, handoffs, secrets, setup.

Copy to **target repo root** on bootstrap (not required at `agent-projects` root).

**Patterns:** Explicit multi-agent coordination protocol.

### 7. `.github/workflows/agent-router.yml`

Issue **label** events → board moves + Slack (optional if secrets unset).

**Patterns:** Event-driven orchestration.

### 8. `.github/workflows/pr-review.yml`

PR events → PR comment with `Review PR #N` + optional Slack. Review runs in **Cursor**, not in CI.

**Patterns:** Orchestration (GitHub) separated from cognition (Cursor).

### 9. `.github/ISSUE_TEMPLATE/pm-issue.md`

Schema for PM output / Eng input.

**Patterns:** Schema-as-contract between agents.

### 10. `.github/pull_request_template.md`

Forces `Closes #N` and AC coverage mapping.

**Patterns:** Output grounding to requirements.

---

## Concept map

```
System Prompting  → coordination + agent .mdc files
Agent Personas    → pm / eng / review
Tool Use          → GitHub + Slack APIs
Structured Output → issue + PR templates
HITL              → PROPOSE → APPROVE → EXECUTE
RAG (lite)        → review agent + issue + PR
Orchestration     → agent-router.yml + pr-review.yml
Multi-agent coord → labels + AGENTS.md
Dynamic context   → project-context.mdc
```

## How pieces connect

```
You (Cursor) → .mdc personas → GitHub issues/PRs
                    ↓
         agent-router.yml (labels) → Slack
         pr-review.yml (PRs) → comment → "Review PR #N" in Cursor
```

---

## Build next

**Short term:** Fill `project-context.mdc`, run one full loop, validate HITL.

**Medium term:** Memory, issue RAG for PM dedup, routing orchestrator, PM output evals.

**Long term:** LangGraph, CrewAI, Assistants API, MCP (Cursor already uses MCP for tools).

---

See also: [README.md](./README.md), [AGENTS.md](./AGENTS.md).
