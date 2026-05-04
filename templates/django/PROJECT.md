# PROJECT.md — Django Project

> Copy this file to `.context/PROJECT.md` in your project. Fill in the Project section.

---

## Project

**Name:** _(replace)_
**Description:** _(2-3 sentences)_
**Repository:** _(https://github.com/org/repo)_
**Environment:** _(production URL or N/A)_

---

## Stack

| Layer    | Technology                   |
|----------|------------------------------|
| Backend  | Python 3.12, Django 5        |
| API      | Django REST Framework        |
| Database | PostgreSQL 16                |
| Auth     | SimpleJWT                    |
| Testing  | pytest-django                |
| Queue    | Celery + Redis               |
| CI/CD    | GitHub Actions               |
| Hosting  | _(e.g. Railway / EC2)_       |

Stack-specific conventions → `.github/instructions/django.instructions.md`

---

## Language & Communication

- Default: **Vietnamese** — switch to English only if user writes in English.
- All code, commits, and comments: **English**.

---

## Conventions

- Commit format: `type(scope): subject`
- Max function length: ~40 lines
- No hardcoded secrets — `.env` only
- Type hints on all function signatures

### Django Specific
- Business logic in `services.py` — never in views or models
- Validation via serializers — never `request.data` directly in views
- `select_related` / `prefetch_related` to prevent N+1
- All endpoints require auth unless `permission_classes = [AllowAny]` with comment
- Format: `ruff format` / Lint: `ruff check`

### File Structure (per app)
```
<app>/
  models.py       # DB models only
  serializers.py  # Validation + representation
  views.py        # ViewSets — thin
  services.py     # Business logic
  urls.py
  tests/
```

### Testing (pytest-django)
- `@pytest.mark.django_db` for DB tests
- Factory Boy for test data
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
| `config/settings.py` | Django settings — changes affect whole app |
| `config/urls.py` | Root URL config |

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
