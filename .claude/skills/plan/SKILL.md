---
name: plan
description: Analyze a requirement and create a structured PLAN-NNN file in .context/plans/. Works in Claude Code and GitHub Copilot.
argument-hint: <requirement>
disable-model-invocation: true
---

Requirement: $ARGUMENTS

- **Claude Code:** use the `analyst` agent to analyze this requirement and create a structured plan.
- **Any other harness (GitHub Copilot, Codex…):** the `analyst` agent is not available here. Read `.claude/agents/analyst.md` (ignore its YAML frontmatter) and follow its intent-detection and plan-creation steps yourself for this requirement.
