# Multi-AI Workspace Setup

> Unified context system cho **GitHub Copilot + Claude + OpenAI Codex** trong cùng một dự án.
> Project context chỉ cập nhật 1 chỗ → tất cả AI tự động đồng bộ.

---

## Vấn đề được giải quyết

Khi dùng nhiều AI cùng lúc, mỗi AI có file context riêng (CLAUDE.md, copilot-instructions.md, AGENTS.md). Khi project thay đổi stack, convention, hay thêm module — phải sửa 2-3 file.

**Giải pháp:** Single source of truth trong `.context/PROJECT.md`. Mỗi AI chỉ có thin adapter trỏ đến đó.

```
CLAUDE.md (40 lines)           ─┐
AGENTS.md (35 lines)            ├──→ .context/PROJECT.md (120 lines)
.github/copilot-instructions.md ─┘         ↑
                                    1 file, 1 lần update
```

---

## Cài đặt (5 phút)

### 1. Copy vào project

```bash
# Clone repo này
git clone https://github.com/orynvn/multi-AI-workspace-setup.git

# Copy vào project của bạn
cp -r multi-AI-workspace-setup/.context your-project/
cp -r multi-AI-workspace-setup/.github your-project/
cp -r multi-AI-workspace-setup/.claude your-project/
cp -r multi-AI-workspace-setup/.vscode your-project/
cp multi-AI-workspace-setup/CLAUDE.md your-project/
cp multi-AI-workspace-setup/AGENTS.md your-project/
```

### 2. Chọn stack template

```bash
# Ví dụ: dùng Next.js
cp multi-AI-workspace-setup/templates/nextjs/PROJECT.md your-project/.context/PROJECT.md

# Các stack có sẵn: nextjs | laravel | nestjs | django | fastapi | react
```

### 3. Điền thông tin project

Chỉ cần sửa 2 file:

**`.context/PROJECT.md`** — điền phần đầu:
```markdown
**Name:** My App
**Description:** ...
**Repository:** https://github.com/org/repo
```

**`.context/ACTIVE.md`** — điền sprint hiện tại:
```markdown
**Name:** Sprint 1 — Initial Setup
**Branch:** feat/initial-setup
**Started:** 2026-05-05
```

**Xong.** `CLAUDE.md`, `AGENTS.md`, `.github/copilot-instructions.md` không cần chỉnh sửa.

---

## Cách hoạt động

### Ai đọc gì

| File | Claude | Copilot | Codex | Tần suất |
|------|--------|---------|-------|----------|
| `.context/ACTIVE.md` | ✓ | ✓ | ✓ | Mỗi session |
| `.context/PROJECT.md` | ✓ | ✓ | ✓ | Mỗi session |
| `.context/DECISIONS.md` | on-demand | on-demand | on-demand | Khi cần arch decision |
| `.context/ERRORS.md` | on-demand | on-demand | on-demand | Khi fix bug |
| `.context/FILE-INDEX.md` | on-demand | on-demand | on-demand | Khi locate file |

### One-update rule

```
Thêm module mới → sửa .context/PROJECT.md (Module Map)
                  → tất cả AI biết ngay ở session tiếp theo
                  → không cần sửa CLAUDE.md, AGENTS.md, copilot-instructions.md
```

---

## File Structure

```
project-root/
├── CLAUDE.md                          # Thin adapter cho Claude Code
├── AGENTS.md                          # Thin adapter cho OpenAI Codex CLI
│
├── .context/                          # SHARED brain — đọc bởi tất cả AI
│   ├── PROJECT.md                     # ★ Single source of truth
│   ├── ACTIVE.md                      # Current sprint (cập nhật mỗi ngày)
│   ├── HISTORY.md                     # Changelog
│   ├── DECISIONS.md                   # ADR index
│   ├── ERRORS.md                      # Bug log & anti-patterns
│   ├── FILE-INDEX.md                  # Module → file map
│   ├── log.sh                         # Script cập nhật HISTORY.md
│   ├── decisions/                     # Individual ADR files
│   ├── plans/                         # PLAN-NNN, phase-N files
│   └── test-cases/
│
├── .github/
│   ├── copilot-instructions.md        # Thin adapter cho Copilot
│   ├── agents/                        # 11 Copilot agents
│   ├── instructions/                  # Stack-specific (laravel, nextjs, ...)
│   ├── prompts/                       # Slash command templates
│   ├── hooks/scripts/                 # VS Code hooks
│   └── skills/                        # Reusable Copilot skills
│
├── .claude/
│   ├── settings.json                  # MCP servers + hooks
│   ├── agents/                        # 7 Claude agents
│   ├── commands/                      # Custom /commands
│   └── hooks/                         # pre-bash, post-edit, session-stop
│
├── .vscode/
│   ├── settings.json                  # VS Code + Copilot settings
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

### Sau mỗi task

```bash
# Dùng script
.context/log.sh "feat(auth): implement JWT refresh — src/auth/"

