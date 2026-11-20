# Multi-AI Workspace Setup

> A unified context system for **GitHub Copilot + Claude Code + OpenAI Codex** in the same project.
> Update project context in one place → every AI picks it up.

---

## Problem

Each AI tool has its own entry file (`CLAUDE.md`, `.github/copilot-instructions.md`, `AGENTS.md`). Whenever the stack, conventions, or modules change, you have to edit two or three files and keep them in sync.

**Solution:** a single source of truth in `.context/PROJECT.md`. Each AI gets a thin adapter that points to it.

```
CLAUDE.md                        ─┐   (@imports .context/ files)
AGENTS.md                         ├──→ .context/PROJECT.md + .context/ACTIVE.md
.github/copilot-instructions.md  ─┘         ↑
                                     one file, one update
```

---

## Installation (5 minutes)

### 1. Copy into your project

```bash
# Clone this repo
git clone https://github.com/orynvn/Multi-AI-Workspace-Setup-.git multi-ai-setup

# Copy into your project
SRC=multi-ai-setup
cp -r $SRC/.context $SRC/.github $SRC/.claude $SRC/.codex $SRC/.vscode your-project/
cp $SRC/.mcp.json $SRC/CLAUDE.md $SRC/AGENTS.md your-project/
```

### 2. Pick a stack template

```bash
# Example: Next.js
cp multi-ai-setup/templates/nextjs/PROJECT.md your-project/.context/PROJECT.md

# Available stacks: nextjs | laravel | nestjs | django | fastapi | react
```

### 3. Fill in project info

Only two files need editing:

**`.context/PROJECT.md`** — fill in the header:
```markdown
**Name:** My App
**Description:** ...
**Repository:** https://github.com/org/repo
```

**`.context/ACTIVE.md`** — fill in the current sprint:
```markdown
**Name:** Sprint 1 — Initial Setup
**Branch:** feat/initial-setup
**Started:** 2026-05-05
```

**Done.** `CLAUDE.md`, `AGENTS.md`, and `.github/copilot-instructions.md` need no changes.

### 4. One-time tool setup

- **Claude Code:** approve the project MCP servers from `.mcp.json` when prompted.
- **Codex:** trust the project (Codex asks on first open, or add `[projects."<path>"] trust_level = "trusted"` to `~/.codex/config.toml`) — otherwise everything in `.codex/` is ignored. Then run `/hooks` inside Codex to review and approve the hooks.
- **GitHub token** (for the GitHub MCP server): `export GITHUB_TOKEN=ghp_your_token`

---

## How It Works

### Who reads what

| File | Claude | Copilot | Codex | When |
|------|--------|---------|-------|------|
| `.context/ACTIVE.md` | ✓ (auto-imported) | ✓ | ✓ | Every session |
| `.context/PROJECT.md` | ✓ (auto-imported) | ✓ | ✓ | Every session |
| `.context/DECISIONS.md` | on-demand | on-demand | on-demand | Architecture decisions |
| `.context/ERRORS.md` | on-demand | on-demand | on-demand | Bug fixing |
| `.context/FILE-INDEX.md` | on-demand | on-demand | on-demand | Locating files |

Claude Code loads `ACTIVE.md` and `PROJECT.md` automatically via `@` imports in `CLAUDE.md`. Copilot and Codex have no import syntax, so their adapters instruct the agent to read them.

### One-update rule

```
Add a new module → edit .context/PROJECT.md (Module Map)
                 → every AI knows about it in the next session
                 → no changes to CLAUDE.md, AGENTS.md, copilot-instructions.md
```

### Shared, not duplicated

| Shared asset | Used by |
|--------------|---------|
| `.claude/agents/*.md` (role definitions) | Claude Code directly; Codex via thin `.codex/agents/*.toml` pointers |
| `.claude/hooks/*.sh` (destructive-command guard, history reminder) | Claude Code (`.claude/settings.json`) and Codex (`.codex/hooks.json`) |
| `.claude/skills/` (`/plan`, `/do`, `/todo`, `/ship`) | Claude Code; also discovered by Copilot — the skills fall back to Copilot agents / `analyst.md` there |
| MCP servers | Same four servers in `.mcp.json` (Claude), `.codex/config.toml` (Codex), `.vscode/mcp.json` (Copilot) |

