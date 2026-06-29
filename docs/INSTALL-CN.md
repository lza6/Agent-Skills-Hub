# 一键安装指南（给他人电脑直接使用）

> 把 `Agent-Skills-Hub` 文件夹复制到对方电脑，或从 Git 克隆后，按下面步骤执行即可。

---

## 环境要求

| 依赖 | 版本 | 下载 |
|------|------|------|
| Node.js | 18+ | https://nodejs.org/ |
| Python | 3.10+ | https://python.org/ |
| 网络 | 稳定 | 需访问 GitHub（`npx skills` 会克隆仓库） |

验证：

```powershell
node -v
npx -v
python --version
```

---

## 方式一：总安装（推荐，一条命令装完全部）

**PowerShell（管理员或普通用户均可）：**

```powershell
cd C:\Users\你的用户名\Agent-Skills-Hub
powershell -NoProfile -ExecutionPolicy Bypass -File .\install-all-skills-total.ps1
```

**或双击运行：**

```
C:\Users\你的用户名\Agent-Skills-Hub\install-all.bat
```

**本机示例（当前用户）：**

```powershell
cd C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub
.\install-all-skills-total.ps1
```

总安装包含：

1. 基础 226 技能（`scripts\install-all-skills.ps1`）
2. Wave 1–42 全栈扩展（约 2800+ 技能）
3. 失败补装（`scripts\final-retry-skills.ps1`）
4. 中文手册生成与同步

预计耗时：**30–90 分钟**

---

## 方式二：仅安装全栈扩展（Wave 1–42，不含基础 226）

```powershell
cd C:\Users\你的用户名\Agent-Skills-Hub
.\install-fullstack-and-update.ps1
```

> 注意：Wave 11–12 已包含在总安装脚本中；也可单独运行：
>
> ```powershell
> powershell -ExecutionPolicy Bypass -File .\scripts\install-fullstack-skills-wave12.ps1
> .\update-docs.ps1
> ```

---

## 方式三：仅更新文档（已装技能，只刷新手册）

```powershell
cd C:\Users\你的用户名\Agent-Skills-Hub
.\update-docs.ps1
```

---

## 安装完成后路径

| 内容 | 路径 |
|------|------|
| Hub 根目录 | `C:\Users\你的用户名\Agent-Skills-Hub\` |
| 中文手册 | `C:\Users\你的用户名\Agent-Skills-Hub\docs\SKILLS-REFERENCE-CN.md` |
| Claude 技能 | `C:\Users\你的用户名\.claude\skills\<技能名>\SKILL.md` |
| Cursor 技能 | `C:\Users\你的用户名\.cursor\skills\<技能名>\SKILL.md` |
| 路径索引 | `C:\Users\你的用户名\Agent-Skills-Hub\docs\PATHS-CN.md` |

查看已安装数量：

```powershell
npx skills ls -g
(Get-ChildItem "$env:USERPROFILE\.claude\skills" -Directory).Count
```

---

## 在 Claude Code / Cursor 中使用

```text
读取 C:\Users\你的用户名\Agent-Skills-Hub\docs\SKILLS-REFERENCE-CN.md，我想做 XXX
```

---

## 国内网络 / GitHub 镜像

总安装与全栈安装脚本**默认启用 GitHub 镜像**，通过 Git 的 `url.*.insteadOf` 将 `https://github.com/` 重定向到镜像站，`npx skills add` 无需改仓库地址。

**默认镜像链（失败自动切换）：**

1. `https://ghfast.top/https://github.com/`
2. `https://mirror.ghproxy.com/https://github.com/`
3. `https://gh-proxy.com/https://github.com/`
4. 最后尝试直连 GitHub

```powershell
# 默认：自动走镜像（推荐国内用户）
.\install-all-skills-total.ps1

# 直连 GitHub（海外或已有代理时）
$env:SKILLS_MIRROR_DISABLED = "1"
.\install-all-skills-total.ps1

# 指定单一镜像
$env:SKILLS_MIRROR_PREFIX = "https://ghfast.top/https://github.com/"
.\install-all-skills-total.ps1

# 自定义镜像列表（分号分隔，按顺序尝试）
$env:SKILLS_MIRROR_LIST = "https://ghfast.top/https://github.com/;https://mirror.ghproxy.com/https://github.com/"
.\install-all-skills-total.ps1
```

镜像模块：`scripts\github-mirror.ps1`（含 `Invoke-SkillInstall` 多镜像重试）  
Wave 16 补装：`scripts\install-fullstack-skills-wave16-retry.ps1`

---

## 常见问题

**Q: 提示无法运行脚本？**  
A: 使用 `-ExecutionPolicy Bypass`，或双击 `install-all.bat`。

**Q: 部分技能安装失败？**  
A: 多为 GitHub 网络问题。国内请确认未设置 `SKILLS_MIRROR_DISABLED=1`；可重跑总安装，或执行 `scripts\install-fullstack-skills-wave16-retry.ps1`，日志见 `logs\`。

**Q: `solidjs-patterns` 装不上？**  
A: 源仓库已下架该技能，可忽略。

**Q: `sickn33/antigravity-awesome-skills` 克隆失败？**  
A: 仓库体积大，网络差时多试几次，或单独运行 Wave 11 补装脚本。
