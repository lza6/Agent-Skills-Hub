#!/usr/bin/env python3
"""Generate SKILLS-REFERENCE.md from installed Claude Code skills."""
import os
import re
from pathlib import Path

try:
    import yaml
except ImportError:
    yaml = None

SKILLS_DIR = Path(os.path.expanduser("~/.claude/skills"))
HUB_DIR = Path(__file__).resolve().parent.parent
OUTPUT = HUB_DIR / "docs" / "SKILLS-REFERENCE.md"

REQUESTED = """
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
""".split()

CATEGORIES = {
    "前端 / UI / 设计": [
        "frontend-design", "brand-guidelines", "building-native-ui", "motion-design",
        "premium-frontend-ui", "assistant-ui", "thread-list", "react-native-testing",
        "compose-ui-testing-patterns", "no-use-effect", "mastering-typescript",
        "cursor-best-practices", "web-artifacts-builder", "argent-react-native-optimization",
        "clerk-custom-ui", "clerk-orgs", "auth0-vue", "react-router-framework-mode",
        "tanstack-config", "nextjs", "next-cache-components", "vercel-react-best-practices",
    ],
    "后端 / API / 架构": [
        "backend-development", "backend-development-feature-development", "backend-dev-guidelines",
        "backend-security-coder", "fastapi-pro", "fastify-typescript", "nestjs-expert",
        "docker-expert", "docker-containerization", "multi-stage-dockerfile",
        "multi-tenant-architecture", "system-design", "system-architect",
        "software-architecture-design", "architecture-patterns", "database-architect",
        "domain-driven-design", "django-celery-expert", "rust-backend",
        "nodejs-backend-typescript", "java", "flask-python", "lua", "oauth",
        "redis-development", "postgres", "postgresql", "supabase", "rabbitmq-development",
    ],
    "Go 语言": [
        "go-control-flow", "go-packages", "go-functional-options", "go-defensive",
        "go-data-structures", "go-context", "go-interfaces", "go-style-core",
        "go-concurrency", "go-performance", "go-error-handling", "go-naming",
        "go-documentation", "go-linting",
    ],
    "Rust 语言": ["rust-deps-visualizer", "unsafe-checker", "rust-trait-explorer"],
    "测试 / QA": [
        "test-driven-development", "test-automator", "test-anti-patterns", "test-specialist",
        "python-testing", "api-testing", "api-test-suite-builder", "api-contract-testing",
        "e2e-testing-automation", "breakdown-test", "polyglot-test-agent", "meticulous-review",
        "meticulous-iterative-dev", "meticulous-test", "critical-code-reviewer",
    ],
    "代码审查 / 重构 / 质量": [
        "code-review", "code-reviewer", "code-simplifier", "code-refactoring",
        "code-refactoring-tech-debt", "refactor", "refactor-plan",
        "refactor-method-complexity-reduce", "codebase-cleanup-refactor-clean",
        "clean-code", "clean-code-principles", "cc-skill-coding-standards",
        "python-code-review", "python-code-quality", "python-pro", "biome",
        "review-changes", "review-delta", "review-pr", "explore-codebase",
        "grepai-search-tips", "grepai-trace-graph",
    ],
    "规划 / 项目管理 / 规格": [
        "prd", "create-specification", "update-specification", "write-spec",
        "technical-specification", "breakdown-feature-implementation", "breakdown-epic-pm",
        "executing-plans", "writing-plans", "plan", "plan-writing", "plan-review",
        "plan-task", "structured-autonomy-plan", "structured-autonomy-implement",
        "long-task-coordinator", "create-pr", "devops-rollout-plan", "deploy-checklist",
    ],
    "SQL / 数据库": [
        "sql-optimization", "postgresql-optimization", "sql-code-review", "sql-queries",
        "write-query", "sql-database-assistant",
    ],
    "安全 / 审计": [
        "secret-scanning", "audit-context-building", "audit-prep-assistant",
        "semgrep-rule-creator", "fp-check", "coverage-analysis", "guidelines-advisor",
        "ai-prompt-engineering-safety-review", "ask-questions-if-underspecified",
    ],
    "DevOps / 运维": [
        "cx-incident-management", "cx-alerts", "incident-response", "debug", "debugger",
        "ssh", "logging-best-practices", "review-logging-patterns", "pagespeed-insights",
    ],
    "AI / Agent / 评估": [
        "agentic-eval", "agent-evaluation", "skill-creator", "skill-improver",
        "skill-scanner", "autopilot", "deepinit", "ai-slop-cleaner",
        "benchmark-optimization-loop", "parallel-execution-optimizer",
        "data-throughput-accelerator", "product-brainstorming", "knowledge-synthesis",
        "memory-management", "remember", "what-context-needed",
    ],
    "文档 / 写作": [
        "documentation-writer", "markdown-to-html", "create-agentsmd",
        "create-architectural-decision-record", "claude-md-improver",
        "update-markdown-file-index",
    ],
    "Blueprint / 生成器": [
        "folder-structure-blueprint-generator", "technology-stack-blueprint-generator",
        "code-exemplars-blueprint-generator", "create-web-form",
    ],
    "Context Engineering": [
        "create-rule", "why", "fix-tests", "do-in-steps", "do-in-parallel",
        "implement-task", "brainstorm", "critique", "root-cause-tracing", "premortem", "kaizen",
    ],
    "Salesforce / Azure / 其他": [
        "entra-app-registration", "generating-permission-set", "generating-flexipage",
        "cudaq-guide", "clickup", "cisco-ios-patterns", "ios-icon-gen",
        "optimize-for-gpu", "schema-exploration", "openspec-archiving",
    ],
    "营销 / SEO": ["status-page-generator", "feedback-page-generator"],
    "Git / 工具": ["git-commit", "zod-schema-validation", "bash-scripting", "file-manager", "pua-trae"],
}

