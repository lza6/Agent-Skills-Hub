#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""生成 Claude Code 全局技能中文总览手册（详细版）。"""
from __future__ import annotations

import os
import re
import sys
from pathlib import Path

HUB_DIR = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(HUB_DIR / "data"))
from skills_zh_data import SKILL_ZH  # noqa: E402

FULLSTACK_MANIFEST = HUB_DIR / "data" / "fullstack-skills-manifest.txt"

try:
    import yaml
except ImportError:
    yaml = None

SKILLS_DIR = Path(os.path.expanduser("~/.claude/skills"))
OUTPUT = HUB_DIR / "docs" / "SKILLS-REFERENCE-CN.md"

REQUESTED = list(dict.fromkeys("""
frontend-design vercel-react-best-practices entra-app-registration skill-creator
web-artifacts-builder brand-guidelines building-native-ui git-commit next-cache-components
prd documentation-writer refactor clerk-custom-ui multi-stage-dockerfile create-specification
refactor-plan sql-optimization postgresql-optimization clerk-orgs sql-code-review agentic-eval
ai-prompt-engineering-safety-review markdown-to-html devops-rollout-plan
create-architectural-decision-record refactor-method-complexity-reduce breakdown-feature-implementation
update-specification remember folder-structure-blueprint-generator breakdown-test breakdown-epic-pm
technology-stack-blueprint-generator code-exemplars-blueprint-generator structured-autonomy-plan
what-context-needed update-markdown-file-index structured-autonomy-implement polyglot-test-agent
create-web-form code-simplifier ask-questions-if-underspecified code-review claude-md-improver
memory-management system-design postgres web-coder nextjs tech-debt fp-check knowledge-synthesis
audit-context-building guidelines-advisor coverage-analysis audit-prep-assistant search-strategy
incident-response argent-react-native-optimization debug semgrep-rule-creator deploy-checklist
secret-scanning update search redis-development skill-improver product-brainstorming motion-design
assistant-ui sql-queries react-router-framework-mode premium-frontend-ui thread-list
react-native-testing write-spec generating-permission-set generating-flexipage process-optimization
data-context-extractor skill-scanner write-query create-agentsmd benchmark-optimization-loop
meticulous-review agenthub docker-containerization api-test-suite-builder browser-automation
parallel-execution-optimizer critical-code-reviewer executing-plans cc-skill-coding-standards
fastify-typescript wordpress-plugin-core plan create-pr long-task-coordinator java
logging-best-practices auth0-vue e2e-testing-automation python-code-review no-use-effect
mastering-typescript code-refactoring-tech-debt backend-development-feature-development biome
api-documenter bash-scripting system-architect api-design-reviewer tanstack-config
cursor-best-practices autopilot postgresql requesting-code-review code-refactoring deepinit
dead-code performance-engineer sql-database-assistant nestjs-expert clean-code api-testing
rust-backend compose-ui-testing-patterns python-testing fastapi-pro grepai-search-tips
test-driven-development file-manager domain-driven-design grepai-trace-graph pua-trae
technical-specification test-anti-patterns ssh debugger plan-review supabase qa-expert
multi-tenant-architecture kaizen create-rule python-pro rust-deps-visualizer writing-plans
verification-before-completion why premortem fix-tests optimize-for-gpu backend-dev-guidelines
do-in-steps do-in-parallel ai-slop-cleaner cx-incident-management implement-task
antigravity-workflows plan-task agent-evaluation django-celery-expert axiom-networking
root-cause-tracing data-throughput-accelerator backend-development unsafe-checker
architecture-patterns docker-expert go-control-flow meticulous-iterative-dev meticulous-test
python-code-quality go-packages software-architecture-design go-functional-options go-defensive
critique go-data-structures react-audit-grep-patterns review-logging-patterns plan-writing
rabbitmq-development api-contract-testing cx-alerts brainstorm rust-trait-explorer
test-automator go-context pagespeed-insights go-interfaces using-superpowers go-style-core
clickup zod-schema-validation review-changes codebase-cleanup-refactor-clean go-concurrency
status-page-generator go-performance go-error-handling go-naming database-architect
clean-code-principles feedback-page-generator nodejs-backend-typescript cudaq-guide lua
go-documentation flask-python backend-security-coder explore-codebase checking-freshness
async-io-model test-specialist cto-advisor v3-performance-optimization openspec-archiving
go-linting v3-ddd-architecture schema-exploration pair-programming oauth ios-icon-gen
cisco-ios-patterns
book-to-skill extract-design-system database-design slide-deck-skill
paper2blogpost deepweb auto-routines patdown the-team nib kindlepub
tufte-aesthetics-and-technique tufte-analytical-design tufte-causal-reasoning-in-graphics
tufte-chartjunk tufte-color-in-information-design tufte-data-density
tufte-data-ink-ratio tufte-data-maps tufte-escaping-flatland
tufte-evidence-corruption tufte-graphical-excellence tufte-graphical-integrity
tufte-layering-and-separation tufte-link-differentiation tufte-mapped-pictures
tufte-micro-macro-readings tufte-multifunctioning-elements tufte-narrative-and-sequence
tufte-redundant-encoding tufte-small-multiples tufte-space-time-graphics
tufte-sparklines tufte-typography-for-data tufte-visual-thinking
hand-drawn drawio strudel loop-engineering chief-of-staff ag-design-skills
""".split()))

