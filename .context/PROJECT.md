# PROJECT.md — Project Context (Single Source of Truth)

> Read by: Claude (via CLAUDE.md), Copilot (via copilot-instructions.md), Codex (via AGENTS.md)
> Updated by: developer after meaningful changes to stack, conventions, or modules
> Keep under 150 lines. High signal only. Do NOT duplicate into entry-point files.

---

## Project

**Name:** _(replace with project name)_
**Description:** _(2-3 sentences: what the project does and who uses it)_
**Repository:** _(https://github.com/org/repo)_
**Environment:** _(production URL or N/A)_

---

## Stack

| Layer      | Technology                                        |
|------------|---------------------------------------------------|
| Backend    | _(e.g. Laravel 11 / NestJS / FastAPI)_            |
| Frontend   | _(e.g. Next.js 15 / React + Vite)_               |
| Database   | _(e.g. PostgreSQL 16, Redis 7)_                  |
| Auth       | _(e.g. Sanctum / JWT / Supabase)_                |
| Testing    | _(e.g. Pest PHP / Vitest / pytest)_              |
| CI/CD      | _(e.g. GitHub Actions)_                          |
| Hosting    | _(e.g. Vercel / Railway / EC2)_                  |

Stack-specific conventions → `.github/instructions/<stack>.instructions.md`

---

## Language & Communication

- Respond in the same language the user writes in.
- Default: **Vietnamese** — switch to English only if user writes in English.
- All code, variable names, comments, and commit messages: always **English**.

---

## Conventions

### Code Rules
- Commit format: `type(scope): subject` — `feat` | `fix` | `chore` | `docs` | `refactor` | `test` | `perf` | `ci`
- Branch naming: `<type>/<short-description>` — e.g. `feat/user-auth`, `fix/login-redirect`
- Max function length: ~40 lines — split if longer
- No hardcoded secrets — always environment variables
- No commented-out dead code in final commits
- Validate all external inputs at system boundaries
- DRY: extract repeated logic after the 2nd occurrence
- YAGNI: implement only what is explicitly requested
- Single Responsibility: one file/class does one thing
- All async operations must handle errors (try/catch or `.catch()`)

### Naming
| Construct  | Convention  | Example            |
|------------|-------------|---------------------|
| Files      | kebab-case  | `user-service.ts`  |
| Classes    | PascalCase  | `UserService`      |
| Functions  | camelCase   | `getUserById`      |
| Constants  | UPPER_SNAKE | `MAX_RETRY_COUNT`  |
| DB columns | snake_case  | `created_at`       |

### Security Defaults
- Never hardcode secrets, API keys, passwords
- Parameterized queries / ORM only — never raw string interpolation
- Validate user input at every system boundary
- Follow OWASP Top 10 mitigations by default
- Auth: token-based (JWT/session); never roll custom crypto
- Confirm before: `DROP`, `TRUNCATE`, bulk `DELETE`, `git push --force`, `rm -rf`

---

## Module Map

> Updated by AI after each implementation phase. Full file paths → `.context/FILE-INDEX.md`

| Module | Type | Description | Status |
|--------|------|-------------|--------|
| _(empty — populate after first implementation phase)_ | | | |

---

## Key Files

> Files that require extra care — read fully before editing

| File | Reason |
|------|--------|
| _(e.g. `src/core/pipeline.ts`)_ | _(e.g. core orchestration, affects all modules)_ |

---

## Known Constraints

> Architectural limits already decided — do not override without creating an ADR

_(e.g. "No Redux — use Zustand. See ADR-002.")_
_(e.g. "Monorepo with Turborepo. Do not add nx or other tools.")_

---

## Context Files Reference

| File                       | Purpose                                   | When to Read                   |
|----------------------------|-------------------------------------------|--------------------------------|
| `.context/ACTIVE.md`       | Current sprint — tasks, blockers          | Every session start            |
| `.context/HISTORY.md`      | Chronological change log                  | Complex tasks only             |
| `.context/DECISIONS.md`    | ADR index — architectural decisions       | Before proposing arch changes  |
| `.context/ERRORS.md`       | Known bugs and anti-patterns              | Before implementing fixes      |
| `.context/FILE-INDEX.md`   | Module → file map                         | Before locating files          |
| `.context/plans/`          | Implementation plans (PLAN-NNN, phase-N)  | When plan reference is given   |
