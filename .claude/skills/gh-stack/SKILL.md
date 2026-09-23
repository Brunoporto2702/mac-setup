---
name: gh-stack
description: Works with GitHub's native stacked pull requests via the `gh stack` extension. Use when the user mentions a "stack", "stacked PRs", "empilhar PRs", "PR em cima do outro", "quebra isso em PRs menores", "restack", "rebase a stack", or when a change is large enough that it should ship as a chain of dependent PRs.
allowed-tools: Bash(gh *), Bash(git *)
---

GitHub shipped native stacked pull requests — private preview 2026-04-13, public preview 2026-07-30. This is newer than most training data: **do not fall back on Graphite (`gt`), git-spice, ghstack, or hand-managed base branches.** Use `gh stack`.

## 0. Prerequisite

```sh
gh extension list | grep -q gh-stack || gh extension install github/gh-stack
```

Requires `gh` >= 2.0. If the install fails, stop and report — don't improvise a manual stack.

## Mental model

A stack is a chain of branches. The bottom branch targets the **trunk** (usually `main`); every branch above targets the branch directly below it. Each branch gets its own PR, and GitHub renders the stack map inside the PR UI — reviewers need no extension or extra account.

Rules that follow from this:

- A change can only depend on code in its own branch or a branch **below** it. If you catch yourself wanting to reach upward, the stack order is wrong — use `gh stack modify`.
- All branches must live in the **same repository**. Cross-fork stacks are not supported.
- Branch protection and required checks apply to every layer equally.
- Not available in GitHub Desktop (CLI, github.com, mobile, API only).

## Safety rules

These matter more than speed:

1. **Never** run bare `git rebase`, `git push --force`, or retarget a PR base by hand on a branch that belongs to a stack. It desyncs local tracking from GitHub's stack. Use `gh stack rebase` / `gh stack push` / `gh stack submit`.
2. Run `gh stack view` **before and after** any operation that rewrites history (`rebase`, `modify`, `sync`, `merge`). Show the user the before/after.
3. On a conflict, **stop**. Report which branch conflicted and in which files, and ask the user how to resolve. Do not guess a resolution and `--continue` through a stack — a bad mid-stack resolution silently propagates upward through every branch above it.
4. `gh stack merge` can merge several PRs in one shot. Always show the exact list of PRs it will merge and confirm before running it, and never pass `-y` unless the user explicitly approved that list.

## Commands

### Create and grow

| Command | Does |
|---|---|
| `gh stack init [branches...] [-b <branch>]` | Start a stack. Multiple branch names build a multi-layer stack in one shot (bottom → top); existing branches are adopted, missing ones created. `-b` sets the trunk (defaults to the repo default branch) |
| `gh stack add [branch] [-A] [-u] [-m <msg>]` | Add a new branch on top of the stack. `-A` stages everything incl. untracked, `-u` stages tracked files only, `-m` is the commit message. With `-m` and no branch name, the branch name is generated from the message; with `-A`/`-u` and no `-m`, your editor opens |
| `gh stack view [-s] [--json]` | Show the stack. `--json` when you need to parse it |
| `gh stack checkout <stack-number \| pr-number \| pr-url \| branch>` | Check out an existing stack |

### Remote

| Command | Does |
|---|---|
| `gh stack submit [--auto] [--open] [--remote <n>]` | Push all branches, then create/update the PRs and the stack on GitHub. This is the main "ship it" command |
| `gh stack push [--remote <n>]` | Push active branches only, no PR creation |
| `gh stack sync [--remote <n>] [--prune]` | Fetch + rebase + push + sync PR state in one go. `--prune` cleans up branches whose PRs merged |
| `gh stack rebase [branch] [--downstack] [--upstack] [--no-trunk] [--continue] [--abort] [--remote <n>]` | Cascading rebase across the stack |
| `gh stack link <stack-number \| branch-or-pr> <branch-or-pr> [...] [--base <branch>]` | Link PRs that already exist into a stack on GitHub, without local tracking |
| `gh stack merge [<stack-number> \| <pr-number>] [--squash \| --merge \| --rebase] [-y]` | Merge one or more stacked PRs at once |

### Restructure and tear down

| Command | Does |
|---|---|
| `gh stack modify [--continue] [--abort]` | Interactively reorder/restructure the stack |
| `gh stack unstack [<stack-number>] [--local]` | Remove the stack. `--local` drops local tracking only |

### Navigate

`gh stack switch` (interactive) · `gh stack up [n]` · `gh stack down [n]` · `gh stack top` · `gh stack bottom` · `gh stack trunk`

`gh stack up` moves away from the trunk, `down` moves toward it.

## Flows

### Break current work into a stack

1. `gh stack init` (confirm the trunk with the user if the repo's default branch isn't obvious). If you already know all the slices, `gh stack init <bottom> <mid> <top>` creates the whole shape at once. Existing branches can be adopted the same way.
2. For each logical slice, bottom-up: make the changes, then `gh stack add -Am "<imperative message>" <branch-name>`.
   Order matters — a slice must not depend on anything above it. Propose the slicing to the user before creating branches.
3. `gh stack view` to show the shape.
4. `gh stack submit --open` once the user approves.

### Add one more PR on top

`gh stack top` → make changes → `gh stack add -Am "..." <branch-name>` → `gh stack submit`.

### Address review feedback on a middle PR

1. `gh stack checkout <pr-number>` to land on the right branch.
2. Make the fix and commit it on that branch with plain `git commit` — `gh stack add` always creates a *new* branch on top, which is not what you want mid-stack.
3. `gh stack rebase --upstack` — propagates the change to every branch above.
4. `gh stack submit` to update all affected PRs.

Do not touch the branches above by hand; the cascading rebase is the whole point.

### After a PR in the stack merges

`gh stack sync --prune`. GitHub auto-retargets the remaining PRs; `sync` brings local tracking in line and drops merged branches. Then `gh stack view` to confirm.

### Merging

- Merging the **top** PR merges the whole stack.
- Merging **bottom-up** one at a time also works; PRs above retarget automatically.
- Merging a **mid-stack** PR works too — the ones above retarget to its base.
- Resulting history is identical either way.

Pick the merge method deliberately: `--squash` gives one commit per PR (usually what you want for a stack), `--rebase` preserves each branch's commits.

### Conflict during a restack

Report the conflicting branch and files, then offer the user two paths:
- resolve the files, `git add` them, `gh stack rebase --continue`
- `gh stack rebase --abort` to return to the pre-rebase state

Never pick for them.

## Errors

If any `gh stack` command fails, stop and explain what happened and what state the stack is in (`gh stack view`). Don't retry silently and don't fall back to raw git.
