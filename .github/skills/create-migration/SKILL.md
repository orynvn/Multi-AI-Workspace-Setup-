---
name: create-migration
description: "Create a migration file for Laravel. Auto-detects table name, columns, indexes, foreign keys and generates the migration + model fillable if needed."
---

# Create Migration Prompt (Laravel)

> **Inputs** (`type`, `table`, `description`): take them from the user's message / skill arguments. Ask once for any required value that is missing; use `YYYY-MM-DD` = today.

Create a new Laravel migration following the correct conventions.

## Migration information

**Type:** `<type>` _(create | add_column | remove_column | add_index | add_foreign_key)_
**Table name:** `<table>` _(Table name (snake_case, plural) — e.g. user_profiles)_
**Description:** `<description>` _(Short description — e.g. Add avatar_url column to users)_

---

## Execution

### 1. Confirm context

Read `.context/DECISIONS.md` to check for any special DB rules.

### 2. Create migration

**Naming convention:**
- Create table: `create_<table>_table`
- Add column: `add_<column>_to_<table>_table`
- Remove column: `remove_<column>_from_<table>_table`
- Add index: `add_index_to_<table>_<columns>`
- Add foreign key: `add_<fk>_foreign_to_<table>_table`

Run command:
```bash
php artisan make:migration <migration_name>
```

### 3. Migration content

Follow `database.instructions.md`:
- Always implement both `up()` and `down()`.
- Add indexes for all foreign key columns.
- Define `onDelete` behavior explicitly.
- Do not mix schema and data migration.

Template for CREATE TABLE:
```php
public function up(): void
{
    Schema::create('<table>', function (Blueprint $table) {
        $table->id();
        // columns here
        $table->timestamps();
    });
}

public function down(): void
{
    Schema::dropIfExists('<table>');
}
```

### 4. Update Model (if create table)

If this is a migration for a new table, create or update the Model:
```bash
php artisan make:model <ModelName>
```
Add a `$fillable` array to the Model.

### 5. Log

Append to `.context/HISTORY.md`:
```
[YYYY-MM-DD] migration: <description> — database/migrations/<filename>
```

---

**Start: Display migration to be created → wait for confirmation → create file.**
