---
name: ship
description: Pre-ship checks on the current branch — code review plus OWASP security audit.
disable-model-invocation: true
---

Run pre-ship checks on the current branch changes:

1. Use the reviewer agent to review all changes since the base branch.
2. Use the security agent to audit the changed files for OWASP Top 10 issues.

Run both agents in parallel. Report both results combined. If any 🔴 blocking issues exist, list them and stop — do NOT proceed until they are resolved.