# Hoặc thủ công — append vào .context/HISTORY.md
[2026-05-05] feat: JWT refresh — src/auth/service.ts
```

Sau đó update `.context/ACTIVE.md`:
- Đánh dấu task done trong bảng In Progress
- Cập nhật Recent Context (last 3 entries)

### Đầu sprint mới

```bash
# Reset .context/ACTIVE.md
**Name:** Sprint 2 — User Profile
**Branch:** feat/user-profile
**Started:** 2026-05-10
```

### Thêm module mới vào project

```markdown
# Sửa .context/PROJECT.md, phần Module Map:
| auth    | feature | Auth, JWT refresh, token revocation | complete |
| profile | feature | User profile CRUD                   | in-progress |
```

---

## AI Agents

### Claude Code agents (`.claude/agents/`)

| Agent | Dùng khi | Invoke |
|-------|----------|--------|
| `@analyst` | Tính năng mới / bug / test | "thêm tính năng X" |
| `@implementer` | Có plan rồi, implement | "run task 2 PLAN-001" |
| `@quick` | Sửa nhỏ, 1 file | "đổi tên biến X → Y" |
| `@reviewer` | Review code | "review file X" |
| `@security` | Security audit | "audit bảo mật" |
| `@debugger` | Fix bug | "lỗi X không chạy" |
| `@planner` | Phân tích yêu cầu | "phân tích requirement" |

### Copilot agents (`.github/agents/`)

| Agent | Role |
|-------|------|
| `oryn-dev` | Coordinator — gọi agent này trước |
| `architect` | Thiết kế system (greenfield) |
| `phase-writer` | Viết phase plans |
| `planner` | Task breakdown |
| `implementer` | Viết code |
| `debugger` | Fix bugs + CI failures |
| `tc-writer` | Viết test cases |
| `qa-tester` | Chạy tests |
| `quick` | Task đơn giản |
| `security-auditor` | OWASP audit |
| `code-reviewer` | PR review |

---

## MCP Servers

| Server | Provider | Dùng cho |
|--------|----------|---------|
| `error-learning` | Local SQLite | Ghi nhớ bugs đã fix, tránh lặp lại |
| `github` | @modelcontextprotocol/server-github | Issues, PRs, CI logs |
| `playwright` | @playwright/mcp | E2E testing browser automation |
| `context7` | context7.com | Library docs (React, Next.js, Laravel...) |

Setup `GITHUB_TOKEN`:
```bash
export GITHUB_TOKEN=ghp_your_token
```

---

## Token Savings

| Approach | Tokens/session (3 AI) |
|----------|----------------------|
| 3 full entry files (cũ) | ~3,100 |
| 3 thin adapters + shared context (mới) | ~1,730 |
| **Tiết kiệm** | **~44% (~1,370 tokens/session)** |

---

## Thêm AI tool mới

Khi có thêm AI mới (ví dụ Cursor, Windsurf):

1. Tìm file config của AI đó đọc (ví dụ `.cursorrules`)
2. Tạo thin adapter tại đó (~30 lines):
   - Đọc `.context/ACTIVE.md` và `.context/PROJECT.md` trước
   - AI-specific behavior rules
3. Không cần sửa bất kỳ file nào khác

---

## Yêu cầu

- **GitHub Copilot**: VS Code v1.100+, GitHub Copilot extension
- **Claude**: Claude Code CLI
- **Codex**: OpenAI Codex CLI
- **MCP**: Node.js 18+, Python 3.11+ (cho error-learning)
