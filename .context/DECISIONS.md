# Architectural Decisions

> Index all architectural decisions for the project.
> Details for each ADR: see `.context/decisions/ADR-NNN-<slug>.md`

## Index

| ADR | Title | Date | Status |
|-----|-------|------|--------|
| ADR-001 | Claude + Codex share agent role files and hook scripts (`.claude/agents/*.md`, `.claude/hooks/*.sh`); `.codex/agents/*.toml` are thin pointers; models referenced by alias / not pinned | 2026-11-21 | Accepted |

## Statuses

- `Proposed` — under consideration
- `Accepted` — decided and currently applied
- `Deprecated` — no longer applicable (kept for reference)
- `Superseded by ADR-NNN` — replaced by a newer decision

## How to add an ADR

1. Use the `/log-decision` skill in Copilot.
2. Or manually: create `.context/decisions/ADR-NNN-<slug>.md` + update the table above.

## ADR Template

```markdown
# ADR-001: <Title>

**Date:** YYYY-MM-DD
**Status:** Accepted
**Deciders:** <name/team>

## Context
<Why does this decision need to be made?>

## Decision
<What is the decision?>

## Alternatives Considered
<Options considered and reasons for not choosing them>

## Consequences
### Positive
- ...
### Negative / Trade-offs
- ...
```
