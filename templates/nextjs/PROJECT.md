# PROJECT.md — Next.js Project

> Copy this file to `.context/PROJECT.md` in your project.
> Fill in the Project section. Everything else is pre-configured for Next.js.

---

## Project

**Name:** _(replace)_
**Description:** _(2-3 sentences)_
**Repository:** _(https://github.com/org/repo)_
**Environment:** _(production URL or N/A)_

---

## Stack

| Layer    | Technology                          |
|----------|-------------------------------------|
| Backend  | Next.js 15 (App Router, Server Actions) |
| Frontend | React 19, Tailwind CSS, shadcn/ui   |
| Database | PostgreSQL, Prisma 5.x              |
| Auth     | NextAuth.js v5 / Supabase Auth      |
| Testing  | Vitest + Testing Library, Playwright |
| CI/CD    | GitHub Actions                      |
| Hosting  | Vercel                              |

Stack-specific conventions → `.github/instructions/nextjs.instructions.md`

---

## Language & Communication

- Default: **Vietnamese** — switch to English only if user writes in English.
- All code, commits, and comments: **English**.

---

## Conventions

### Code Rules
- Commit format: `type(scope): subject`
- Max function length: ~40 lines
- No hardcoded secrets — environment variables only
- YAGNI: implement only what is explicitly requested

### Next.js Specific
- Server Components by default — `"use client"` only for hooks/events/browser APIs
- Server Actions for mutations — no API routes for internal frontend calls
- Route handlers (`route.ts`) only for external consumers (webhooks, mobile)
- No `any` type — use `unknown` + type narrowing
- `next/image` for all images, `next/font` for fonts
- Tailwind only — no inline styles, CSS modules, or styled-components

### File Structure
- Pages: `app/<route>/page.tsx`
- Components: `src/components/<Feature>/<Name>.tsx`
- Server Actions: `src/actions/<feature>.ts`
- DB functions: `src/lib/<domain>.ts`
- Types: `src/types/<domain>.ts`

### Security
- All Server Actions validated with Zod before persisting
- `NEXT_PUBLIC_` prefix only for intentionally public values
- Prisma Client singleton in `src/lib/db.ts`

---

## Module Map

| Module | Type | Description | Status |
|--------|------|-------------|--------|
| _(empty)_ | | | |

---

## Key Files

| File | Reason |
|------|--------|
| `src/lib/db.ts` | Prisma client singleton — do not create multiple instances |
| `src/lib/auth.ts` | NextAuth config — changes affect all protected routes |

---

## Known Constraints

- No Redux — use Zustand for client state, React Query for server state
- No `useEffect` for data fetching — use Server Components or React Query
- No raw `fetch()` in components — centralize in `src/lib/api.ts`

---

## Context Files Reference

| File | When to Read |
|------|-------------|
| `.context/ACTIVE.md` | Every session start |
| `.context/DECISIONS.md` | Before proposing architecture changes |
| `.context/ERRORS.md` | Before implementing fixes |
| `.context/FILE-INDEX.md` | Before locating module files |
