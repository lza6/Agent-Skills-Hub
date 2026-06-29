#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""批量翻译缺失的技能中文描述。

使用本地 qwen3-coder-plus 模型进行翻译。
"""
from __future__ import annotations

import io
import json
import os
import re
import sys
import time
from pathlib import Path

# 强制 stdout 使用 UTF-8 编码
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')

import requests

HUB_DIR = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(HUB_DIR / "data"))
from skills_zh_data import SKILL_ZH  # noqa: E402

SKILLS_DIR = Path(os.path.expanduser("~/.claude/skills"))
DATA_FILE = HUB_DIR / "data" / "skills_zh_data.py"

# 本地模型代理配置
API_URL = os.environ.get("LLM_BASE_URL", "http://127.0.0.1:20128/v1")
API_KEY = os.environ.get("LLM_API_KEY", "sk-38cfd474833197cf-2ccieu-991fc0d3")


def parse_frontmatter(text: str) -> dict:
    match = re.match(r"^---\s*\n(.*?)\n---", text, re.DOTALL)
    if not match:
        return {}
    raw = match.group(1)
    data: dict = {}
    for line in raw.splitlines():
        if ":" in line and not line.startswith(" "):
            key, val = line.split(":", 1)
            data[key.strip()] = val.strip().strip("'\"")
    return data


def load_installed_skills() -> dict[str, dict]:
    """加载已安装的技能信息。"""
    skills: dict[str, dict] = {}
    if not SKILLS_DIR.exists():
        return skills

    for folder in SKILLS_DIR.iterdir():
        if not folder.is_dir():
            continue
        md = folder / "SKILL.md"
        if not md.exists():
            continue

        fm = parse_frontmatter(md.read_text(encoding="utf-8", errors="replace"))
        name = str(fm.get("name", folder.name))
        desc = fm.get("description", "")
        if isinstance(desc, str):
            desc = re.sub(r"\s+", " ", desc).strip()
        skills[name] = {
            "folder": folder.name,
            "desc": desc,
        }
    return skills


def translate_description(name: str, desc: str) -> dict:
    """使用 LLM 翻译技能描述。"""
    if not desc:
        return {}

    prompt = f"""请将以下 Claude Code Skill 的描述翻译成中文，保持技术术语准确。

技能名称: {name}
英文描述: {desc}

请以 JSON 格式返回翻译结果，包含以下字段：
- title: 简短的中文标题（最多 10 个字）
- summary: 功能说明（50-100 字，一句话概括核心功能）
- when: 适用场景（3-5 个要点，用 \\n 分隔）
- example: 调用示例（一句中文指令）

