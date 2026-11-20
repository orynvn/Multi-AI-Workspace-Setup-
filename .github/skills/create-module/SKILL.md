---
name: create-module
description: "Create a complete module following the current stack’s architecture. Includes: Controller/Component, Service, Repository/Store, Types, Tests."
---

# Create Module Prompt

> **Inputs** (`moduleName`, `description`, `operations`): take them from the user's message / skill arguments. Ask once for any required value that is missing; use `YYYY-MM-DD` = today.

Create a complete new module for the current stack.

## Module information

**Module name:** `<moduleName>` _(Module name (PascalCase) — e.g. Product, Order, Invoice)_
**Description:** `<description>` _(What does this module do?)_
**CRUD operations:** `<operations>` _(Operations needed (e.g. list, show, create, update, delete))_

---

## Execution

### 1. Stack Detection & Planning

Identify stack:
- `composer.json` + `artisan` → **Laravel module**
- `package.json` dep `"next"` → **Next.js module**
- `package.json` dep `"vite"` + `"react"` → **React module**
- `package.json` dep `"vue"` → **Vue 3 module**

Display files to create per stack → **wait for confirmation**.

### 2. Laravel Module Structure

```
app/
├── Http/
│   ├── Controllers/<moduleName>Controller.php
│   ├── Requests/<moduleName>/Store<moduleName>Request.php
│   ├── Requests/<moduleName>/Update<moduleName>Request.php
│   └── Resources/<moduleName>Resource.php
├── Models/<moduleName>.php
├── Services/<moduleName>Service.php
└── Repositories/<moduleName>Repository.php
tests/
└── Feature/<moduleName>ControllerTest.php
```

### 3. Next.js Module Structure

```
app/<moduleName-lowercase>/
├── page.tsx              # List view (Server Component)
├── [id]/
│   └── page.tsx          # Detail view
├── _components/          # Module-private components
├── actions.ts            # Server Actions
└── loading.tsx
lib/<moduleName-lowercase>/
└── api.ts                # Data access functions
types/
└── <moduleName-lowercase>.ts
```

### 4. React Module Structure

```
src/
├── features/<moduleName-lowercase>/
│   ├── components/
│   ├── hooks/use<moduleName>.ts
│   ├── services/<moduleName-lowercase>-service.ts
│   └── types.ts
└── store/<moduleName-lowercase>Store.ts
```

### 5. Vue 3 Module Structure

```
src/
├── views/<moduleName>View.vue
├── components/<moduleName>/
├── composables/use<moduleName>.ts
├── stores/<moduleName-lowercase>Store.ts
└── services/<moduleName-lowercase>Service.ts
```

### 6. Write Tests

After creating the module, use the `/write-test-cases` skill for this module.

### 7. Log

Append to `.context/HISTORY.md`:
```
[YYYY-MM-DD] feat: <moduleName> module created — <list of files>
```

---

**Start with Stack Detection → display plan → wait for confirmation.**
