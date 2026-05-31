# agent-projects

Umbrella repository for AI projects, agents, and reusable workflow modules.

## Modules

| Module | Description |
|--------|-------------|
| [`agent-workflow/`](./agent-workflow/) | Semi-autonomous PM → Engineering → Review workflow (Cursor rules, GitHub issue/PR templates). See [IMPLEMENTATION.md](./agent-workflow/IMPLEMENTATION.md). |

## Bootstrap a project repo

```bash
MODULE=path/to/agent-projects/agent-workflow

mkdir -p .cursor/rules .github/ISSUE_TEMPLATE
cp -R "$MODULE/.cursor/rules/"* .cursor/rules/
cp "$MODULE/AGENTS.md" .
cp "$MODULE/.github/pull_request_template.md" .github/
cp "$MODULE/.github/ISSUE_TEMPLATE/pm-issue.md" .github/ISSUE_TEMPLATE/

# Edit .cursor/rules/project-context.mdc for this repo
```

Full checklist: [`agent-workflow/README.md`](./agent-workflow/README.md).

## Layout

```
agent-projects/
├── README.md
└── agent-workflow/
    ├── AGENTS.md
    ├── .cursor/rules/
    └── .github/
        ├── ISSUE_TEMPLATE/
        └── pull_request_template.md
```

## Global commit policy (your machine)

Not stored in this repo:

| | Path |
|--|------|
| Cursor User rule | `~/tech/AI/cursor/user-rules/git-commits.mdc` |
| Git hooks | `~/tech/AI/cursor/git-hooks/install.sh` → `~/.githooks` |