只返回 JSON，不要其他内容。"""

    try:
        resp = requests.post(
            f"{API_URL}/chat/completions",
            headers={
                "Authorization": f"Bearer {API_KEY}",
                "Content-Type": "application/json",
            },
            json={
                "model": "bv",
                "messages": [{"role": "user", "content": prompt}],
                "temperature": 0.3,
                "max_tokens": 500,
            },
            timeout=30,
        )
        resp.raise_for_status()
        resp_text = resp.text

        # 移除 SSE 流式数据标记
        resp_text = re.sub(r"data:\s*\[DONE\]", "", resp_text)
        resp_text = resp_text.strip()

        # 提取第一个 JSON 对象
        start = resp_text.find("{")
        end = resp_text.rfind("}")
        if start == -1 or end == -1:
            return {}
        resp_json = json.loads(resp_text[start:end+1])

        # 从 OpenAI 格式响应中提取内容
        choices = resp_json.get("choices", [])
        if not choices:
            return {}
        content = choices[0].get("message", {}).get("content", "")

        # 尝试提取 JSON（处理多种格式）
        # 先移除 markdown 代码块标记和 SSE 流式数据
        content_clean = re.sub(r"```json\s*", "", content)
        content_clean = re.sub(r"```\s*", "", content_clean)
        content_clean = re.sub(r"data:\s*\[DONE\]", "", content_clean)
        content_clean = content_clean.strip()

        # 1. 先尝试直接解析整个内容
        try:
            result = json.loads(content_clean)
            return {
                "title": result.get("title", name),
                "summary": result.get("summary", ""),
                "when": result.get("when", ""),
                "example": result.get("example", ""),
            }
        except json.JSONDecodeError:
            pass

        # 2. 提取第一个 JSON 对象
        json_match = re.search(r"\{[^{}]*\}", content_clean)
        if json_match:
            try:
                result = json.loads(json_match.group())
                return {
                    "title": result.get("title", name),
                    "summary": result.get("summary", ""),
                    "when": result.get("when", ""),
                    "example": result.get("example", ""),
                }
            except json.JSONDecodeError:
                pass

        # 3. 使用正则提取字段
        title_match = re.search(r'"title"\s*:\s*"([^"]+)"', content)
        summary_match = re.search(r'"summary"\s*:\s*"([^"]+)"', content)
        when_match = re.search(r'"when"\s*:\s*"([^"]+)"', content)
        example_match = re.search(r'"example"\s*:\s*"([^"]+)"', content)

        if title_match or summary_match:
            return {
                "title": title_match.group(1) if title_match else name,
                "summary": summary_match.group(1) if summary_match else "",
                "when": when_match.group(1) if when_match else "",
                "example": example_match.group(1) if example_match else "",
            }
    except Exception as e:
        print(f"  翻译失败 [{name}]: {e}")

    return {}


def escape_string(s: str) -> str:
    """转义字符串中的特殊字符。"""
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n").replace("\r", "")


def update_skills_data(new_entries: dict[str, dict]) -> None:
    """更新 skills_zh_data.py 文件。"""
    # 读取现有内容
    content = DATA_FILE.read_text(encoding="utf-8")

    # 构建新条目字符串
    entries_str = []
    for name, data in sorted(new_entries.items()):
        entry = f'''    "{name}": {{
        "title": "{escape_string(data['title'])}",
        "summary": "{escape_string(data['summary'])}",
        "when": "{escape_string(data['when'])}",
        "example": "{escape_string(data['example'])}",
    }},'''
        entries_str.append(entry)

    # 在 SKILL_ZH = { 后插入新条目
    new_content = content.replace(
        "SKILL_ZH = {",
        "SKILL_ZH = {\n" + "\n".join(entries_str) + "\n"
    )

    DATA_FILE.write_text(new_content, encoding="utf-8")
    print(f"已更新 {DATA_FILE}")


def main() -> None:
    print("加载已安装技能...")
    installed = load_installed_skills()
    print(f"已安装: {len(installed)} 个技能")

    print(f"已有中文翻译: {len(SKILL_ZH)} 个")

    # 找出缺失翻译的技能
    missing = set(installed.keys()) - set(SKILL_ZH.keys())
    print(f"缺失翻译: {len(missing)} 个")

    if not missing:
        print("所有技能已有中文翻译，无需处理。")
        return

    # 限制批量翻译数量
    batch_size = int(os.environ.get("TRANSLATE_BATCH", "50"))
    to_translate = sorted(missing)[:batch_size]
    print(f"本次翻译: {len(to_translate)} 个（设置 TRANSLATE_BATCH 环境变量调整）")

    new_entries: dict[str, dict] = {}
    for i, name in enumerate(to_translate, 1):
        desc = installed[name].get("desc", "")
        if not desc:
            print(f"[{i}/{len(to_translate)}] {name}: 无描述，跳过")
            continue

        print(f"[{i}/{len(to_translate)}] 翻译 {name}...")
        translated = translate_description(name, desc)
        if translated:
            new_entries[name] = translated
            print(f"  OK: {translated['title']}")
        time.sleep(0.5)  # 避免请求过快

    if new_entries:
        update_skills_data(new_entries)
        print(f"\n完成！新增 {len(new_entries)} 条翻译。")
        print("运行以下命令重新生成文档：")
        print("  python scripts/generate-skills-reference-zh.py")
    else:
        print("\n未获得新的翻译条目。")


if __name__ == "__main__":
    main()
