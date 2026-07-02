# Agent Skills Hub

> Claude Code / Cursor 全局技能的批量安装、元数据与中文文档管理中心。
> 非应用代码仓库，属基础设施 / 工具链项目。

通过 `npx skills` 命令批量安装社区技能到本地 `~/.claude/skills/`、`~/.cursor/skills/`、`~/.agents/skills/`，并自动生成同步的中文技能手册。

---

## ✨ 特性

- 🚀 **一键总安装**：基础技能 + Wave 2–79 全栈扩展，一条命令搞定
- 📚 **大规模技能库**：701 唯一仓库，全局 14000+ 技能，中文元数据 16000+ 条
- 📖 **中文手册自动生成**：46000+ 行中文技能手册，安装后自动同步到 `~/.claude/`
- 🗂️ **仓库总账**：`docs/REPO-INVENTORY.md` 去重汇总所有已装仓库（按 Wave 分组）
- 🔧 **元数据补全**：自动从 SKILL.md 抽取 description 生成中文 stub
- 🔄 **断点续装**：`wave<N>-resume.ps1` 从失败仓库续跑；后台 `schtasks` 调度
- 🌐 **国内网络友好**：内置 GitHub 镜像加速

---

## 📦 快速开始

### 一键总安装（推荐）

```powershell
# 1. 克隆本仓库
git clone https://github.com/lza6/Agent-Skills-Hub.git
cd Agent-Skills-Hub

# 2. 执行总安装（基础 + Wave 2–79 全栈扩展 + 文档同步）
powershell -NoProfile -ExecutionPolicy Bypass -File .\install-all-skills-total.ps1
```

或双击 `install-all.bat`。

> 安装目标路径可在 `docs\PATHS-CN.md` 查看，默认为当前用户主目录下的 `.claude/`、`.cursor/`、`.agents/`。

详细安装说明见 **[`docs\INSTALL-CN.md`](docs/INSTALL-CN.md)**。

### 仅安装全栈扩展（不含基础 226）

```powershell
.\install-fullstack-and-update.ps1
```

### 单波次安装

```powershell
.\scripts\install-fullstack-skills-waveN.ps1   # 全栈 Wave 1–42
.\scripts\install-new-skills-waveN.ps1          # 新技能 Wave 43–72
.\scripts\waveNN-global.ps1                     # 后台波次 Wave 73–79（schtasks 调度）
```

---

## 📂 目录结构

```text
Agent-Skills-Hub/
├── README.md
├── install-all-skills-total.ps1       # 总安装入口（基础 + Wave 2–79）
├── install-all.bat                    # Windows 双击入口
├── install-fullstack-and-update.ps1   # 仅 Wave 扩展 + 文档
├── install-all-new-skills.ps1         # 新技能 Wave 43–72 总入口
├── update-docs.ps1                    # 文档更新入口
├── docs/
│   ├── SKILLS-REFERENCE-CN.md         # 中文技能手册（45600+ 行，核心）
│   ├── SKILLS-REFERENCE.md            # 英文手册（17000+ 行）
│   ├── REPO-INVENTORY.md              # 仓库总账（701 去重仓库，按 Wave 分组）
│   ├── INSTALL-CN.md                  # 给他人电脑的一键安装指南
│   ├── SKILLS-GUIDE-CN.md             # 高效使用技巧指南
│   ├── PATHS-CN.md                    # 完整路径映射说明
│   ├── WAVE-INSTALL-SUMMARY.md        # 各波次安装结果汇总
│   └── SKILLS-CATEGORY-REPORT.md      # 技能分类报告
├── data/
│   ├── skills_zh_data.py              # 中文元数据字典（15000+ 条，核心数据源）
│   ├── repo-inventory.json            # 仓库总账（机读 {repo, waves[]}）
│   └── fullstack-skills-manifest.txt  # 全栈扩展技能清单
├── scripts/
│   ├── install-fullstack-skills-wave*.ps1  # 全栈 Wave 1–42
│   ├── install-new-skills-wave*.ps1        # 新技能 Wave 43–72
│   ├── waveNN-global.ps1                   # 后台波次 Wave 73–79
│   ├── waveNN-resume.ps1                   # 断点续装
│   ├── github-mirror.ps1                   # GitHub 镜像（国内网络加速）
│   ├── sync-all-skills-zh.py               # 元数据补全
│   ├── generate-skills-reference-zh.py     # 中文手册生成
│   ├── generate-skills-reference.py        # 英文手册生成
│   ├── extract-repo-inventory.py           # 仓库总账提取（去重）
│   ├── retry-failed-skills.ps1             # 失败重试
│   └── final-retry-skills.ps1              # 最终补跑
└── logs/
    └── waveNN-global.log              # 各波次详细日志（本机生成，已 gitignore）
```

