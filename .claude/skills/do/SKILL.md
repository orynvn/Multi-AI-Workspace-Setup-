---
name: do
description: Run task N of a PLAN-NNN plan (e.g. "/do 3 PLAN-001"). Works in Claude Code and GitHub Copilot.
argument-hint: <task-number> <PLAN-NNN>
disable-model-invocation: true
---

Run task: $ARGUMENTS

- **Claude Code:** use the `analyst` agent to run this task.
- **Any other harness (GitHub Copilot, Codex…):** the `analyst` agent is not available here. Read `.claude/agents/analyst.md` (ignore its YAML frontmatter) and follow its `run-task N PLAN-NNN` section yourself.
