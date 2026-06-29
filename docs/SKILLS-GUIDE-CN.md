# Claude Code / Cursor 技能高效使用指南

> **目标读者**：已通过本 Hub 安装全局技能（3000+ 个）的开发者
> **目标**：让你在最短时间内，把几千个技能变成真正的生产力杠杆
> **配套文档**：[`SKILLS-REFERENCE-CN.md`](./SKILLS-REFERENCE-CN.md)（技能检索手册）

---

## 一、心智模型：技能到底为你做了什么

技能（Skill）不是插件，不是 MCP server，**它是一份「按需注入的操作手册」**。

当你对 Claude Code 说一句话时，Claude 会：
1. 读取所有技能的 `description`（一句话元数据）
2. 判断哪一条与你的任务**相关**
3. 只有相关的技能，才会被**完整加载**进上下文

所以：**装 3000 个技能 ≠ 上下文爆炸**。未命中的技能只占一行 description。理解这一点，你就敢放心装全栈。

---

## 二、三种调用方式（从最推荐到最不推荐）

### ✅ 方式 1：自然语言描述意图（首选）

让 description 自动匹配，无需记技能名。

```text
# 好：描述意图，让 Claude 自己选技能
"帮我把这个 Next.js 项目部署到 Vercel，并优化首屏 LCP"
→ 自动命中 vercel-deploy + nextjs 最佳实践 + performance 技能

"给这个 Express API 加上速率限制和 JWT 认证"
→ 自动命中 api-rate-limiting + jwt-security + auth 技能
```

**技巧**：在意图里带上**技术栈关键词**（Next.js、Prisma、PostgreSQL、K8s），命中率显著提升。

### ⚠️ 方式 2：显式点名技能（精确控制）

当你要用某个特定技能、或自然语言没命中时：

```text
"用 frontend-design 技能，帮我重新设计这个落地页的视觉层次"
"用 systematic-debugging 技能排查这个内存泄漏"
"调用 mcp-builder 技能帮我搭一个 MCP server"
```

**适用场景**：你知道某个技能比 Claude 默认行为更专业（如 `tdd-guide`、`security-reviewer`）。

### 🎯 方式 3：斜杠命令（技能自带的快捷入口）

部分技能注册了斜杠命令：

```text
/tdd              # 启动测试驱动开发流程
/code-review      # 触发代码审查
/update-docs      # 刷新本 Hub 文档
/brainstorming    # 进入头脑风暴模式
```

输入 `/` 后会弹出可用命令列表。

---

## 三、全栈任务的最佳技能组合

实战中，复杂任务往往需要**组合多个技能**。以下是经过验证的高效配方：

### 🏗️ 新功能开发流

```text
"我要做一个带支付和邮件通知的 SaaS 注册功能（Next.js + Postgres）"
推荐链路：
  planner        → 拆解任务、识别依赖
  tdd-guide      → 先写测试
  fullstack-developer → 数据库/API/前端协同实现
  stripe-integration  → 支付集成
  code-reviewer  → 提交前自审
```

### 🐛 排查疑难 Bug

```text
"生产环境间歇性出现 500 错误，本地复现不了"
推荐链路：
  systematic-debugging → 假设驱动、二分定位
  debugger       → 日志/堆栈分析
  performance-engineer → 若怀疑性能/资源问题
```

### 🔒 上线前安全检查

```text
"这个 PR 准备合并，帮我做安全审查"
推荐链路：
  security-reviewer → OWASP Top 10 扫描
  sql-sentinel      → SQL 注入
  xss-prevention    → XSS 防护
  secret-scanning   → 硬编码密钥
```

### 🎨 前端重构

```text
"这个页面太像 Tailwind 默认模板了，帮我做出设计感"
推荐链路：
  frontend-design    → 视觉方向与层次
  design-system      → 设计 token 一致性
  a11y               → 可访问性兜底
```

### 📊 数据库优化

```text
"这个 API 慢，怀疑是 N+1 查询"
推荐链路：
  database-reviewer    → 索引与查询分析
  postgresql-optimization → PostgreSQL 专项
  postgres-query       → EXPLAIN 解读
```

