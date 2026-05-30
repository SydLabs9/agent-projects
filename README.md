# agent-projects

Umbrella repository for AI projects, agents, workflows, and reusable agent configuration.

Each top-level folder is a self-contained module you copy into a target repo (or run standalone).

## Modules

| Module | Description |
|--------|-------------|
| [`agent-workflow/`](./agent-workflow/) | Semi-autonomous PM → Engineering → Review workflow (Cursor rules, GitHub Actions, Slack). See [IMPLEMENTATION.md](./agent-workflow/IMPLEMENTATION.md). |

## Bootstrap a project repo

```bash
MODULE=path/to/agent-projects/agent-workflow

mkdir -p .cursor/rules .github/workflows .github/ISSUE_TEMPLATE
cp -R "$MODULE/.cursor/rules/"* .cursor/rules/
cp "$MODULE/AGENTS.md" .
cp "$MODULE/.github/pull_request_template.md" .github/
cp "$MODULE/.github/ISSUE_TEMPLATE/pm-issue.md" .github/ISSUE_TEMPLATE/
cp "$MODULE/.github/workflows/"*.yml .github/workflows/

# Edit .cursor/rules/project-context.mdc for this repo
```

Full checklist: [`agent-workflow/README.md`](./agent-workflow/README.md).

## Layout (this repo)

```
agent-projects/
├── README.md                 ← you are here (umbrella)
└── agent-workflow/           ← canonical module (do not flatten to repo root)
    ├── AGENTS.md
    ├── README.md
    ├── IMPLEMENTATION.md
    ├── .cursor/rules/
    └── .github/
```

Workflow files under `agent-workflow/.github/workflows/` are **templates**. They run only after you copy them into a **project** repo — not on `agent-projects` itself unless you dogfood here.

## Dev environment setup

Global (all repos): `~/tech/AI/cursor/git-hooks/install.sh` + Cursor User rule from `~/tech/AI/cursor/user-rules/git-commits.mdc`.

This repo: **[SETUP.md](./SETUP.md)** · [docs/COMMIT_CONVENTIONS.md](./docs/COMMIT_CONVENTIONS.md)
