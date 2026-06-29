# Agent Skills Hub

> Claude Code / Cursor 全局技能的批量安装、元数据与中文文档管理中心。
> 非应用代码仓库，属基础设施 / 工具链项目。

通过 `npx skills` 命令批量安装社区技能到本地 `~/.claude/skills/`、`~/.cursor/skills/`、`~/.agents/skills/`，并自动生成同步的中文技能手册。

---

## ✨ 特性

- 🚀 **一键总安装**：基础技能 + Wave 1–71 全栈扩展，一条命令搞定
- 🌐 **国内网络友好**：内置 GitHub 镜像加速，无需代理也能装
- 📚 **中文手册自动生成**：272+ 技能的中文说明，安装后自动同步到 `~/.claude/`
- 🔧 **元数据补全**：自动为新技能生成中文 stub 说明
- 🔄 **失败重试机制**：断点续装，支持单波次补跑

---

## 📦 快速开始

### 一键总安装（推荐）

```powershell
# 1. 克隆本仓库
git clone https://github.com/lza6/Agent-Skills-Hub.git
cd Agent-Skills-Hub

# 2. 执行总安装（基础 + Wave 1–71 + 文档同步）
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
.\scripts\install-fullstack-skills-waveN.ps1   # N = 1..71
```

---

## 📂 目录结构

```text
Agent-Skills-Hub/
├── README.md
├── install-all-skills-total.ps1       # 总安装入口（14 步骤）
├── install-all.bat                    # Windows 双击入口
├── install-fullstack-and-update.ps1   # 仅 Wave 扩展 + 文档
├── update-docs.ps1                    # 文档更新入口
├── docs/
│   ├── SKILLS-REFERENCE-CN.md         # 中文技能手册（核心，推荐）
│   ├── SKILLS-REFERENCE.md            # 英文简要版
│   ├── INSTALL-CN.md                  # 给他人电脑的一键安装指南
│   ├── PATHS-CN.md                    # 完整路径映射说明
│   └── SKILLS-CATEGORY-REPORT.md      # 技能分类报告
├── data/
│   ├── skills_zh_data.py              # 技能中文元数据字典（核心数据源）
│   └── fullstack-skills-manifest.txt  # 全栈扩展技能清单（Wave 1–71）
├── scripts/
│   ├── install-all-skills.ps1         # 基础技能批量安装
│   ├── install-fullstack-skills-wave*.ps1  # Wave 1–71 各波次脚本
│   ├── github-mirror.ps1              # GitHub 镜像（国内网络加速）
│   ├── sync-skills-zh-data.py         # 自动补全新技能中文说明
│   ├── generate-skills-reference-zh.py # 中文手册生成
│   ├── generate-skills-reference.py    # 英文手册生成
│   ├── retry-failed-skills.ps1        # 失败重试
│   └── final-retry-skills.ps1         # 最终补跑
└── logs/                              # 安装日志（已 gitignore，本机生成）
```

---

## 🛠️ 核心工作流

```
技能安装 (scripts/*.ps1)
    → sync-skills-zh-data.py         # 元数据补全
    → generate-skills-reference-zh.py # 中文手册生成
    → generate-skills-reference.py    # 英文手册生成
    → 拷贝 SKILLS-REFERENCE-CN.md → ~/.claude/
```

**标准循环**：新技能入库 → `.\update-docs.ps1` 刷新手册。

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
