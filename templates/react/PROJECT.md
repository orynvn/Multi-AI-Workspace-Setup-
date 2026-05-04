# PROJECT.md — React (Vite) Project

> Copy this file to `.context/PROJECT.md` in your project. Fill in the Project section.

---

## Project

**Name:** _(replace)_
**Description:** _(2-3 sentences)_
**Repository:** _(https://github.com/org/repo)_
**Environment:** _(production URL or N/A)_

---

## Stack

| Layer    | Technology                           |
|----------|--------------------------------------|
| Frontend | React 19, Vite, TypeScript (strict)  |
| Styling  | Tailwind CSS, shadcn/ui              |
| State    | Zustand (client), TanStack Query (server) |
| API      | _(backend URL / BFF)_                |
| Testing  | Vitest + Testing Library, Playwright |
| CI/CD    | GitHub Actions                       |
| Hosting  | _(e.g. Vercel / Netlify)_            |

Stack-specific conventions → `.github/instructions/react.instructions.md`

---

## Language & Communication

- Default: **Vietnamese** — switch to English only if user writes in English.
- All code, commits, and comments: **English**.

---

## Conventions

- Commit format: `type(scope): subject`
- Max function length: ~40 lines
- No `any` type — `unknown` + type narrowing
- No hardcoded secrets — `.env.local` (never committed)

### React Specific
- Components: functional only, no class components
- Custom hooks for reusable stateful logic — `src/hooks/use-<name>.ts`
- API calls centralized in `src/lib/api.ts` — no raw `fetch()` in components
- Zustand for client-only state, TanStack Query for server state
- Tailwind only — no inline styles, CSS modules, or styled-components

### File Structure
```
src/
  components/
    ui/           # shadcn/ui primitives
    features/     # Feature-specific composites
  hooks/          # use-<name>.ts
  lib/            # api.ts, utils, validations
  stores/         # Zustand stores
  types/          # TypeScript types
  pages/          # Route-level components
```

### Testing
- Unit: Vitest + `@testing-library/react`
- E2E: Playwright in `tests/e2e/`
- Mock external APIs with MSW
- Run: `npx vitest run` / `npx playwright test`

---

## Module Map

| Module | Type | Description | Status |
|--------|------|-------------|--------|
| _(empty)_ | | | |

---

## Key Files

| File | Reason |
|------|--------|
| `src/lib/api.ts` | All API calls — changes affect all data fetching |
| `src/stores/` | Zustand stores — global state |

---

## Known Constraints

- No Redux
- No `useEffect` for data fetching — use TanStack Query

---

## Context Files Reference

| File | When to Read |
|------|-------------|
| `.context/ACTIVE.md` | Every session start |
| `.context/DECISIONS.md` | Before proposing architecture changes |
| `.context/ERRORS.md` | Before implementing fixes |
| `.context/FILE-INDEX.md` | Before locating module files |
