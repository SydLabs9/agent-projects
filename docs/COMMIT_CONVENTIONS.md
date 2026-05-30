# Commit and push conventions

Human + agent policy. Full spec (types, scopes, examples):  
`~/tech/AI/cursor/user-rules/git-commits.mdc` → paste into **Cursor → Settings → Rules → User**.

## Global setup (all projects on this machine)

```bash
~/tech/AI/cursor/git-hooks/install.sh
```

This copies `~/tech/AI/cursor/git-hooks/` → `~/.githooks/` and sets:

```bash
git config --global core.hooksPath ~/.githooks
```

Checklist: [SETUP.md](../SETUP.md).

## Per-repo override (rare)

```bash
./scripts/install-git-hooks.sh
```

Sets `core.hooksPath` to this repo’s `.githooks/` only — overrides global for this clone. Prefer global unless you need different rules in one repo.

Unset repo override: `git config --unset core.hooksPath`

## Rules (enforced by hooks)

| Rule | Detail |
|------|--------|
| **Subject** | `type: summary` or `type(scope): summary` — lowercase type, imperative summary |
| **Length** | Subject ≤ 72 characters |
| **Body** | Optional plain prose (wrap ~72 chars by convention; not validated by hooks) |
| **No trailers** | No `Co-authored-by`, `Signed-off-by`, `Made-with`, `Fixes`, `Closes`, etc. on body lines |
| **No tool refs** | No `cursor`, `composer`, or `made-with` (any casing) |
| **Issue linkage** | Use `Closes #N` in the PR, not trailer lines in the commit |

### Types

| Type | When to use |
|------|-------------|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `refactor` | Restructure without behavior change |
| `chore` | Tooling, deps, config, scripts |
| `docs` | Documentation only |
| `test` | Tests only |
| `ci` | CI/CD pipelines |
| `build` | Build system / dependencies |

### Good

```
feat(appointments): add reschedule endpoint

Validate slot availability before persisting the new time.
```

```
fix: correct null check in payment mapper
```

### Bad

```
fix: something

Co-authored-by: Cursor <cursor@cursor.com>
Made-with: Cursor
Closes #42
```

## What the hooks do

| Hook | Behavior |
|------|----------|
| `prepare-commit-msg` | Strips trailers and banned footer lines before commit finalizes |
| `commit-msg` | Rejects invalid messages |
| `pre-push` | Rejects push if any outgoing commit violates rules |

## Bypass (emergency only)

```bash
git commit --no-verify
git push --no-verify
```

## Refresh after editing hooks

```bash
~/tech/AI/cursor/git-hooks/install.sh
```