CATEGORIES: dict[str, list[str]] = {
    "一、前端 / UI / 视觉设计": [
        "frontend-design", "brand-guidelines", "building-native-ui", "motion-design",
        "premium-frontend-ui", "assistant-ui", "thread-list", "react-native-testing",
        "compose-ui-testing-patterns", "no-use-effect", "mastering-typescript",
        "cursor-best-practices", "web-artifacts-builder", "argent-react-native-optimization",
        "clerk-custom-ui", "clerk-orgs", "auth0-vue", "react-router-framework-mode",
        "tanstack-config", "nextjs", "next-cache-components", "vercel-react-best-practices",
    ],
    "二、后端 / API / 系统架构": [
        "backend-development", "backend-development-feature-development", "backend-dev-guidelines",
        "backend-security-coder", "fastapi-pro", "fastify-typescript", "nestjs-expert",
        "docker-expert", "docker-containerization", "multi-stage-dockerfile",
        "multi-tenant-architecture", "system-design", "system-architect",
        "software-architecture-design", "architecture-patterns", "database-architect",
        "domain-driven-design", "django-celery-expert", "rust-backend",
        "nodejs-backend-typescript", "java", "flask-python", "lua", "oauth",
        "redis-development", "postgres", "postgresql", "supabase", "rabbitmq-development",
    ],
    "三、Go 语言专项": [
        "go-control-flow", "go-packages", "go-functional-options", "go-defensive",
        "go-data-structures", "go-context", "go-interfaces", "go-style-core",
        "go-concurrency", "go-performance", "go-error-handling", "go-naming",
        "go-documentation", "go-linting",
    ],
    "四、Rust 语言专项": ["rust-deps-visualizer", "unsafe-checker", "rust-trait-explorer"],
    "五、测试 / 质量保障 (QA)": [
        "test-driven-development", "test-automator", "test-anti-patterns", "test-specialist",
        "python-testing", "api-testing", "api-test-suite-builder", "api-contract-testing",
        "e2e-testing-automation", "breakdown-test", "polyglot-test-agent", "meticulous-review",
        "meticulous-iterative-dev", "meticulous-test", "critical-code-reviewer",
    ],
    "六、代码审查 / 重构 / 代码质量": [
        "code-review", "code-reviewer", "code-simplifier", "code-refactoring",
        "code-refactoring-tech-debt", "refactor", "refactor-plan",
        "refactor-method-complexity-reduce", "codebase-cleanup-refactor-clean",
        "clean-code", "clean-code-principles", "cc-skill-coding-standards",
        "python-code-review", "python-code-quality", "python-pro", "biome",
        "review-changes", "review-delta", "review-pr", "explore-codebase",
        "grepai-search-tips", "grepai-trace-graph",
    ],
    "七、规划 / 项目管理 / 需求规格": [
        "prd", "create-specification", "update-specification", "write-spec",
        "technical-specification", "breakdown-feature-implementation", "breakdown-epic-pm",
        "executing-plans", "writing-plans", "plan", "plan-writing", "plan-review",
        "plan-task", "structured-autonomy-plan", "structured-autonomy-implement",
        "long-task-coordinator", "create-pr", "devops-rollout-plan", "deploy-checklist",
    ],
    "八、SQL / 数据库": [
        "sql-optimization", "postgresql-optimization", "sql-code-review", "sql-queries",
        "write-query", "sql-database-assistant",
    ],
    "九、安全 / 审计 / 合规": [
        "secret-scanning", "audit-context-building", "audit-prep-assistant",
        "semgrep-rule-creator", "fp-check", "coverage-analysis", "guidelines-advisor",
        "ai-prompt-engineering-safety-review", "ask-questions-if-underspecified",
    ],
    "十、DevOps / 运维 / 可观测性": [
        "cx-incident-management", "cx-alerts", "incident-response", "debug", "debugger",
        "ssh", "logging-best-practices", "review-logging-patterns", "pagespeed-insights",
    ],
    "十一、AI Agent / 评估 / 自动化": [
        "agentic-eval", "agent-evaluation", "skill-creator", "skill-improver",
        "skill-scanner", "autopilot", "deepinit", "ai-slop-cleaner",
        "benchmark-optimization-loop", "parallel-execution-optimizer",
        "data-throughput-accelerator", "product-brainstorming", "knowledge-synthesis",
        "memory-management", "remember", "what-context-needed",
    ],
    "十二、文档 / 技术写作": [
        "documentation-writer", "markdown-to-html", "create-agentsmd",
        "create-architectural-decision-record", "claude-md-improver",
        "update-markdown-file-index",
    ],
    "十三、Blueprint / 项目生成器": [
        "folder-structure-blueprint-generator", "technology-stack-blueprint-generator",
        "code-exemplars-blueprint-generator", "create-web-form",
    ],
    "十四、Context Engineering（上下文工程）": [
        "create-rule", "why", "fix-tests", "do-in-steps", "do-in-parallel",
        "implement-task", "brainstorm", "critique", "root-cause-tracing", "premortem", "kaizen",
    ],
    "十五、云平台 / 企业集成 / 其他": [
        "entra-app-registration", "generating-permission-set", "generating-flexipage",
        "cudaq-guide", "clickup", "cisco-ios-patterns", "ios-icon-gen",
        "optimize-for-gpu", "schema-exploration", "openspec-archiving",
    ],
    "十六、营销 / SEO": ["status-page-generator", "feedback-page-generator"],
    "十七、Git / 脚本 / 通用工具": [
        "git-commit", "zod-schema-validation", "bash-scripting", "file-manager", "pua-trae",
    ],
    "十九、Wave 71 新增技能（2026-06-29 联网搜索）": [
        # 已确认实际安装、元数据已就绪的技能
        "book-to-skill", "extract-design-system", "database-design",
        "slide-deck-skill", "paper2blogpost", "deepweb", "auto-routines",
        "patdown", "the-team", "nib", "kindlepub",
        # Tufte 系列（20+ 子技能，jpoindexter/tufte-skills 仓库拆出）
        "tufte-aesthetics-and-technique", "tufte-analytical-design",
        "tufte-causal-reasoning-in-graphics", "tufte-chartjunk",
        "tufte-color-in-information-design", "tufte-data-density",
        "tufte-data-ink-ratio", "tufte-data-maps", "tufte-escaping-flatland",
        "tufte-evidence-corruption", "tufte-graphical-excellence",
        "tufte-graphical-integrity", "tufte-layering-and-separation",
        "tufte-link-differentiation", "tufte-mapped-pictures",
        "tufte-micro-macro-readings", "tufte-multifunctioning-elements",
        "tufte-narrative-and-sequence", "tufte-redundant-encoding",
        "tufte-small-multiples", "tufte-space-time-graphics",
        "tufte-sparklines", "tufte-typography-for-data", "tufte-visual-thinking",
        # 重命名后的真实技能名
        "hand-drawn", "drawio", "strudel", "loop-engineering",
        # 其他仓库的代表技能（由其 SKILL.md 真实 name 决定）
        "chief-of-staff", "ag-design-skills",
    ],
}