---

## 🛠️ 核心工作流

```
技能安装 (scripts/waveNN-global.ps1 / install-*-wave*.ps1)
    → sync-all-skills-zh.py              # 元数据补全（从 SKILL.md 抽 description）
    → generate-skills-reference-zh.py    # 中文手册生成
    → generate-skills-reference.py       # 英文手册生成
    → extract-repo-inventory.py          # 刷新仓库总账（去重）
    → 拷贝 SKILLS-REFERENCE-CN.md → ~/.claude/
    → git commit + push                  # 推送
```

**标准循环**：新技能入库 → `.\update-docs.ps1` 刷新手册。
**新波次闭环**：搜索 → `waveN-global.ps1`（后台 schtasks）→ 元数据 → 手册 → 总账 → 推送。

各波次安装结果汇总见 [`docs/WAVE-INSTALL-SUMMARY.md`](docs/WAVE-INSTALL-SUMMARY.md)。

### ⭐ "继续"模糊触发约定

> 在本项目里，新会话中只要说一句**"继续"**（或"继续哈"/"接着装"/"继续推进"等含"继续"语义的话），
> 即自动接上**全栈技能搜索 + 安装 + 记录闭环**，无需重复说明要做什么。

AI 应自动执行：
1. 读 `docs/WAVE-INSTALL-SUMMARY.md` + `data/repo-inventory.json` 确认当前 Wave 编号与已装仓库
2. `npx skills search <全栈方向>` 筛选**未装**的全栈仓库（只取前端/后端/数据库/DevOps/各语言栈/工程实践，不装其他领域）
3. 写 `scripts/wave<N+1>-global.ps1`，`schtasks` 后台安装
4. 走完元数据 → 中英文手册 → 仓库总账 → 更新 `WAVE-INSTALL-SUMMARY.md` + `README.md` 数字
5. `git commit + push`（每波必推送到仓库）

约束：**只装全栈方向**；**每波完成必推送**。详细 SOP 见记忆 `skill-management-workflow` 与 `continue-trigger-workflow`。


---

## 📖 常用操作

### 在 Claude Code 中查阅技能手册

```text
读取 ~/Agent-Skills-Hub/docs/SKILLS-REFERENCE-CN.md，我想做 XXX
```

### 更新中文手册

```powershell
.\update-docs.ps1
# 等效于：
# python scripts/sync-skills-zh-data.py
# python scripts/generate-skills-reference-zh.py
```

### 查看已安装技能

```bash
npx skills ls -g
```

---

## 📁 技能实际安装位置

技能本体由 `npx skills` 安装到系统目录，**本仓库只管理脚本与文档**：

| 用途 | 路径 |
|------|------|
| Claude Code | `~/.claude/skills/<技能名>/SKILL.md` |
| Cursor | `~/.cursor/skills/<技能名>/SKILL.md` |
| 通用规范 | `~/.agents/skills/<技能名>/SKILL.md` |

完整路径索引见 `docs/PATHS-CN.md`。

---

## 🧩 技术栈

| 维度 | 说明 |
|------|------|
| 性质 | 运维 + 工具链，非应用开发 |
| 核心操作 | 技能安装 → 元数据同步 → 文档生成 |
| 主要语言 | PowerShell（脚本）、Python（元数据 / 文档生成）、Node.js / npx（技能安装） |

---

## ⚙️ 代码约定

- **PowerShell**：安装脚本 `$ErrorActionPreference = "Continue"`（不中断整体流程）；文档脚本 `"Stop"`；命名 `Verb-Noun`，路径用 `Join-Path`
- **Python**：类型注解；技能元数据用嵌套 dict；文档生成不依赖 ffmpeg
- **不依赖** Unix 工具（sed / awk / grep），Windows 友好

---

## 🤔 常见问题

| 症状 | 处理 |
|------|------|
| 安装部分失败 | 查看 `logs/`，重跑 `scripts\retry-failed-skills.ps1` |
| 国内网络拉取慢 | 使用 `scripts\github-mirror.ps1` 镜像 |
| 中文文档缺技能说明 | 在 `data\skills_zh_data.py` 补充条目，运行 `update-docs.ps1` |
| 技能装到错误位置 | 检查 `docs\PATHS-CN.md`，确认 `npx skills` 目标路径 |

---

## 📜 License

本项目仅整理、汇总并本地化社区开源技能的安装与文档，技能本体版权归各上游仓库作者所有。
管理脚本部分按 MIT 许可发布，可自由使用。

---

*与 `npx skills` 全局技能安装配套使用。安装新技能后请运行 `update-docs.ps1` 刷新文档。*
