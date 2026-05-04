# AGENTS.md

> Thin adapter — read by OpenAI Codex CLI at task start.
> Project context lives in `.context/PROJECT.md`. Do not duplicate it here.

---

## Context Loading

Read in this order before doing any work:

1. **`.context/ACTIVE.md`** — current sprint, blockers, recent changes _(always)_
2. **`.context/PROJECT.md`** — stack, conventions, module map, key constraints _(always)_

For specific tasks, also read on-demand:
- `.context/DECISIONS.md` — if the task involves architecture choices
- `.context/ERRORS.md` — if the task involves fixing bugs or known issues
- `.context/FILE-INDEX.md` — to locate existing module files without scanning
- `.context/plans/<name>.md` — if a specific plan is referenced

---

## Workflow

### New feature
1. Read ACTIVE.md and PROJECT.md
2. Create a plan: `.context/plans/PLAN-NNN-<slug>.md` with phased task breakdown
3. Wait for confirmation before implementing
4. Implement in dependency order — one logical change per commit

### Bug fix
1. Read `.context/ERRORS.md` first — check for known patterns
2. Reproduce → root cause analysis → fix plan
3. Confirm fix plan before implementing
4. After fixing: append to `.context/ERRORS.md`

### Quick edit (docs, config, rename, single file)
1. Read ACTIVE.md and PROJECT.md
2. Implement directly — no plan needed

---

## Behavior Rules

- Respond in the same language the user writes in (default: Vietnamese; code always English)
- Implement only what is explicitly requested — no extra features (YAGNI)
- Max function length: ~40 lines — split if longer
- No hardcoded secrets — environment variables only
- Confirm before: `DROP`, `TRUNCATE`, bulk `DELETE`, `git push --force`, `rm -rf`
- Never commit `.env` files or API keys
- Follow naming conventions and commit format from `.context/PROJECT.md`

---

## After Every Task

- Append to `.context/HISTORY.md`: `[YYYY-MM-DD] <type>: <desc> — <file>`
- Update `.context/ACTIVE.md` In Progress table (mark done or advance phase)
- Update `.context/FILE-INDEX.md` if files were created, renamed, or deleted
- Commit format: `type(scope): subject`

---

## Sub-directory AGENTS.md

Place additional `AGENTS.md` files in subdirectories for module-specific context:

```
src/auth/AGENTS.md      # auth-specific rules, known pitfalls
src/payment/AGENTS.md   # payment integration constraints
```

These are loaded in addition to this root file when Codex works inside those directories.