def load_fullstack_manifest() -> list[str]:
    if not FULLSTACK_MANIFEST.exists():
        return []
    return [
        ln.strip()
        for ln in FULLSTACK_MANIFEST.read_text(encoding="utf-8").splitlines()
        if ln.strip() and not ln.startswith("#")
    ]

CATEGORY_INTRO = {
    "一、前端 / UI / 视觉设计": "涵盖 React/Next.js/Expo/React Native 界面设计、动效、认证 UI（Clerk/Auth0）、TypeScript 前端工程与 Cursor 使用技巧。适合产品经理、前端工程师和全栈开发者。",
    "二、后端 / API / 系统架构": "涵盖 NestJS、FastAPI、Fastify、Java、Django、多租户、OAuth、Redis/PostgreSQL/Supabase 等后端技术栈与架构模式。",
    "三、Go 语言专项": "Go 语言官方风格与最佳实践：包设计、并发、错误处理、性能、接口与防御性编程。",
    "四、Rust 语言专项": "Rust 依赖分析、unsafe 审查与 trait 探索工具。",
    "五、测试 / 质量保障 (QA)": "TDD、E2E、API 测试、测试拆解与 Meticulous 精细测试工作流。",
    "六、代码审查 / 重构 / 代码质量": "代码审查、重构计划、技术债清理、Biome 格式化与 GrepAI 代码搜索。",
    "七、规划 / 项目管理 / 需求规格": "PRD、技术规格、功能拆解、执行计划、PR 创建与发布清单。",
    "八、SQL / 数据库": "SQL 优化、PostgreSQL 调优、查询编写与数据库审查。",
    "九、安全 / 审计 / 合规": "密钥扫描、Semgrep 规则、审计准备、Prompt 安全审查。",
    "十、DevOps / 运维 / 可观测性": "事故响应、调试、SSH、日志最佳实践与 PageSpeed 性能分析。",
    "十一、AI Agent / 评估 / 自动化": "Skill 创建/改进、Agent 评估、并行执行优化与知识管理。",
    "十二、文档 / 技术写作": "技术文档、ADR、CLAUDE.md 优化与 Markdown 转换。",
    "十三、Blueprint / 项目生成器": "文件夹结构、技术栈选型与代码范例蓝图生成。",
    "十四、Context Engineering（上下文工程）": "分步/并行执行、头脑风暴、根因追踪、事前尸检与持续改进。",
    "十五、云平台 / 企业集成 / 其他": "Azure Entra、Salesforce、CUDA、ClickUp 等企业级集成。",
    "十六、营销 / SEO": "状态页与反馈页生成（部分技能源仓库已变更）。",
    "十七、Git / 脚本 / 通用工具": "Conventional Commit、Zod 校验、Bash 脚本与文件管理。",
    "十八、全栈扩展技能库（联网补充）": (
        "来自 vaquarkhan/Fullstack-development-agent-skills、Jeffallan/claude-skills、"
        "skills.sh 热门全栈技能。覆盖前后端架构、微服务、云原生、E2E 测试、CI/CD、"
        "身份认证、BFF、GraphQL、WebSocket 等生产级全栈交付工作流。"
    ),
    "十九、Wave 71 新增技能（2026-06-29 联网搜索）": (
        "2026-06-29 通过 GitHub 搜索新发现的技能仓库，覆盖数据可视化（Tufte）、"
        "设计系统提取、数据库设计、安全审计、3D 打印、GTM/销售、论文与课程转化、"
        "代理循环工程、技能质量门禁等方向。"
    ),
}

