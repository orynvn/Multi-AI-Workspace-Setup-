---
name: run-e2e-test
description: "Run E2E tests with Playwright. Supports headed/headless mode, specific test files, and automatically reports results in standard format."
---

# Run E2E Test Prompt

> **Inputs** (`testFile`, `mode`, `browser`): take them from the user's message / skill arguments. Ask once for any required value that is missing; use `YYYY-MM-DD` = today.

Run E2E tests with Playwright.

## Information

**Test file/suite:** `<testFile>` _(File or suite name (leave blank to run all))_
**Mode:** `<mode>` _(headless | headed | debug)_
**Browser:** `<browser>` _(chromium | firefox | webkit | all)_

---

## Execution

### 1. Check Playwright config

Read `playwright.config.ts` to understand:
- Base URL
- Test directory
- Browser targets
- Timeout settings

### 2. Run tests

```bash
# All tests (headless)
npx playwright test

# Specific file
npx playwright test <testFile>

# Headed mode (see browser)
npx playwright test --headed

# Debug mode (breakpoints)
npx playwright test --debug

# Specific browser
npx playwright test --project=<browser>

# With report
npx playwright test --reporter=html
```

### 3. Analyze results

Parse Playwright output:
- Pass / fail / flaky counts
- Screenshots and videos of failing tests (if any)
- Test duration and timeout warnings

### 4. Report

**All PASS:**
```markdown
## ✅ E2E Test Report

**Timestamp:** YYYY-MM-DD HH:MM
**Mode:** <mode> | **Browser:** <browser>
**Tests:** X pass | 0 fail | 0 flaky
**Duration:** Xs

### Test Suites
| Suite | Tests | Status |
|---|---|---|
| auth.spec.ts | 5 | ✅ All pass |
| checkout.spec.ts | 8 | ✅ All pass |

**Playwright Report:** `npx playwright show-report`
```

**With FAIL:**
```markdown
## ❌ E2E Test Report

**Timestamp:** YYYY-MM-DD HH:MM
**Tests:** X pass | Y fail | Z flaky

### Failing Tests

#### TC-E2E-001: <test name>
**File:** `tests/e2e/auth.spec.ts:42`
**Browser:** chromium
**Error:**
\`\`\`
TimeoutError: Locator.click: Timeout 30000ms exceeded
  Call log: waiting for getByRole('button', { name: 'Login' })
\`\`\`
**Screenshot:** `test-results/auth-login-chromium/screenshot.png`
**Root cause:** Login button not in DOM — slow API response.
**Suggested fix:** Increase selector timeout or add `waitForResponse` before click.

---
**Action required:** Fix Y failing tests + check flaky tests.
```

### 5. Flaky test handling

If flaky tests are detected (pass once, fail next):
```bash
# Re-run to confirm flakiness
npx playwright test --repeat-each=3
```
If still flaky → report and quarantine the test (tag `@flaky`).

---

**Start: Check config → run → report → show-report if there are failures.**

---

Detailed conventions, formats and examples: [references/guide.md](references/guide.md) — read it before executing.
