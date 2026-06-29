# Agent Skills Hub — 完整路径说明

> 用户主目录：`C:\Users\Administrator.DESKTOP-EGNE9ND\`  
> 下文 `%USERPROFILE%` 均指上述路径。

---

## 1. Hub 管理中心（文档 + 脚本，不含技能本体）

```
C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\
├── README.md
├── install-all-skills-total.ps1  ← 【总安装】基础226 + Wave1-42
├── install-all.bat               ← 双击总安装
├── update-docs.ps1
├── install-fullstack-and-update.ps1
├── docs\
│   ├── SKILLS-REFERENCE-CN.md      ← 中文详细手册（主文档）
│   ├── SKILLS-REFERENCE.md         ← 英文简要版
│   ├── INSTALL-CN.md               ← 一键安装指南（给他人）
│   └── PATHS-CN.md                 ← 本文件（路径索引）
├── data\
│   ├── skills_zh_data.py           ← 技能中文元数据
│   └── fullstack-skills-manifest.txt
├── scripts\
│   ├── install-all-skills.ps1      ← 基础 226 技能
│   ├── install-fullstack-skills.ps1          # Wave 1
│   ├── install-fullstack-skills-wave2.ps1 … wave42.ps1
│   ├── sync-skills-zh-data.py
│   ├── generate-skills-reference-zh.py
│   └── generate-skills-reference.py
└── logs\
```

---

## 2. 技能本体安装位置（`npx skills add -g` 全局安装）

每个技能是一个文件夹，内含 `SKILL.md`：

| IDE / 规范 | 根目录 | 示例（Tavily 技能） |
|------------|--------|---------------------|
| **Claude Code** | `%USERPROFILE%\.claude\skills\` | `C:\Users\Administrator.DESKTOP-EGNE9ND\.claude\skills\tavily\SKILL.md` |
| **Cursor** | `%USERPROFILE%\.cursor\skills\` | `C:\Users\Administrator.DESKTOP-EGNE9ND\.cursor\skills\tavily\SKILL.md` |
| **通用 Agent 规范** | `%USERPROFILE%\.agents\skills\` | `C:\Users\Administrator.DESKTOP-EGNE9ND\.agents\skills\tavily\SKILL.md` |

### 当前技能数量（Wave 42 后）

| 路径 | 技能文件夹数 |
|------|-------------|
| `C:\Users\Administrator.DESKTOP-EGNE9ND\.claude\skills\` | **3140** |
| `C:\Users\Administrator.DESKTOP-EGNE9ND\.cursor\skills\` | **641** |
| `C:\Users\Administrator.DESKTOP-EGNE9ND\.agents\skills\` | **2938** |

> Cursor 数量较少属正常：部分 Wave 通过 `-a "*"` 写入各 Agent，各目录同步程度因 Agent 类型而异。

---

## 3. 手册副本（Claude Code 可直接读取）

| 文件 | 路径 |
|------|------|
| Hub 主副本 | `C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\docs\SKILLS-REFERENCE-CN.md` |
| Claude 同步副本 | `C:\Users\Administrator.DESKTOP-EGNE9ND\.claude\SKILLS-REFERENCE-CN.md` |

---

## 4. 常用命令（带绝对路径）

```powershell
# ========== 总安装（推荐，给他人电脑直接用）==========
cd C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub
powershell -NoProfile -ExecutionPolicy Bypass -File .\install-all-skills-total.ps1
# 或双击: C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\install-all.bat

# ========== 仅全栈 Wave 1-42（默认 GitHub 镜像）==========
.\install-fullstack-and-update.ps1

# ========== 禁用镜像，直连 GitHub ==========
$env:SKILLS_MIRROR_DISABLED = "1"
.\install-all-skills-total.ps1

# ========== 仅更新手册 ==========
.\update-docs.ps1

# 查看已安装技能
npx skills ls -g
(Get-ChildItem "$env:USERPROFILE\.claude\skills" -Directory).Count
```

详细安装说明：`C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\docs\INSTALL-CN.md`

---

## 5. Wave 10 新增技能路径示例

| 技能名 | Claude 路径 |
|--------|-------------|
| prisma-postgres-setup | `C:\Users\Administrator.DESKTOP-EGNE9ND\.claude\skills\prisma-postgres-setup\SKILL.md` |
| wordpress-content | `C:\Users\Administrator.DESKTOP-EGNE9ND\.claude\skills\wordpress-content\SKILL.md` |
| mcp-server-security | `C:\Users\Administrator.DESKTOP-EGNE9ND\.claude\skills\mcp-server-security\SKILL.md` |
| tavily | `C:\Users\Administrator.DESKTOP-EGNE9ND\.claude\skills\tavily\SKILL.md` |
| ai-sre-incident-response | `C:\Users\Administrator.DESKTOP-EGNE9ND\.claude\skills\ai-sre-incident-response\SKILL.md` |

**Wave 10 待补装（网络克隆失败）：**

- `fastapi-router-py`
- `python-fastapi-development`

源仓库：`https://github.com/sickn33/antigravity-awesome-skills`（体积大，偶发 TLS/克隆超时）