ALTERNATIVES = {
    "redis-development": ["redis-search", "redis-semantic-cache"],
    "wordpress-plugin-core": ["wordpress-setup"],
    "system-architect": ["bmad-tech-spec"],
    "review-changes": ["review-delta", "review-pr"],
    "explore-codebase": ["review-delta", "review-pr"],
    "review-logging-patterns": ["create-evlog-adapter"],
}

GSD_ZH = {
    "gsd-new-project": ("新建 GSD 项目", "初始化新的 GSD 规划项目，创建路线图与阶段结构。"),
    "gsd-plan-phase": ("规划阶段", "为指定阶段生成详细可执行计划（PLAN.md）。"),
    "gsd-execute-phase": ("执行阶段", "按 PLAN.md 自动执行阶段任务并提交代码。"),
    "gsd-verify-work": ("验证工作", "通过对话式 UAT 验证已构建功能。"),
    "gsd-code-review": ("代码审查", "对阶段代码进行结构化审查并输出 REVIEW.md。"),
    "gsd-debug": ("调试", "启动科学调试会话，管理检查点与根因分析。"),
    "gsd-help": ("帮助", "显示所有 GSD 命令与当前项目状态。"),
    "gsd-update": ("更新 GSD", "更新 GSD 到最新版本并显示变更日志。"),
}


def parse_frontmatter(text: str) -> dict:
    match = re.match(r"^---\s*\n(.*?)\n---", text, re.DOTALL)
    if not match:
        return {}
    raw = match.group(1)
    if yaml:
        try:
            data = yaml.safe_load(raw)
            return data if isinstance(data, dict) else {}
        except Exception:
            pass
    data: dict = {}
    for line in raw.splitlines():
        if ":" in line and not line.startswith(" "):
            key, val = line.split(":", 1)
            data[key.strip()] = val.strip().strip("'\"")
    return data


def load_installed() -> dict:
    installed: dict = {}
    # 扫描多个可能的技能落地位置（npx skills add 实际写入 ~/.agents/skills/，
    # 并在 ~/.claude/skills/ 创建符号链接；~/.cursor/skills/ 为 Cursor）
    candidate_dirs = [
        SKILLS_DIR,
        Path(os.path.expanduser("~/.agents/skills")),
        Path(os.path.expanduser("~/.cursor/skills")),
        HUB_DIR / ".agents" / "skills",
    ]
    seen_dirs: set = set()
    for base in candidate_dirs:
        if not base.exists():
            continue
        real_base = str(base.resolve())
        if real_base in seen_dirs:
            continue
        seen_dirs.add(real_base)
        for folder in base.iterdir():
            if not folder.is_dir() and not folder.is_symlink():
                continue
            md = folder / "SKILL.md"
            if not md.exists():
                continue
            try:
                fm = parse_frontmatter(md.read_text(encoding="utf-8", errors="replace"))
            except (OSError, PermissionError):
                continue
            name = str(fm.get("name", folder.name))
            desc = fm.get("description", "")
            if isinstance(desc, str):
                desc = re.sub(r"\s+", " ", desc).strip()
            installed[name] = {
                "desc": desc,
                "invocable": bool(fm.get("user-invocable", False)),
            }
    return installed


