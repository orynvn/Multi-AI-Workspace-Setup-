---
name: log-decision
description: "Record an architectural decision in .context/DECISIONS.md and create a decision detail file in .context/decisions/."
---

# Log Decision Prompt

> **Inputs** (`title`, `context`, `decision`, `alternatives`, `consequences`): take them from the user's message / skill arguments. Ask once for any required value that is missing; use `YYYY-MM-DD` = today.

Record an architectural decision as documentation for the project.

## Decision information

**Title:** `<title>` _(Short title (e.g. Use Zustand instead of Redux for state management))_
**Context:** `<context>` _(Why does this decision need to be made?)_
**Decision:** `<decision>` _(What is the final decision?)_
**Alternatives:** `<alternatives>` _(Alternatives considered)_
**Consequences:** `<consequences>` _(Consequences / trade-offs)_

---

## Execution

### 1. Read DECISIONS.md

Read `.context/DECISIONS.md` to get the next ADR sequence number.

### 2. Create decision file

Create file `.context/decisions/ADR-NNN-<slug>.md`:

```markdown
# ADR-NNN: <title>

**Date:** YYYY-MM-DD
**Status:** Accepted
**Deciders:** <team / decision makers>

## Context

<context>

## Decision

<decision>

## Alternatives Considered

<alternatives>

## Consequences

### Positive
- ...

### Negative / Trade-offs
- ...

## Related decisions
- ADR-XXX: <if any>
```

### 3. Update index

Append to `.context/DECISIONS.md`:
```markdown
| ADR-NNN | <title> | YYYY-MM-DD | Accepted |
```

### 4. Update HISTORY.md

Append to `.context/HISTORY.md`:
```
[YYYY-MM-DD] decision: ADR-NNN logged — <title>
```

---

**Execute immediately — no confirmation needed.**
