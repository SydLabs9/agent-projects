# Machine setup — agent-projects

Run once per Mac (or again after a clean install).

## 1. Global git hooks

```bash
~/tech/AI/cursor/git-hooks/install.sh
git config --global core.hooksPath   # expect: ~/.githooks
```

Optional: use **only** global hooks in this clone (recommended):

```bash
git config --unset core.hooksPath
```

## 2. Cursor user rule (all workspaces)

1. Open **Cursor → Settings → Rules → User**
2. Copy contents of `~/tech/AI/cursor/user-rules/git-commits.mdc`
3. Save (`alwaysApply: true`)

## 3. Verify

```bash
# Hooks active
test -x ~/.githooks/commit-msg && echo "hooks OK"

# Dry-run bad message (should fail)
printf 'fix: x\n\nCo-authored-by: Bot\n' > /tmp/msg && ~/.githooks/commit-msg /tmp/msg && echo FAIL || echo "reject OK"
```

## 4. When you change hook scripts

Edit `~/tech/AI/cursor/git-hooks/`, then re-run:

```bash
~/tech/AI/cursor/git-hooks/install.sh
```

## Reference

| What | Where |
|------|--------|
| Hook source | `~/tech/AI/cursor/git-hooks/` |
| Hook runtime | `~/.githooks/` |
| Agent policy template | `~/tech/AI/cursor/user-rules/git-commits.mdc` |
| Docs | [docs/COMMIT_CONVENTIONS.md](./docs/COMMIT_CONVENTIONS.md) |
| Agent workflow module | [agent-workflow/](./agent-workflow/) |
