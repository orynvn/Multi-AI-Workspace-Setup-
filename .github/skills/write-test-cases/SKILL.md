---
name: write-test-cases
description: "Write comprehensive test cases for a module or feature. Output: actual test file + spec document in .context/test-cases/."
---

# Write Test Cases Prompt

> **Inputs** (`module`, `target`, `testType`): take them from the user's message / skill arguments. Ask once for any required value that is missing; use `YYYY-MM-DD` = today.

Write comprehensive test cases for the specified module/feature.

## Information

**Module:** `<module>` _(Module name (e.g. AUTH, USER, PRODUCT))_
**Feature/File to test:** `<target>` _(File or feature to write tests for (e.g. UserController, useAuth hook))_
**Test type:** `<testType>` _(unit | integration | e2e | all)_

---

## Execution

### 1. Read the code to test

Read the target file to understand:
- All public methods / endpoints / exported functions
- Input types and validation rules
- Possible return values and error states
- Business logic paths (if/else, guard clauses)

### 2. Identify test cases

For each function/endpoint, identify:

| Category | Description |
|---|---|
| Happy path | Valid input, output matches expectation |
| Edge case | Boundary values (empty, null, max, min) |
| Error case | Invalid input, not found, forbidden |
| Security case | Unauthorized, unauthenticated, injection attempt |

### 3. Assign Test IDs

Format: `TC-<module>-NNN`

Check `.context/test-cases/` to find the next sequential number.

### 4. Write test file

**Laravel (Pest PHP):**
```php
it('TC-<module>-001: returns 200 with valid payload', function () {
    // Arrange
    $user = User::factory()->create();

    // Act
    $response = $this->actingAs($user)
                     ->postJson('/api/v1/...', [...]);

    // Assert
    $response->assertStatus(200)
             ->assertJsonStructure(['success', 'data']);
});
```

**React/Next.js/Vue (Vitest + Testing Library):**
```ts
describe('TC-<module>', () => {
  it('TC-<module>-001: renders correctly with valid props', () => {
    // Arrange
    const props = { ... }

    // Act
    render(<Component {...props} />)

    // Assert
    expect(screen.getByRole('heading')).toHaveTextContent('...')
  })
})
```

**Playwright E2E:**
```ts
test('TC-E2E-001: user can complete flow', async ({ page }) => {
  await page.goto('/')
  await page.getByRole('button', { name: 'Submit' }).click()
  await expect(page.getByText('Success')).toBeVisible()
})
```

### 5. Save spec document

Create file `.context/test-cases/TC-<module>-spec.md`:
```markdown
# Test Cases: <module>

## TC-<module>-001: <description>
**Type:** unit | integration | e2e
**Priority:** P0 | P1 | P2
**Arrange:** <setup>
**Act:** <action>
**Assert:** <expected outcome>
**Status:** ✅ Pass | ❌ Fail | ⏭️ Skip
```

### 6. Run tests

After writing, use the `/run-api-test` or `/run-e2e-test` skill.

---

**Start: Read target file → list test cases → write → save spec.**

---

Detailed conventions, formats and examples: [references/guide.md](references/guide.md) — read it before executing.
