# PROJECT.md — NestJS Project

> Copy this file to `.context/PROJECT.md` in your project. Fill in the Project section.

---

## Project

**Name:** _(replace)_
**Description:** _(2-3 sentences)_
**Repository:** _(https://github.com/org/repo)_
**Environment:** _(production URL or N/A)_

---

## Stack

| Layer    | Technology                      |
|----------|---------------------------------|
| Backend  | NestJS 10, Node.js 20, TypeScript |
| Database | PostgreSQL, TypeORM / Prisma    |
| Auth     | Passport.js + JWT               |
| Testing  | Jest + Supertest                |
| Queue    | Bull (Redis)                    |
| CI/CD    | GitHub Actions                  |
| Hosting  | _(e.g. Railway / EC2)_          |

Stack-specific conventions → `.github/instructions/nestjs.instructions.md`

---

## Language & Communication

- Default: **Vietnamese** — switch to English only if user writes in English.
- All code, commits, and comments: **English**.

---

## Conventions

- Commit format: `type(scope): subject`
- Max function length: ~40 lines
- No `any` type — TypeScript strict mode
- No hardcoded secrets — environment variables only

### NestJS Specific
- Module structure per feature: `src/<module>/<module>.module/controller/service.ts`
- Business logic in Services — Controllers only handle HTTP/serialization
- DTOs for all request/response shapes — `class-validator` decorators
- Every route: `@UseGuards(JwtAuthGuard)` unless explicitly `@Public()` with comment
- Transactions for multi-step DB writes
- Unit tests: Jest with mocked dependencies
- E2E tests: Supertest against real NestJS app

### File Structure (per module)
```
src/<module>/
  <module>.module.ts
  <module>.controller.ts
  <module>.service.ts
  dto/create-<module>.dto.ts
  entities/<module>.entity.ts
  <module>.service.spec.ts
```

---

## Module Map

| Module | Type | Description | Status |
|--------|------|-------------|--------|
| _(empty)_ | | | |

---

## Key Files

| File | Reason |
|------|--------|
| `src/app.module.ts` | Root module — all feature modules registered here |

---

## Known Constraints

_(none yet)_

---

## Context Files Reference

| File | When to Read |
|------|-------------|
| `.context/ACTIVE.md` | Every session start |
| `.context/DECISIONS.md` | Before proposing architecture changes |
| `.context/ERRORS.md` | Before implementing fixes |
| `.context/FILE-INDEX.md` | Before locating module files |