---

## 四、避免上下文浪费的 5 个技巧

1. **一次只聚焦一个领域**：别在一句话里塞 5 个不相关任务，会同时拉起多个技能。
2. **小任务别点大技能**：改个文案别用 `architect`，用默认行为即可。
3. **长会话主动 `/clear`**：技能加载后会留在上下文，任务切换时清理。
4. **优先用 description 匹配**，只在必要时显式点名——让 Claude 做它擅长的意图理解。
5. **关闭用不上的技能**：`npx skills remove <name>` 卸载，比留着更省 token。

---

## 五、查看与管理已装技能

```bash
# 列出全部已装技能
npx skills ls -g

# 安装新技能（本 Hub 推荐方式）
npx skills install <owner>/<repo>

# 卸载
npx skills remove <skill-name>

# 查看技能本体内容
cat ~/.claude/skills/<skill-name>/SKILL.md
```

---

## 六、如何判断「该不该为这个任务用技能」

问自己三个问题：

| 问题 | 是 | 否 |
|------|----|----|
| 这是否一个**有标准最佳实践**的领域？（认证、支付、部署） | ✅ 用技能 | 用默认 |
| 这是否**高风险**？（安全、数据迁移、生产改动） | ✅ 用技能 | 用默认 |
| Claude 默认输出是否**明显不够专业**？（设计、TDD、性能） | ✅ 用技能 | 用默认 |

三个「是」≥ 2 个，就值得显式调技能。

---

## 七、常见误区

### ❌ 误区 1：「装太多技能会拖慢 Claude」

**不会**。未命中的技能只占一行 description。真正费 token 的是被命中的技能全文 + 你的对话历史。

### ❌ 误区 2：「技能名字必须完全记对」

**不用**。Claude 做 fuzzy 匹配。说「帮我做 TDD」会命中 `tdd-guide`，无需背全名。

### ❌ 误区 3：「每个任务都要显式调技能」

**过度了**。日常简单任务用默认行为更快。技能是**杠杆**，不是**仪式**。

### ❌ 误区 4：「英文技能对我没用」

**用错了**。技能本体是英文 prompt，但你用中文描述任务照样能命中，输出也跟随你的语言。

---

## 八、本 Hub 的标准维护循环

```
发现新技能仓库
   ↓
追加到 data/new-skills-repos.txt
   ↓
scripts/install-fullstack-skills-waveN.ps1  （或 npx skills install）
   ↓
python scripts/sync-skills-zh-data.py      （补全中文元数据）
   ↓
.\update-docs.ps1                          （刷新手册 + 同步到 ~/.claude/）
   ↓
在 Claude Code 里：读取 ~/Agent-Skills-Hub/docs/SKILLS-REFERENCE-CN.md
```

**黄金法则**：装完技能 → 跑 `update-docs.ps1` → 手册自动更新。手册永远反映你本机真实状态。

---

## 九、快速检索：按场景找技能

| 我想做... | 直接搜 / 说 |
|----------|------------|
| 写测试 | `tdd-guide` / "帮我写单元测试" |
| 代码审查 | `code-reviewer` / "审查这段代码" |
| 数据库设计 | `database-architect` / "设计数据库 schema" |
| 前端设计 | `frontend-design` / "重新设计页面" |
| 部署上云 | `vercel-deploy` / `aws-cdk` / "部署到云" |
| DevOps | `kubernetes-patterns` / `terraform` / "配置 K8s" |
| 安全 | `security-reviewer` / "安全扫描" |
| AI/LLM | `langchain` / `rag-architect` / "搭 RAG" |
| 文档 | `doc-updater` / `readme-generator` / "更新文档" |

> 完整检索请查 [`SKILLS-REFERENCE-CN.md`](./SKILLS-REFERENCE-CN.md) 的「按分类技能详解」章节。

---

*本指南与技能手册配套使用。技能是放大器——你的判断力才是乘数。*