ALTERNATIVES = {
    "redis-development": ["redis-search", "redis-semantic-cache", "redis-observability"],
    "wordpress-plugin-core": ["wordpress-setup", "wordpress-content"],
    "system-architect": ["bmad-tech-spec", "bmad-spec", "bmad-sprint-planning"],
    "review-changes": ["review-delta", "review-pr"],
    "explore-codebase": ["review-delta", "review-pr"],
    "review-logging-patterns": ["create-evlog-adapter", "create-evlog-enricher"],
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
    data = {}
    for line in raw.splitlines():
        if ":" in line and not line.startswith(" "):
            key, val = line.split(":", 1)
            data[key.strip()] = val.strip().strip("'\"")
    return data


def load_skills() -> dict:
    skills = {}
    hub_dir = Path(__file__).resolve().parent.parent
    candidate_dirs = [
        SKILLS_DIR,
        Path(os.path.expanduser("~/.agents/skills")),
        Path(os.path.expanduser("~/.cursor/skills")),
        hub_dir / ".agents" / "skills",
    ]
    seen: set = set()
    for base in candidate_dirs:
        if not base.exists():
            continue
        real_base = str(base.resolve())
        if real_base in seen:
            continue
        seen.add(real_base)
        for folder in sorted(base.iterdir()):
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
            else:
                desc = str(desc)
            invocable = bool(fm.get("user-invocable", False))
            skills[name] = {"desc": desc, "invocable": invocable}
    return skills


def skill_block(name: str, skills: dict, prefix: str = "") -> list:
    lines = []
    if name in skills:
        s = skills[name]
        tag = "🔹斜杠" if s["invocable"] else "💬自动"
        lines.append(f"{prefix}#### `/{name}` ✅ {tag}")
        lines.append(f"{prefix}{s['desc'] or '（无描述）'}")
        lines.append("")
        return lines
    if name in ALTERNATIVES:
        alts = [a for a in ALTERNATIVES[name] if a in skills]
        if alts:
            lines.append(f"{prefix}#### `/{name}` 🔄 已替换为以下技能")
            lines.append(f"{prefix}原命令 `/{name}` 在源仓库已不可用，请改用：")
            lines.append("")
            for alt in alts:
                lines.extend(skill_block(alt, skills, prefix + "  "))
            return lines
    lines.append(f"{prefix}#### `/{name}` ❌ 不可用")
    lines.append(f"{prefix}源仓库中技能已移除或 SKILL.md 无效，无法安装。")
    lines.append("")
    return lines


def main():
    skills = load_skills()
    requested = list(dict.fromkeys(REQUESTED))
    invocable = sorted(n for n, s in skills.items() if s["invocable"])
    gsd = sorted(n for n in skills if n.startswith("gsd-"))
    installed_req = sum(1 for n in requested if n in skills)

    lines: list[str] = []
    lines += [
        "# Claude Code 全局技能总览手册",
        "",
        f"> 本机路径：`{OUTPUT}` ｜ 技能目录：`~/.claude/skills/` ｜ 共 **{len(skills)}** 个全局技能",
        "",
        "---",
        "",
        "## 一、快速上手",
        "",
        "### 技能是什么？",
        "",
        "技能（Skill）是给 Claude 的**专项操作手册**，包含工作流程、最佳实践和约束。",
        "Claude 会根据你的描述自动匹配；部分技能也支持 **`/技能名`** 斜杠命令直接调用。",
        "",
        "### 三种调用方式",
        "",
        "| 方式 | 示例 | 说明 |",
        "|------|------|------|",
        "| **斜杠命令** | `/git-commit` | 输入 `/` 后自动补全；仅 `user-invocable: true` 的技能支持 |",
        "| **自然语言** | 「帮我做 conventional commit」 | Claude 根据 description 自动加载匹配技能 |",
        "| **点名技能** | 「使用 frontend-design 技能设计登录页」 | 明确指定技能名，强制走该技能流程 |",
        "",
        "### 技能存放路径",
        "",
        "```text",
        "~/.claude/skills/<技能名>/SKILL.md    ← Claude Code",
        "~/.cursor/skills/<技能名>/SKILL.md     ← Cursor",
        "~/.agents/skills/<技能名>/SKILL.md     ← Agent Skills 通用规范",
        "```",
        "",
        "### 终端管理命令",
        "",
        "```bash",
        "npx skills ls -g",
        "  # 列出所有全局已安装技能",
        "",
        "npx skills ls -g --json",
        "  # JSON 格式，便于脚本处理",
        "",
        'npx skills add <owner/repo> --skill <name> -g -a "*" -y',
        "  # 全局安装到 Claude Code / Cursor 等所有 Agent",
        "",
        "npx skills update -g",
        "  # 更新全部全局技能到最新版",
        "",
        "npx skills remove <name> -g -y",
        "  # 卸载指定全局技能",
        "```",
        "",
        "### 图例",
        "",
        "| 标记 | 含义 |",
        "|------|------|",
        "| ✅ | 已安装，可直接使用 |",
        "| ❌ | 未安装（源仓库已移除） |",
        "| 🔄 | 原技能不可用，已提供替代技能 |",
        "| 🔹斜杠 | 支持 `/技能名` 直接调用 |",
        "| 💬自动 | 通过自然语言描述自动触发 |",
        "",
        "---",
        "",
        "## 二、本次安装技能速查（按分类）",
        "",
        "> 每个技能两行：**命令** + **说明**",
        "",
    ]

    assigned = set()
    for cat, names in CATEGORIES.items():
        cat_names = [n for n in names if n in requested or n in skills]
        if not cat_names:
            continue
        lines.append(f"### {cat}")
        lines.append("")
        for name in names:
            if name not in requested and name not in skills:
                continue
            assigned.add(name)
            lines.extend(skill_block(name, skills))
        lines += ["---", ""]

    uncat = [n for n in requested if n not in assigned]
    if uncat:
        lines += ["### 其他已请求技能", ""]
        for name in uncat:
            lines.extend(skill_block(name, skills))
        lines += ["---", ""]

    # Wave 71 全量已安装技能索引（英文版紧凑表格）
    all_installed = set(skills.keys())
    indexed = assigned | set(requested)
    extra = sorted(n for n in all_installed if n not in indexed)
    if extra:
        lines += [
            "### Wave 71 全量已安装技能索引（按字母排序）",
            "",
            f"> 以下 **{len(extra)}** 个技能均通过 `npx skills add` 成功安装到项目级 `.agents/skills/`。",
            "> 仅展示**已安装**技能，未安装的不收录。",
            "",
            "| Skill | Description |",
            "|-------|-------------|",
        ]
        for name in extra:
            desc = skills[name]["desc"]
            if len(desc) > 100:
                desc = desc[:98] + "…"
            desc = desc.replace("|", "／").replace("\n", " ")
            lines.append(f"| `/{name}` | {desc} |")
        lines += ["---", ""]

    lines += [
        "## 三、斜杠可直接调用的技能（user-invocable）",
        "",
        "> 在 Claude Code 输入框键入 `/` 可看到这些命令。",
        "",
    ]
    for name in invocable[:100]:
        desc = skills[name]["desc"]
        short = desc[:180] + "…" if len(desc) > 180 else desc
        lines.append(f"- `/{name}`")
        lines.append(f"  {short}")
        lines.append("")
    if len(invocable) > 100:
        lines.append(f"*…另有 {len(invocable) - 100} 个，运行 `npx skills ls -g` 查看完整列表*")
        lines.append("")

    lines += ["---", "", "## 四、GSD 工作流命令（/gsd-* 系列）", ""]
    for name in gsd:
        lines.append(f"- `/{name}`")
        lines.append(f"  {skills[name]['desc']}")
        lines.append("")

    lines += [
        "---",
        "",
        "## 五、安装统计",
        "",
        f"- 本次请求技能（去重）：**{len(requested)}** 个",
        f"- 已成功安装：**{installed_req}** 个",
        f"- 全局技能总数：**{len(skills)}** 个",
        f"- 支持斜杠调用：**{len(invocable)}** 个",
        "",
        "---",
        "",
        "## 六、在 Claude Code 中如何使用本手册",
        "",
        "1. 直接说：**「读取 ~/Agent-Skills-Hub/docs/SKILLS-REFERENCE.md，我想做 XXX」**",
        "2. 或说：**「使用 /git-commit 技能帮我提交代码」**",
        "3. 不确定用哪个技能时：**「根据 SKILLS-REFERENCE.md 推荐合适的技能」**",
        "",
        "*文档由 `Agent-Skills-Hub/scripts/generate-skills-reference.py` 自动生成，安装新技能后可重新运行该脚本更新。*",
    ]

    OUTPUT.write_text("\n".join(lines), encoding="utf-8")
    print(f"Written: {OUTPUT}")
    print(f"Lines: {len(lines)}")
    print(f"Requested installed: {installed_req}/{len(requested)}")
    print(f"Invocable: {len(invocable)}")


if __name__ == "__main__":
    main()
