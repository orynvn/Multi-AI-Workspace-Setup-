---
name: ship
description: Pre-ship checks on the current branch — code review plus OWASP security audit. Works in Claude Code and GitHub Copilot.
disable-model-invocation: true
---

Run pre-ship checks on the current branch changes (since the base branch), using both agents in parallel:

| Check | Claude Code agent | GitHub Copilot agent |
|-------|-------------------|----------------------|
| Code review (logic, conventions) | `reviewer` | `code-reviewer` |
| OWASP Top 10 security audit of changed files | `security` | `security-auditor` |

If neither set of agents is available, perform both checks yourself.

Report both results combined. If any 🔴 blocking issues exist, list them and stop — do NOT proceed until they are resolved.
