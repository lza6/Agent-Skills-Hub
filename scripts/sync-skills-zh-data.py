#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""为已安装但 skills_zh_data.py 中缺失的技能自动生成中文元数据 stub。"""
from __future__ import annotations

import os
import re
from pathlib import Path

HUB_DIR = Path(__file__).resolve().parent.parent
DATA_FILE = HUB_DIR / "data" / "skills_zh_data.py"
SKILLS_DIR = Path(os.path.expanduser("~/.claude/skills"))

FULLSTACK_MANIFEST = HUB_DIR / "data" / "fullstack-skills-manifest.txt"


def load_manifest() -> set[str]:
    if not FULLSTACK_MANIFEST.exists():
        return set()
    return {
        ln.strip()
        for ln in FULLSTACK_MANIFEST.read_text(encoding="utf-8").splitlines()
        if ln.strip() and not ln.startswith("#")
    }

FULLSTACK_SKILLS = set("""
using-fullstack-agent-skills fullstack-product-specification fullstack-testing-and-quality-gates
fullstack-observability-and-release-engineering cloud-fullstack-development
react-nextjs-frontend-architecture backend-microservices-architecture authentication-and-authorization-fullstack
api-contract-first-development postgres-and-relational-data-modeling redis-caching-and-session-store-patterns
bff-architecture-and-api-aggregation e2e-testing-playwright-cypress cicd-gitops-and-progressive-deployment
terraform-fullstack-infrastructure-as-code ui-engineering-and-design-systems vercel-edge-and-jamstack-delivery
fullstack-guardian nestjs-expert nextjs-developer react-expert react-native-expert typescript-pro vue-expert
fastapi-expert django-expert spring-boot-engineer golang-pro graphql-architect microservices-architect
api-designer architecture-designer cloud-architect database-optimizer postgres-pro sql-pro devops-engineer
kubernetes-specialist terraform-engineer websocket-engineer secure-code-guardian security-reviewer test-master
playwright-expert code-reviewer debugging-wizard javascript-pro vercel-react-native-skills web-design-guidelines
fullstack-developer fullstack-dev senior-fullstack full-stack-development
""".split())


def parse_frontmatter(text: str) -> dict:
    m = re.match(r"^---\s*\n(.*?)\n---", text, re.DOTALL)
    if not m:
        return {}
    data = {}
    for line in m.group(1).splitlines():
        if line.startswith("description:"):
            data["description"] = line.split(":", 1)[1].strip().strip("'\"")
        elif line.startswith("name:"):
            data["name"] = line.split(":", 1)[1].strip().strip("'\"")
    return data


def slug_to_title(slug: str) -> str:
    return slug.replace("-", " ").title()


def should_sync(name: str, manifest: set[str]) -> bool:
    if name in manifest or name in FULLSTACK_SKILLS:
        return True
    if "fullstack" in name or "full-stack" in name:
        return True
    prefixes = (
        "react-nextjs", "backend-micro", "authentication-and", "api-contract",
        "postgres-and", "redis-caching", "bff-", "e2e-testing", "cicd-",
        "terraform-fullstack", "ui-engineering", "vercel-edge", "using-fullstack",
        "cloud-fullstack", "fullstack-", "java-spring-boot", "dotnet-aspnet",
        "aws-serverless", "azure-serverless", "gcp-serverless", "realtime-ui",
        "performance-and-load", "nestjs-", "nextjs-", "vue-expert", "spring-boot-",
        "graphql-", "microservices-", "websocket-", "senior-fullstack",
        "vercel-react-native", "web-design-guidelines", "playwright-expert",
        "ai-llm-integration", "angular-enterprise", "api-gateway", "autoscaling-",
        "aws-cognito", "chaos-engineering", "compliance-gdpr", "cqrs-and",
        "database-migrations", "design-system", "distributed-", "domain-driven-",
        "email-and", "feature-flags", "file-storage", "frontend-", "graphql-client",
        "incident-triage", "internationalization", "interservice-", "kafka-event",
        "mobile-backend", "observability-", "okta-identity", "payments-and",
        "react-native-fullstack", "search-and", "secrets-vault", "serverless-",
    )
    return any(name.startswith(p) for p in prefixes)


