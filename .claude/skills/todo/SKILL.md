---
name: todo
description: List pending tasks of a PLAN-NNN plan. Works in Claude Code and GitHub Copilot.
argument-hint: <PLAN-NNN>
disable-model-invocation: true
---

List pending tasks for: $ARGUMENTS

- **Claude Code:** use the `analyst` agent to list all pending tasks.
- **Any other harness (GitHub Copilot, Codex…):** the `analyst` agent is not available here. Read `.claude/agents/analyst.md` (ignore its YAML frontmatter) and follow its `list-tasks PLAN-NNN` section yourself.
