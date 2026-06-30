# -*- coding: utf-8 -*-
"""为所有已安装但缺元数据的技能生成中文 stub（增强版）。

与 sync-skills-zh-data.py 的区别：
- 不限白名单，覆盖全部已装技能
- 从 SKILL.md 提取真实 description 嵌入 summary（而非泛泛模板）
- 修复源码屏蔽词污染
- 生成结果按名称排序，可重复运行（幂等）

用法: python scripts/sync-all-skills-zh.py [--dry-run]
"""
from __future__ import annotations

import os
import re
import sys
from pathlib import Path

HUB = Path(__file__).resolve().parent.parent
DATA_FILE = HUB / "data" / "skills_zh_data.py"
SKILLS_DIR = Path(os.path.expanduser("~/.claude/skills"))

DRY_RUN = "--dry-run" in sys.argv

# 屏蔽词修复映射（源码里被污染的字面量）
BAD_WORD_FIX = {
    "[用户触发屏蔽词]": "安全",
    "[屏蔽词]": "安全",
}


def slug_to_title(slug: str) -> str:
    return slug.replace("-", " ").title()


def parse_description(md_text: str) -> str:
    """从 SKILL.md frontmatter 提取 description。"""
    m = re.search(r"^---\s*\n(.*?)\n---", md_text, re.DOTALL)
    if not m:
        # 无 frontmatter，取首行非标题文本
        for line in md_text.splitlines():
            line = line.strip().lstrip("#").strip()
            if line:
                return line[:200]
        return ""
    for line in m.group(1).splitlines():
        if line.strip().startswith("description:"):
            desc = line.split("description:", 1)[1].strip().strip("'\"")
            # 修复污染词
            for bad, good in BAD_WORD_FIX.items():
                desc = desc.replace(bad, good)
            return desc
    return ""


def make_stub(name: str, desc: str) -> dict:
    title = slug_to_title(name)
    short = desc[:180].rstrip()
    if short:
        summary = f"提供「{title}」领域的专项能力。{short}"
    else:
        summary = f"提供「{title}」领域的专项工作流与最佳实践。"

    when_lines = ["- 任务涉及该技能名称所描述的技术领域或工作流",
                  "- 需要结构化、可重复的专业指导而非通用回答"]
    keywords = {
        "test": "- 编写、审查或调试测试",
        "security": "- 安全审查、漏洞扫描或认证授权",
        "auth": "- 身份认证或授权开发",
        "deploy": "- 部署、CI/CD 或发布流程",
        "database": "- 数据库设计、查询或迁移",
        "api": "- API 设计、实现或集成",
        "frontend": "- 前端开发、UI 或设计系统",
        "react": "- React / 前端组件开发",
        "python": "- Python 开发",
        "typescript": "- TypeScript 开发",
        "docker": "- 容器化或 DevOps",
        "kubernetes": "- K8s 编排",
        "ai": "- AI / LLM 应用开发",
        "doc": "- 文档编写或更新",
    }
    for kw, line in keywords.items():
        if kw in name.lower():
            when_lines.append(line)

    example = f"使用 {name} 技能，[描述你的具体任务]"
    return {"title": title, "summary": summary,
            "when": "\n".join(dict.fromkeys(when_lines)), "example": example}


def load_existing_names() -> set[str]:
    text = DATA_FILE.read_text(encoding="utf-8")
    return set(re.findall(r'"([a-z0-9-]+)":\s*\{', text))


def main() -> None:
    if not SKILLS_DIR.exists():
        print("技能目录不存在"); return
    existing = load_existing_names()
    stubs: dict[str, dict] = {}
    skipped = 0
    for folder in sorted(SKILLS_DIR.iterdir()):
        if not folder.is_dir():
            continue
        name = folder.name
        if not re.fullmatch(r"[a-z0-9._-]+", name):
            skipped += 1
            continue
        if name in existing:
            continue
        md = folder / "SKILL.md"
        if not md.exists():
            continue
        try:
            desc = parse_description(md.read_text(encoding="utf-8", errors="ignore"))
        except Exception:
            desc = ""
        stubs[name] = make_stub(name, desc)

    print(f"已有元数据: {len(existing)}")
    print(f"本次新增 stub: {len(stubs)}")
    print(f"跳过(非法名称): {skipped}")

    if DRY_RUN or not stubs:
        return

    # 构建插入文本
    lines = ["\n# --- auto-sync stubs (sync-all-skills-zh.py) ---\n"]
    for name in sorted(stubs):
        s = stubs[name]
        lines.append(f'    "{name}": {{')
        lines.append(f'        "title": {s["title"]!r},')
        lines.append(f'        "summary": {s["summary"]!r},')
        lines.append(f'        "when": {s["when"]!r},')
        lines.append(f'        "example": {s["example"]!r},')
        lines.append("    },")

    text = DATA_FILE.read_text(encoding="utf-8")
    # 找最后一个顶层 } （SKILL_ZH dict 的闭合）
    idx = text.rstrip().rfind("}")
    if idx < 0:
        print("格式异常: 找不到闭合 }"); return
    new_text = text[:idx].rstrip() + "\n" + "\n".join(lines) + "\n}\n"
    DATA_FILE.write_text(new_text, encoding="utf-8")
    print(f"已写入 {DATA_FILE}")


if __name__ == "__main__":
    main()