def make_stub(name: str, desc: str) -> dict:
    title = slug_to_title(name)
    short = (desc[:200] + "…") if len(desc) > 200 else desc
    tag = "【全栈扩展】" if name in FULLSTACK_SKILLS or "fullstack" in name or "full-stack" in name else ""
    summary = (
        f"{tag}本技能为 AI Agent 提供「{title}」领域的专项工作流与最佳实践。"
        f"它会指导 Claude 在相关任务中遵循行业标准步骤、质量门禁与常见陷阱规避。"
    )
    if short and not short.startswith("Use when"):
        summary += f" 核心能力：{short}"
    elif short:
        summary += f" 触发说明：{short[:180]}"

    when_lines = [
        "- 任务涉及该技能名称所描述的技术域或工作流",
        "- 需要结构化、可重复的全栈/工程最佳实践指导",
        "- 希望 Agent 自动加载专项 SOP 而非通用回答",
    ]
    if "test" in name or "e2e" in name or "playwright" in name:
        when_lines.append("- 编写、审查或调试自动化测试与质量门禁")
    if "architect" in name or "design" in name or "microservice" in name:
        when_lines.append("- 系统架构设计、服务拆分或 API 契约定义")
    if "security" in name or "auth" in name:
        when_lines.append("- 身份认证、授权或安全加固相关开发")

    example = f"使用 {name} 技能，[在此描述你的具体全栈任务，例如：设计 NestJS + React 的用户认证模块]"
    return {
        "title": title,
        "summary": summary,
        "when": "\n".join(when_lines),
        "example": example,
    }


def load_existing_names() -> set[str]:
    text = DATA_FILE.read_text(encoding="utf-8")
    return set(re.findall(r'"([a-z0-9-]+)":\s*\{', text))


def append_stubs(stubs: dict[str, dict]) -> None:
    if not stubs:
        print("No new stubs to add.")
        return
    lines = ["\n# --- auto-sync stubs ---\n"]
    for name in sorted(stubs):
        s = stubs[name]
        lines.append(f'    "{name}": {{')
        lines.append(f'        "title": {s["title"]!r},')
        lines.append(f'        "summary": {s["summary"]!r},')
        lines.append(f'        "when": {s["when"]!r},')
        lines.append(f'        "example": {s["example"]!r},')
        lines.append("    },")
    text = DATA_FILE.read_text(encoding="utf-8")
    if not text.rstrip().endswith("}"):
        raise SystemExit("skills_zh_data.py format unexpected")
    # insert before final closing brace of SKILL_ZH dict
    idx = text.rfind("}")
    new_text = text[:idx] + "\n".join(lines) + "\n}\n"
    DATA_FILE.write_text(new_text, encoding="utf-8")
    print(f"Added {len(stubs)} stubs to {DATA_FILE}")


def main() -> None:
    existing = load_existing_names()
    manifest = load_manifest()
    stubs: dict[str, dict] = {}
    if not SKILLS_DIR.exists():
        print("Skills dir not found")
        return
    for folder in sorted(SKILLS_DIR.iterdir()):
        if not folder.is_dir():
            continue
        name = folder.name
        if name in existing:
            continue
        md = folder / "SKILL.md"
        if not md.exists():
            continue
        if not should_sync(name, manifest):
            continue
        fm = parse_frontmatter(md.read_text(encoding="utf-8", errors="replace"))
        desc = fm.get("description", "")
        stubs[name] = make_stub(name, desc if isinstance(desc, str) else str(desc))
    append_stubs(stubs)


if __name__ == "__main__":
    main()