def render_skill(name: str, installed: dict, indent: str = "") -> list[str]:
    lines: list[str] = []
    zh = SKILL_ZH.get(name, {})
    is_installed = name in installed
    invocable = installed.get(name, {}).get("invocable", False) if is_installed else False

    if is_installed:
        status = "✅ 已安装"
        invoke = "🔹 支持斜杠命令 `/{}`".format(name) if invocable else "💬 自然语言触发（描述需求即可，或点名技能名）"
    else:
        status = "❌ 未安装"
        invoke = "⚠️ 源仓库中该技能已移除或无效，无法使用"

    title = zh.get("title", name)
    lines.append(f"{indent}### `/{name}` — {title}")
    lines.append(f"{indent}")
    lines.append(f"{indent}**安装状态**：{status}")
    lines.append(f"{indent}**调用方式**：{invoke}")
    lines.append(f"{indent}")

    if zh.get("summary"):
        lines.append(f"{indent}**功能说明**")
        lines.append(f"{indent}{zh['summary']}")
        lines.append(f"{indent}")
    elif is_installed and installed[name].get("desc"):
        lines.append(f"{indent}**功能说明**")
        lines.append(f"{indent}{installed[name]['desc']}")
        lines.append(f"{indent}")

    if zh.get("when"):
        lines.append(f"{indent}**适用场景**")
        for line in zh["when"].strip().split("\n"):
            lines.append(f"{indent}{line}")
        lines.append(f"{indent}")

    if zh.get("example"):
        lines.append(f"{indent}**调用示例**（复制到 Claude Code 输入框）")
        lines.append(f"{indent}> {zh['example']}")
        lines.append(f"{indent}")

    if invocable:
        lines.append(f"{indent}**斜杠命令**")
        lines.append(f"{indent}```")
        lines.append(f"{indent}/{name}")
        lines.append(f"{indent}```")
        lines.append(f"{indent}")

    lines.append(f"{indent}---")
    lines.append(f"{indent}")
    return lines


