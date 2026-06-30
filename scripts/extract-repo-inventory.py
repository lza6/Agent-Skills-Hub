#!/usr/bin/env python3
# ponytail: 从所有 wave 脚本提取仓库总账。升级路径: 当脚本格式再分化时加 per-format extractor。
import re, glob, os, json
from collections import defaultdict

HUB = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
patterns = [
    re.compile(r'github\.com/([A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+?)[\s"\'\)]', re.I),
    re.compile(r'"([A-Za-z0-9](?:[A-Za-z0-9_.-]*[A-Za-z0-9])?/[A-Za-z0-9_.-]+)"'),
]
# 排除明显非仓库的 owner/repo 误匹配
EXCLUDE_OWNERS = {'Join-Path','PSScriptRoot','Split-Path','Out-File','Out-Null','Join','Path'}

by_wave = defaultdict(list)
all_repos = {}

_scripts = []
for pat in ('install-*-wave*.ps1', 'wave*-global.ps1', 'wave*-resume.ps1'):
    _scripts.extend(glob.glob(os.path.join(HUB, 'scripts', pat)))
for f in sorted(set(_scripts)):
    base = os.path.basename(f)
    m = re.search(r'wave(\d+)', base)
    wave = int(m.group(1)) if m else 0
    try:
        with open(f, encoding='utf-8', errors='replace') as fh:
            txt = fh.read()
    except Exception:
        continue
    found = set()
    for pat in patterns:
        for mo in pat.finditer(txt):
            repo = mo.group(1).rstrip('.')
            owner = repo.split('/')[0]
            if owner in EXCLUDE_OWNERS: continue
            if '.' in repo.split('/')[-1] and not repo.endswith(('.github')):  # skip file.ext
                # but allow repo names; only skip if last segment looks like a file
                pass
            found.add(repo)
    for repo in sorted(found):
        by_wave[wave].append(repo)
        all_repos.setdefault(repo, []).append(wave)

# 输出 JSON + Markdown
out_json = os.path.join(HUB, 'data', 'repo-inventory.json')
out_md = os.path.join(HUB, 'docs', 'REPO-INVENTORY.md')

inv = [{'repo': r, 'waves': sorted(set(w))} for r, w in sorted(all_repos.items())]
with open(out_json, 'w', encoding='utf-8') as fh:
    json.dump({'total_repos': len(inv), 'repos': inv}, fh, ensure_ascii=False, indent=2)

lines = [f'# 技能仓库总账', '', f'> 自动提取自 `scripts/install-*-wave*.ps1`（{len(inv)} 个唯一仓库，wave2–73）', '',
         f'**唯一仓库数: {len(inv)}** | [JSON](../data/repo-inventory.json)', '', '| Wave | 仓库数 | 仓库 |', '|---|---|---|']
for w in sorted(by_wave):
    repos = sorted(set(by_wave[w]))
    lines.append(f'| {w} | {len(repos)} | {", ".join(f"`{r}`" for r in repos)} |')
with open(out_md, 'w', encoding='utf-8') as fh:
    fh.write('\n'.join(lines) + '\n')

print(f"提取完成: {len(inv)} 个唯一仓库 -> {out_md}")
