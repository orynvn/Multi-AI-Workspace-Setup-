# PROJECT.md — Laravel Project

> Copy this file to `.context/PROJECT.md` in your project. Fill in the Project section.

---

## Project

**Name:** _(replace)_
**Description:** _(2-3 sentences)_
**Repository:** _(https://github.com/org/repo)_
**Environment:** _(production URL or N/A)_

---

## Stack

| Layer    | Technology                    |
|----------|-------------------------------|
| Backend  | PHP 8.3, Laravel 11           |
| Frontend | _(e.g. Inertia + React / API-only)_ |
| Database | MySQL 8 / PostgreSQL 16       |
| Auth     | Laravel Sanctum (API tokens)  |
| Testing  | Pest PHP                      |
| CI/CD    | GitHub Actions                |
| Hosting  | _(e.g. Forge / Railway / EC2)_ |

Stack-specific conventions → `.github/instructions/laravel.instructions.md`

---

## Language & Communication

- Default: **Vietnamese** — switch to English only if user writes in English.
- All code, commits, and comments: **English**.

---

## Conventions

- Commit format: `type(scope): subject`
- Max function length: ~40 lines
- No hardcoded secrets — `.env` only
- YAGNI: implement only what is explicitly requested

### Laravel Specific
- Controllers: thin — delegate all business logic to Services
- Services: `app/Services/<Resource>Service.php` — business logic only
- Validation: always via Form Requests — never `$request->validate()` in controllers
- API responses: always via API Resources — never raw `json()` with model data
- Transactions: `DB::transaction(fn() => ...)` for multi-step writes
- Queued jobs for any operation > 500ms
- No raw SQL — Eloquent or Query Builder with bindings only

### File Naming
- Controllers: `app/Http/Controllers/<Resource>Controller.php`
- Services: `app/Services/<Resource>Service.php`
- Requests: `app/Http/Requests/<Action><Resource>Request.php`
- Resources: `app/Http/Resources/<Resource>Resource.php`

### Testing (Pest PHP)
- `RefreshDatabase` — real DB, no mocks for DB layer
- Factory for test data: `User::factory()->create()`
- Test naming: `it('does X when Y')`
- Run: `php artisan test --parallel`

---

## Module Map

| Module | Type | Description | Status |
|--------|------|-------------|--------|
| _(empty)_ | | | |

---

## Key Files

| File | Reason |
|------|--------|
| `app/Providers/AppServiceProvider.php` | Service bindings — changes affect whole app |
| `routes/api.php` | All API routes — check for conflicts |

---

## Known Constraints

- No raw SQL — Eloquent/Query Builder only
- Never modify existing migrations — create new ones

---

## Context Files Reference

| File | When to Read |
|------|-------------|
| `.context/ACTIVE.md` | Every session start |
| `.context/DECISIONS.md` | Before proposing architecture changes |
| `.context/ERRORS.md` | Before implementing fixes |
| `.context/FILE-INDEX.md` | Before locating module files |
