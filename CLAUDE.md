# Agent Skills Hub

Claude Code / Cursor 全局技能安装、元数据与文档管理中心。非应用代码项目，属基础设施/工具项目。

> Git 仓库：`main` 分支。提交归属已全局禁用（`~/.claude/settings.json`），无需手写 Co-authored-by。

---

## 项目类型

| 维度 | 说明 |
|------|------|
| 性质 | 运维+工具链，非应用开发 |
| 核心操作 | 技能安装 → 元数据同步 → 文档生成 |
| 技术栈 | PowerShell (主力)、Python、Node.js/npx |
| 交付物 | 安装脚本、文档、元数据、日志 |

---

## 目录职责

| 路径 | 职责 |
|------|------|
| `scripts/install-fullstack-skills-wave*.ps1` | 全栈技能批量安装（Wave 1–42） |
| `scripts/install-new-skills-wave*.ps1` | 新技能批量安装（Wave 43–67+） |
| `scripts/*.py` | 元数据同步、文档生成、翻译 |
| `data/skills_zh_data.py` | 技能中文元数据字典（核心数据源，**勿手改**） |
| `data/fullstack-skills-manifest.txt` | 扩展技能清单 |
| `.agents/skills/` | 技能本体镜像（2.6 万文件，只读参考） |
| `docs/SKILLS-REFERENCE-CN.md` | 中文手册（同步到 `~/.claude/`） |
| `logs/` | 安装日志（勿手动清理） |
| `install-all-skills-total.ps1` | 全栈总安装入口 |
| `install-all-new-skills.ps1` | 新技能总安装入口 |
| `install-fullstack-and-update.ps1` | 全栈安装+文档刷新 |
| `update-docs.ps1` | 文档更新入口 |

---

## 核心工作流

```
技能安装 (scripts/*.ps1)
    → sync-skills-zh-data.py (元数据补全)
    → generate-skills-reference-zh.py (中文手册)
    → generate-skills-reference.py (英文手册)
    → copy SKILLS-REFERENCE-CN.md → ~/.claude/
```

**标准循环：** 新技能入库 → `.\update-docs.ps1` 刷新手册

---

## 关键操作规程

### 安装技能

```powershell
# 全栈技能（Wave 1–42）
.\install-all-skills-total.ps1

# 新技能（Wave 43–67+）
.\install-all-new-skills.ps1

# 全栈安装 + 文档刷新
.\install-fullstack-and-update.ps1

# 单波次
scripts\install-fullstack-skills-waveN.ps1   # N=1..42
scripts\install-new-skills-waveN.ps1          # N=43..67+
```

### 更新文档

```powershell
.\update-docs.ps1
# 等效于: python scripts/sync-skills-zh-data.py && python scripts/generate-skills-reference-zh.py
```

### 查看已安装技能

```bash
npx skills ls -g
```

---

## 代码约定

### PowerShell
- `$ErrorActionPreference = "Continue"`（安装脚本用，不中断整体流程）
- `$ErrorActionPreference = "Stop"`（文档脚本用，失败立即停止）
- 命名：`Verb-Noun`，路径用 `Join-Path`
- 不依赖 Unix 工具（sed/awk/grep）

### Python
- 类型注解
- 技能元数据用嵌套 dict 结构
- 文档生成：ffmpeg-free、依赖 `skills_zh_data.py`

---

## 项目特有规则

1. **从不修改 `skills_zh_data.py` 手动** — 通过 `sync-skills-zh-data.py` 或 `update-docs.ps1` 自动更新
2. **安装后必须更新文档** — 加新技能后运行 `update-docs.ps1`
3. **日志留存** — 安装日志自动写入 `logs/`，不手动清理
4. **技能本体不在本仓库** — 安装到 `~/.claude/skills/`，本仓库只管理脚本/文档/元数据
5. **优先 `npx skills` 而非 git clone** — 技能安装优先使用 `npx skills` 命令而非直接克隆仓库

---

## 常见问题

| 症状 | 处理 |
|------|------|
| 安装部分失败 | 检查 `logs/failures.txt`，重跑 `scripts/retry-failed-skills.ps1` |
| 中文文档缺技能说明 | 在 `data/skills_zh_data.py` 补充条目，然后运行 `update-docs.ps1` |
| 技能装到错误位置 | 检查 PATHS-CN.md，确保 `npx skills` 目标路径正确 |

---

## 引用资源

- `docs/PATHS-CN.md` — 完整路径映射
- `docs/INSTALL-CN.md` — 给他人电脑的一键安装指南
- `docs/SKILLS-REFERENCE-CN.md` — 技能中文手册
