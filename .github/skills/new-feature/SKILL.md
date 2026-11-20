---
name: new-feature
description: "Create a complete new feature following the Plan → Implement → Test → Commit → Log pipeline. Use when implementing a feature from scratch, including test cases and a standardized commit."
---

# New Feature Prompt

> **Inputs** (`featureName`, `description`, `module`): take them from the user's message / skill arguments. Ask once for any required value that is missing; use `YYYY-MM-DD` = today.

I need to implement a new feature. Run the full pipeline:

## Feature information

**Feature name:** `<featureName>` _(Feature name (e.g. User Authentication))_
**Description:** `<description>` _(Short description of the functionality to implement)_
**Module:** `<module>` _(Related module (e.g. AUTH, USER, PRODUCT))_

---

## Execution pipeline

### Step 1 — PLAN

1. Read `.context/HISTORY.md`, `.context/DECISIONS.md`, `.context/ERRORS.md`.
2. Identify the tech stack from project files.
3. Load the matching instructions from `.github/instructions/`.
4. Create a full task breakdown:
   - List of files to create/modify (in dependency order)
   - Edge cases & risks
   - Definition of Done
5. Display the plan → **wait for user confirmation** before continuing.

### Step 2 — IMPLEMENT

After user confirmation:
1. Implement each task in order.
2. Follow stack conventions (`laravel.instructions.md`, `nextjs.instructions.md`, ...).
3. Do not add scope outside the plan.
4. Security checklist before marking done:
   - [ ] No hardcoded secrets
   - [ ] Input validated
   - [ ] Authorization checked

### Step 3 — TEST

1. Write test cases for the entire feature (use the `/write-test-cases` skill).
2. Run tests.
3. Report results.
4. If failing → fix → rerun.

### Step 4 — COMMIT

After all tests pass, commit:

1. Use the `/commit-task` skill to create a Conventional Commits message.
2. Verify no sensitive files are in staged changes.
3. Commit with message: `feat(<scope>): <subject>`
4. **Do not push** — user decides.

### Step 5 — LOG

1. Append to `.context/HISTORY.md`:
   ```
   [YYYY-MM-DD] feat: <featureName> — <files affected>
   ```
2. If an architectural decision was made → use the `/log-decision` skill.

---

Start with **Step 1 — PLAN**.