---

## File Structure

```
project-root/
├── CLAUDE.md                          # Thin adapter for Claude Code
├── AGENTS.md                          # Thin adapter for OpenAI Codex
├── .mcp.json                          # MCP servers for Claude Code
│
├── .context/                          # Shared brain — read by every AI
│   ├── PROJECT.md                     # ★ Single source of truth
│   ├── ACTIVE.md                      # Current sprint (updated daily)
│   ├── HISTORY.md                     # Changelog (auto-rotates to history/YYYY.md)
│   ├── DECISIONS.md                   # ADR index
│   ├── ERRORS.md                      # Bug log & anti-patterns
│   ├── FILE-INDEX.md                  # Module → file map
│   ├── log.sh                         # Appends to HISTORY.md + syncs ACTIVE.md
│   ├── decisions/                     # Individual ADR files
│   ├── plans/                         # PLAN-NNN, phase-N files
│   └── test-cases/                    # TC specs (TC-TEMPLATE.md)
│
├── .github/
│   ├── copilot-instructions.md        # Thin adapter for Copilot
│   ├── agents/                        # 11 Copilot agents
│   ├── instructions/                  # Stack-specific rules (laravel, nextjs, ...)
│   ├── hooks/                         # Copilot hooks (qa-workflow.json + scripts/)
│   └── skills/                        # 11 Copilot skills: /commit-task, /new-feature, /run-api-test, ...
│
├── .claude/
│   ├── settings.json                  # Hooks + permissions (deny reading .env, ask before git push)
│   ├── agents/                        # 12 agents (role files shared with Codex)
│   ├── skills/                        # /plan, /do, /todo, /ship
│   └── hooks/                         # pre-bash, post-edit, session-stop (shared with Codex)
│
├── .codex/
│   ├── config.toml                    # Sandbox, approval policy, MCP servers
│   ├── hooks.json                     # PreToolUse guard + Stop reminder
│   ├── rules/default.rules            # Exec policy (recursive delete, force push, ...)
│   └── agents/*.toml                  # 12 custom agents → point to .claude/agents/*.md
│
├── .vscode/
│   ├── settings.json                  # Copilot settings (hides duplicate .claude/agents)
│   ├── mcp.json                       # MCP: context7, github, playwright, error-learning
│   └── extensions.json
│
└── templates/                         # Stack-specific PROJECT.md templates
    ├── nextjs/PROJECT.md
    ├── laravel/PROJECT.md
    ├── nestjs/PROJECT.md
    ├── django/PROJECT.md
    ├── fastapi/PROJECT.md
    └── react/PROJECT.md
```

---

## Context Workflow

### After each task

```bash
# Using the script (recommended)
bash .context/log.sh "feat(auth): implement JWT refresh — src/auth/"

# Or manually — append to .context/HISTORY.md
[2026-05-05] feat: JWT refresh — src/auth/service.ts
```

`log.sh` also syncs the Recent Context section in `.context/ACTIVE.md`; afterwards just mark the task done in the In Progress table.
The Stop hook (Claude Code + Codex) reminds the agent if files changed but `HISTORY.md` has no entry for today.

### Starting a new sprint

```markdown
# Reset the header of .context/ACTIVE.md
**Name:** Sprint 2 — User Profile
**Branch:** feat/user-profile
**Started:** 2026-05-10
```

### Adding a module

```markdown
# Edit the Module Map in .context/PROJECT.md:
| auth    | feature | Auth, JWT refresh, token revocation | complete |
| profile | feature | User profile CRUD                   | in-progress |
```

---

## AI Agents

### Claude Code agents (`.claude/agents/`)

