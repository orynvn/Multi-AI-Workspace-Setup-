# PROJECT.md — FastAPI Project

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
| Backend  | Python 3.12, FastAPI            |
| Database | PostgreSQL 16, SQLAlchemy async |
| Auth     | JWT (python-jose)               |
| Testing  | pytest + pytest-asyncio         |
| Queue    | Celery / ARQ + Redis            |
| CI/CD    | GitHub Actions                  |
| Hosting  | _(e.g. Railway / EC2)_          |

Stack-specific conventions → `.github/instructions/fastapi.instructions.md`

---

## Language & Communication

- Default: **Vietnamese** — switch to English only if user writes in English.
- All code, commits, and comments: **English**.

---

## Conventions

- Commit format: `type(scope): subject`
- Max function length: ~40 lines
- No hardcoded secrets — `.env` + `pydantic-settings`
- Type hints on all function signatures (no `Any`)

### FastAPI Specific
- Pydantic models for all request/response shapes
- Business logic in service layer — routers are thin
- Dependency injection for DB sessions and auth
- All endpoints are async — use `asyncio`-compatible libs
- Format: `ruff format` / Lint: `ruff check`

### File Structure
```
app/
  routers/<domain>.py   # Thin route handlers
  services/<domain>.py  # Business logic
  models/<domain>.py    # SQLAlchemy models
  schemas/<domain>.py   # Pydantic schemas
  core/
    config.py           # pydantic-settings
    database.py         # async engine + session
    security.py         # JWT utils
```

### Testing
- `@pytest.mark.asyncio` for async tests
- `httpx.AsyncClient` for endpoint tests
- Factory / fixtures for test data
- Run: `pytest -v`

---

## Module Map

| Module | Type | Description | Status |
|--------|------|-------------|--------|
| _(empty)_ | | | |

---

## Key Files

| File | Reason |
|------|--------|
| `app/core/database.py` | Async DB session — changes affect all DB operations |
| `app/core/config.py` | App settings — loaded at startup |

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