def main() -> None:
    installed = load_installed()
    invocable = sorted(n for n, s in installed.items() if s["invocable"])
    gsd_cmds = sorted(n for n in installed if n.startswith("gsd-"))
    installed_req = sum(1 for n in REQUESTED if n in installed)

    lines: list[str] = [
        "# Claude Code 全局技能使用手册（中文详细版）",
        "",
        f"> **文档路径**：`{OUTPUT}`",
        f"> **技能目录**：`~/.claude/skills/`（Claude Code）｜`~/.cursor/skills/`（Cursor）",
        f"> **全局技能总数**：**{len(installed)}** 个 ｜ **本手册已收录**：**{len(installed)}** 个（全部已安装）",
        f"> **最后更新**：运行 `python ~/Agent-Skills-Hub/scripts/generate-skills-reference-zh.py` 可重新生成",
        "",
        "---",
        "",
        "## 目录",
        "",
        "1. [什么是 Skill？如何调用？](#一什么是-skill如何调用)",
        "2. [终端管理命令](#二终端管理命令)",
        "3. [按分类技能详解](#三按分类技能详解本次安装的-226-个技能)",
        "4. [斜杠命令速查表](#四斜杠命令速查表可直接输入)",
        "5. [GSD 工作流命令](#五gsd-工作流命令gsd-系列)",
        "6. [不可用技能与替代方案](#六不可用技能与替代方案)",
        "7. [常见问题 FAQ](#七常见问题-faq)",
        "",
        "---",
        "",
        "## 一、什么是 Skill？如何调用？",
        "",
        "### 1.1 Skill 是什么？",
        "",
        "**Skill（技能）** 是给 Claude 看的**专项操作手册**，通常是一个文件夹，里面包含 `SKILL.md` 文件。",
        "它告诉 Claude：",
        "",
        "- **什么时候**应该启用这个技能（根据你的描述自动匹配）",
        "- **怎么做**（具体工作流程、检查清单、最佳实践）",
        "- **注意什么**（约束、格式、安全要求）",
        "",
        "你可以把它理解为：给 AI 准备的「岗位 SOP / 操作规范」。",
        "",
        "### 1.2 三种调用方式（由易到难）",
        "",
        "#### 方式 A：自然语言描述（最常用，推荐）",
        "",
        "直接说出你想做什么，Claude 会根据技能 `description` 自动加载匹配的技能。",
        "",
        "```text",
        "帮我用 conventional commit 规范提交当前代码",
        "```",
        "",
        "→ Claude 会自动匹配并加载 `git-commit` 技能。",
        "",
        "#### 方式 B：点名指定技能（强制走某技能流程）",
        "",
        "```text",
        "使用 frontend-design 技能，为我的 B2B SaaS 产品设计深色主题登录页",
        "```",
        "",
        "→ 明确指定技能名，确保走该技能的完整工作流。",
        "",
        "#### 方式 C：斜杠命令（部分技能支持）",
        "",
        "在 Claude Code 输入框输入 `/`，会弹出可自动补全的命令列表。",
        "只有标记了 `user-invocable: true` 的技能才支持这种方式。",
        "",
        "```text",
        "/git-commit",
        "```",
        "",
        "→ 直接触发 `git-commit` 技能，无需额外描述。",
        "",
        "### 1.3 技能文件存放在哪里？",
        "",
        "| IDE / 工具 | 全局技能路径 | 说明 |",
        "|------------|-------------|------|",
        "| **Claude Code** | `~/.claude/skills/<技能名>/SKILL.md` | 本手册主要面向此环境 |",
        "| **Cursor** | `~/.cursor/skills/<技能名>/SKILL.md` | Cursor Agent 自动发现 |",
        "| **通用规范** | `~/.agents/skills/<技能名>/SKILL.md` | Agent Skills 开放标准 |",
        "",
        "安装时使用了 `-g -a '*'` 参数，因此技能会**全局安装**并**同步到所有支持的 IDE**。",
        "",
        "### 1.4 如何确认技能已加载？",
        "",
        "在 Claude Code 中，你可以：",
        "",
        "1. 输入 `/` 查看斜杠命令列表（部分技能可见）",
        "2. 说「列出当前可用的技能」或「读取 SKILLS-REFERENCE-CN.md」",
        "3. 在终端运行 `npx skills ls -g` 查看本机已安装技能",
        "",
        "### 1.5 图例说明",
        "",
        "| 标记 | 含义 |",
        "|------|------|",
        "| ✅ 已安装 | 技能已成功安装到本机，可直接使用 |",
        "| ❌ 未安装 | 源 GitHub 仓库中技能已移除或 SKILL.md 无效 |",
        "| 🔄 替代方案 | 原技能不可用，文档中提供了功能相近的替代技能 |",
        "| 🔹 斜杠命令 | 支持 `/技能名` 直接在输入框调用 |",
        "| 💬 自然语言 | 通过描述需求或点名技能名触发 |",
        "",
        "---",
        "",
        "## 二、终端管理命令",
        "",
        "以下命令在 **PowerShell / CMD / Git Bash** 终端中运行，用于管理全局技能。",
        "每条命令下方附有中文说明。",
        "",
        "### 查看已安装技能",
        "",
        "```bash",
        "npx skills ls -g",
        "```",
        "列出本机所有全局已安装的技能名称与来源。",
        "",
        "```bash",
        "npx skills ls -g --json",
        "```",
        "以 JSON 格式输出，便于脚本处理或统计数量。",
        "",
        "### 安装新技能",
        "",
        "```bash",
        "npx skills add <GitHub仓库> --skill <技能名> -g -a \"*\" -y",
        "```",
        "",
        "参数说明：",
        "- `-g`：全局安装（用户级，所有项目可用）",
        "- `-a \"*\"`：安装到所有支持的 Agent/IDE（Claude Code、Cursor、Codex 等）",
        "- `-y`：跳过确认提示，非交互安装",
        "- `--skill <技能名>`：只安装仓库中的指定技能（可多次使用）",
        "",
        "示例：",
        "```bash",
        "npx skills add https://github.com/anthropics/skills --skill frontend-design -g -a \"*\" -y",
        "```",
        "",
        "### 更新技能",
        "",
        "```bash",
        "npx skills update -g",
        "```",
        "将所有全局技能更新到源仓库最新版本。",
        "",
        "### 卸载技能",
        "",
        "```bash",
        "npx skills remove <技能名> -g -y",
        "```",
        "从全局范围卸载指定技能。",
        "",
        "### 重新生成本手册",
        "",
        "```bash",
        "python ~/Agent-Skills-Hub/scripts/generate-skills-reference-zh.py",
        "```",
        "根据本机已安装技能重新生成 `Agent-Skills-Hub/docs/SKILLS-REFERENCE-CN.md` 中文详细手册。",
        "",
        "---",
        "",
        "## 三、按分类技能详解（本次安装的 226 个技能）",
        "",
        "> 每个技能包含：**命令名**、**安装状态**、**调用方式**、**功能说明**、**适用场景**、**调用示例**。",
        "",
    ]

    assigned: set[str] = set()
    fullstack_extra = load_fullstack_manifest()
    if fullstack_extra:
        CATEGORIES["十八、全栈扩展技能库（联网补充）"] = fullstack_extra

    for cat, names in CATEGORIES.items():
        is_fullstack_cat = cat.startswith("十八")
        relevant = [
            n for n in names
            if n in REQUESTED or (is_fullstack_cat and (n in installed or n in SKILL_ZH))
        ]
        if not relevant:
            continue
        lines.append(f"### {cat}")
        lines.append("")
        lines.append(CATEGORY_INTRO.get(cat, ""))
        lines.append("")
        for name in names:
            if not is_fullstack_cat and name not in REQUESTED:
                continue
            if is_fullstack_cat and name not in installed and name not in SKILL_ZH:
                continue
            assigned.add(name)
            if name in installed:
                lines.extend(render_skill(name, installed))
            elif name in ALTERNATIVES:
                lines.append(f"### `/{name}` — {SKILL_ZH.get(name, {}).get('title', name)}")
                lines.append("")
                lines.append("**安装状态**：🔄 原技能不可用，已提供替代方案")
                lines.append("")
                if SKILL_ZH.get(name, {}).get("summary"):
                    lines.append("**原技能说明**")
                    lines.append(SKILL_ZH[name]["summary"])
                    lines.append("")
                lines.append("**请改用以下替代技能：**")
                lines.append("")
                for alt in ALTERNATIVES[name]:
                    if alt in installed or alt in SKILL_ZH:
                        lines.extend(render_skill(alt, installed, indent=""))
                lines.append("---")
                lines.append("")
            else:
                lines.extend(render_skill(name, installed))
        lines.append("")

    uncat = [n for n in REQUESTED if n not in assigned]
    if uncat:
        lines += ["### 其他技能", ""]
        for name in uncat:
            lines.extend(render_skill(name, installed))
        lines.append("")

    # Wave 71 全量已安装技能索引（紧凑表格，覆盖所有未被分类的已安装技能）
    all_installed = set(installed.keys())
    indexed = assigned | set(REQUESTED)
    extra = sorted(n for n in all_installed if n not in indexed)
    if extra:
        lines += [
            "### 十九·补、Wave 71 全量已安装技能索引（按字母排序）",
            "",
            f"> 以下 **{len(extra)}** 个技能均通过 `npx skills add` 成功安装到项目级 `.agents/skills/`，",
            "> 可在 Claude Code 中通过自然语言触发或点名技能名调用。仅展示**已安装**技能。",
            "",
            "| 技能名 | 中文说明（摘要） |",
            "|--------|------------------|",
        ]
        for name in extra:
            zh = SKILL_ZH.get(name, {})
            title = zh.get("title", name.replace("-", " ").title())
            summ = zh.get("summary", installed[name].get("desc", "")[:80])
            if len(summ) > 90:
                summ = summ[:88] + "…"
            summ = summ.replace("|", "／").replace("\n", " ")
            lines.append(f"| `/{name}` | **{title}** — {summ} |")
        lines.append("")

    lines += [
        "---",
        "",
        "## 四、斜杠命令速查表（可直接输入）",
        "",
        f"> 共 **{len(invocable)}** 个技能支持 `/技能名` 斜杠直接调用。在 Claude Code 输入框键入 `/` 可自动补全。",
        "",
        "| 斜杠命令 | 中文说明 |",
        "|----------|----------|",
    ]
    for name in invocable:
        zh = SKILL_ZH.get(name, {})
        title = zh.get("title", name)
        summary = zh.get("summary", installed[name]["desc"][:80] + "…" if len(installed[name]["desc"]) > 80 else installed[name]["desc"])
        short = summary.split("。")[0] + "。" if summary else title
        lines.append(f"| `/{name}` | {short} |")

    lines += [
        "",
        "---",
        "",
        "## 五、GSD 工作流命令（/gsd-* 系列）",
        "",
        "**GSD（Get Shit Done）** 是一套结构化项目规划与执行工作流。",
        "在 Claude Code 中输入 `/gsd-` 可看到完整命令列表。",
        "",
        "| 斜杠命令 | 中文名称 | 功能说明 |",
        "|----------|----------|----------|",
    ]
    for name in gsd_cmds:
        zh_title, zh_desc = GSD_ZH.get(name, (name, installed[name]["desc"][:100]))
        lines.append(f"| `/{name}` | {zh_title} | {zh_desc} |")

    lines += [
        "",
        "常用 GSD 工作流：",
        "",
        "```text",
        "/gsd-new-project     → 新建项目与路线图",
        "/gsd-plan-phase      → 规划某个阶段的详细计划",
        "/gsd-execute-phase   → 自动执行阶段任务",
        "/gsd-code-review     → 审查已完成的代码",
        "/gsd-verify-work     → 对话式验收测试",
        "/gsd-debug           → 启动调试会话",
        "/gsd-help            → 查看帮助与项目状态",
        "```",
        "",
        "---",
        "",
        "## 六、不可用技能与替代方案",
        "",
        "以下技能在源 GitHub 仓库中已移除或改名，无法安装。请使用替代技能：",
        "",
        "| 原技能 | 状态 | 推荐替代 | 说明 |",
        "|--------|------|----------|------|",
        "| `/next-cache-components` | ❌ | 无 | vercel-labs/next-skills 仓库无有效 SKILL.md |",
        "| `/vercel-react-best-practices` | ✅ 已装 | — | 部分环境已从仓库移除，本机已安装可继续使用 |",
        "| `/polyglot-test-agent` | ❌ | `breakdown-test` | awesome-copilot 中已不存在 |",
        "| `/create-web-form` | ❌ | 无 | awesome-copilot 中已不存在 |",
        "| `/web-coder` | ❌ | `premium-frontend-ui` | awesome-copilot 中已不存在 |",
        "| `/redis-development` | ❌ | `/redis-search` `/redis-semantic-cache` | Redis 技能已拆分 |",
        "| `/wordpress-plugin-core` | ❌ | `/wordpress-setup` | jezweb 仓库已改名 |",
        "| `/system-architect` | ❌ | `/bmad-tech-spec` | BMAD 技能系列替代 |",
        "| `/review-changes` | ❌ | `/review-delta` `/review-pr` | code-review-graph 已改名 |",
        "| `/explore-codebase` | ❌ | `/review-delta` | code-review-graph 已改名 |",
        "| `/review-logging-patterns` | ❌ | `/create-evlog-adapter` | evlog 仓库结构变更 |",
        "| `/status-page-generator` | ❌ | 无 | marketing-skills 已重构为 SEO 类 |",
        "| `/feedback-page-generator` | ❌ | 无 | marketing-skills 已重构为 SEO 类 |",
        "| `/nodejs-backend-typescript` | ❌ | `nodejs` 相关技能 | claude-mpm-skills 中已移除 |",
        "| `/code-refactoring` | ❌ | `refactor` `code-refactoring-tech-debt` | skillcreatorai 仓库变更 |",
        "| `/v3-performance-optimization` | ❌ | 无 | ruvnet/ruflo 仓库变更 |",
        "| `/v3-ddd-architecture` | ❌ | `domain-driven-design` | ruvnet/ruflo 仓库变更 |",
        "| `/pair-programming` | ❌ | 无 | ruvnet/ruflo 仓库变更 |",
        "",
        "---",
        "",
        "## 七、常见问题 FAQ",
        "",
        "### Q1：输入 `/` 看不到某个技能？",
        "",
        "大部分技能是**自然语言触发**，不支持斜杠命令。只有 `user-invocable: true` 的技能才会出现在 `/` 列表中。",
        "你可以直接说「使用 xxx 技能」或描述你的需求。",
        "",
        "### Q2：技能安装后 Claude Code 没反应？",
        "",
        "1. **重启 Claude Code**（关闭后重新打开）",
        "2. 确认技能存在：`npx skills ls -g | findstr <技能名>`",
        "3. 明确点名：「请读取 ~/.claude/skills/<技能名>/SKILL.md 并按其流程执行」",
        "",
        "### Q3：如何在 Cursor 中使用这些技能？",
        "",
        "技能已同步到 `~/.cursor/skills/`。在 Cursor Agent 对话中同样可以通过自然语言或点名技能使用。",
        "",
        "### Q4：如何更新所有技能到最新版？",
        "",
        "```bash",
        "npx skills update -g",
        "python ~/Agent-Skills-Hub/scripts/generate-skills-reference-zh.py",
        "```",
        "",
        "### Q5：如何在本对话中快速查阅本手册？",
        "",
        "```text",
        "读取 ~/Agent-Skills-Hub/docs/SKILLS-REFERENCE-CN.md，我想做 [描述你的任务]",
        "```",
        "",
        "或：",
        "",
        "```text",
        "根据 SKILLS-REFERENCE-CN.md，推荐适合 [任务描述] 的技能",
        "```",
        "",
        "---",
        "",
        f"*本手册由 `Agent-Skills-Hub/scripts/generate-skills-reference-zh.py` + `data/skills_zh_data.py` 自动生成。*",
        f"*全局技能 {len(installed)} 个 ｜ 本次请求安装 {installed_req}/{len(REQUESTED)} 个 ｜ 斜杠命令 {len(invocable)} 个*",
    ]

    OUTPUT.write_text("\n".join(lines), encoding="utf-8")
    claude_copy = Path(os.path.expanduser("~/.claude/SKILLS-REFERENCE-CN.md"))
    claude_copy.write_text("\n".join(lines), encoding="utf-8")
    print(f"已生成: {OUTPUT}")
    print(f"已同步: {claude_copy}")
    print(f"总行数: {len(lines)}")
    print(f"本次安装: {installed_req}/{len(REQUESTED)}")


if __name__ == "__main__":
    main()