| Agent | Use for | Example |
|-------|---------|---------|
| `analyst` | New feature / bug / test intake, plans, task commands | "add feature X", "run task 2 PLAN-001" |
| `planner` | Read-only requirement breakdown | "break down this requirement" |
| `implementer` | Implement a planned task | "implement task 2 of PLAN-001" |
| `quick` | Small edits, single file, docs | "rename variable X → Y" |
| `reviewer` | Code review | "review file X" |
| `security` | OWASP security audit | "security audit" |
| `debugger` | Bug / CI failure diagnosis | "X is not working" |
| `team-lead` | Large feature, runs `dev-1` (backend), `dev-2` (frontend), `dev-3` (db/infra), `tester` in parallel | `claude --agent team-lead` |

Skills: `/plan <requirement>`, `/do <N> PLAN-NNN`, `/todo PLAN-NNN`, `/ship`.

### Codex custom agents (`.codex/agents/`)

Same names as the Claude agents. Each TOML file only points to `.claude/agents/<name>.md`, so a role is edited in one place and shared by Claude and Codex. Codex spawns them when asked (e.g. "use the reviewer agent") or when `AGENTS.md` routing applies.

### Copilot agents (`.github/agents/`)

| Agent | Role |
|-------|------|
| `oryn-dev` | Coordinator — start here |
| `architect` | System design (greenfield) |
| `phase-writer` | Writes phase plans |
| `planner` | Task breakdown |
| `implementer` | Writes code |
| `debugger` | Bugs + CI failures |
| `tc-writer` | Writes test cases |
| `qa-tester` | Runs tests |
| `quick` | Simple tasks |
| `security-auditor` | OWASP audit |
| `code-reviewer` | PR review |

Copilot skills (`.github/skills/`): `/commit-task`, `/create-migration`, `/create-module`, `/log-decision`, `/new-feature`, `/profile-performance`, `/run-api-test`, `/run-e2e-test`, `/update-context`, `/write-test-cases`, plus the `file-indexer` skill.

---

## MCP Servers

| Server | Provider | Used for |
|--------|----------|----------|
| `error-learning` | Local SQLite (separate repo) | Remembers fixed bugs to avoid repeats |
| `github` | GitHub MCP (remote, `api.githubcopilot.com/mcp`) | Issues, PRs, CI logs |
| `playwright` | `@playwright/mcp` | Browser automation for E2E tests |
| `context7` | context7.com | Up-to-date library docs (React, Next.js, Laravel, ...) |

Config: Claude → `.mcp.json`, Codex → `.codex/config.toml`, Copilot → `.vscode/mcp.json`.
In Codex, `playwright` and `error-learning` are disabled by default — set `enabled = true` when needed.

Install `error-learning` (optional; clone its repo into `mcp-error-learning/`, which is git-ignored):
```bash
cd mcp-error-learning && python3 -m pip install -e .
```

---

## Why Thin Adapters

Each AI loads only a short adapter plus the shared `.context/` files, instead of three full, overlapping instruction files. That cuts per-session tokens and removes drift between tools. Keep `PROJECT.md` under ~150 lines and the Codex `AGENTS.md` chain under 32 KiB (Codex's `project_doc_max_bytes` default).

---

## Adding Another AI Tool

For a new tool (e.g. Cursor, Windsurf):

1. Find the file the tool reads (e.g. `.cursor/rules/`).
2. Create a thin adapter there (~30 lines):
   - Read `.context/ACTIVE.md` and `.context/PROJECT.md` first
   - Tool-specific behavior rules only
3. No other files need to change.

---

## Requirements

- **GitHub Copilot:** a recent VS Code with GitHub Copilot (custom agents, Agent Skills, and hooks support)
- **Claude Code:** current Claude Code CLI (skills, `@` imports, command hooks)
- **Codex:** OpenAI Codex CLI with project config, hooks, and custom agents (tested with 0.167.0)
- **MCP:** Node.js 18+, Python 3.11+ (for error-learning)
