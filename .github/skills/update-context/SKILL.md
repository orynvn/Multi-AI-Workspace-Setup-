---
name: update-context
description: "Update all context files (.context/) to reflect the current state of the project. Use at the end of a session or after completing a milestone."
---

# Update Context Prompt

> **Inputs** (`session`, `changes`): take them from the user's message / skill arguments. Ask once for any required value that is missing; use `YYYY-MM-DD` = today.

Sync `.context/` to reflect the actual state of the project.

## Information

**Session/milestone:** `<session>` _(Brief description of what this session did (e.g. Sprint 3 - Auth module))_
**Changes made:** `<changes>` _(What changed in this session)_

---

## Execution

### 1. Update HISTORY.md

Read the git log or list of changed files, append any missing entries:
```
[YYYY-MM-DD] <changes>
```

Format for each entry:
```
[YYYY-MM-DD] <type>: <description> — <file/module>
```
Types: `feat`, `fix`, `refactor`, `chore`, `test`, `docs`

### 2. Check DECISIONS.md

Review any decisions made this session:
- Any new architectural choices not yet logged?
- If yes → use the `/log-decision` skill for each one.

### 3. Check ERRORS.md

Review bugs/issues encountered this session:
- Append new errors in the format:
  ```
  [YYYY-MM-DD] ERROR: <description> | Root cause: <cause> | Fix: <solution> | File: <path>
  ```
- Update status of old errors that were fixed: `Fixed: YYYY-MM-DD`

### 4. Update FILE-INDEX.md

For each file created or modified this session:
- New file, new module → add row
- New file, existing module → append path to `Files` column
- File renamed/moved → update path
- File deleted → remove from row (remove row if `Files` becomes empty)

Use the `file-indexer` skill for detailed rules.

### 5. Verify context integrity

Check:
- [ ] Does `HISTORY.md` have an entry for today?
- [ ] Does `DECISIONS.md` include all major decisions?
- [ ] Are there any resolved errors in `ERRORS.md` that need a status update?
- [ ] Are test cases in sync with `.context/test-cases/`?

---

**Execute all steps — report a summary when done.**

---

Detailed conventions, formats and examples: [references/guide.md](references/guide.md) — read it before executing.
