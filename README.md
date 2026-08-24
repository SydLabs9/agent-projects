# agent-projects

Umbrella repo for AI agent workflow modules.

## Modules

| Module | Description |
|--------|-------------|
| [`agent-workflow/`](./agent-workflow/) | PM → Engineering → Review (Cursor rules, GitHub templates) |

## Bootstrap a target repo

```bash
MODULE=path/to/agent-projects/agent-workflow

mkdir -p .cursor/rules .github/ISSUE_TEMPLATE
cp -R "$MODULE/.cursor/rules/"* .cursor/rules/
cp "$MODULE/AGENTS.md" .
cp "$MODULE/.github/pull_request_template.md" .github/
cp "$MODULE/.github/ISSUE_TEMPLATE/pm-issue.md" .github/ISSUE_TEMPLATE/

# Fill .cursor/rules/project-context.mdc — see examples/project-context.example.mdc
```

Full checklist: [`agent-workflow/README.md`](./agent-workflow/README.md).

## Pin a release (recommended)

Canonical kit is this repo (`SydLabs9/agent-projects`). Incubate on branches; ship by merging to `main` and tagging. sydlab repos consume a tag — they do not fork this kit.

Bootstrap from a tag on `main` (current: `v0.1.2`), not a floating branch tip, so target repos do not drift.

```bash
git clone https://github.com/SydLabs9/agent-projects.git
cd agent-projects && git checkout v0.1.2
```

Then copy from `agent-workflow/` as above. To refresh a consumer, use [`scripts/sync-workflow.sh`](scripts/sync-workflow.sh) **only when asked**. See [`RELEASE.md`](RELEASE.md) and [`CONSUMERS.md`](CONSUMERS.md).

## Layout

```
agent-projects/
├── README.md
├── CONSUMERS.md
├── RELEASE.md
├── scripts/sync-workflow.sh
└── agent-workflow/
    ├── AGENTS.md
    ├── examples/
    ├── .cursor/rules/
    └── .github/
```

## Global commit policy (not in this repo)

| What | Where |
|------|--------|
| **Active Cursor rule** | **Settings → Rules → User** (you added this in the app) |
| Template on disk | `~/tech/AI/cursor/user-rules/git-commits.mdc` (edit here, re-sync to Settings when changed) |
| Git hooks | `~/tech/AI/cursor/git-hooks/install.sh` → `~/.githooks` |

No commit-rule files belong in `agent-projects`.
