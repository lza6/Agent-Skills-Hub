# Wave 安装总览

> 自动汇总各波次技能仓库安装结果。最新数据见末尾。
> 生成时间：2026-06-30

---

## 总体规模

| 维度 | 数值 |
|------|------|
| 唯一仓库数（去重） | 743 |
| 全局技能数 `~/.claude/skills/` | 14000+ |
| 中文元数据条目 | 16000+ |
| 中文手册行数 | 46000+ |
| 英文手册行数 | 19000+ |
| Wave 脚本数 | 91（Wave 2–87） |

仓库明细见 [`docs/REPO-INVENTORY.md`](../docs/REPO-INVENTORY.md)（人读）与
[`data/repo-inventory.json`](../data/repo-inventory.json)（机读）。

---

## 近期波次结果（Wave 73–87）

| Wave | 成功 | 失败 | 主要方向 | 失败仓库 |
|------|------|------|----------|----------|
| 73 | 21 | 4 | 全栈/工程/文档 | nexu-io/html-anything, tigicion/dao-code, feicaoclub/video-spec-builder, u7079256/paperjury |
| 74 | 23 | 0 | 高星精选（prompt-master/dev-browser/安全/金融/PM） | — |
| 75 | 15 | 1 | 全栈专场（taste/impeccable/tailwind/node/rust/mobile） | 404kidwiz/claude-supercode-skills |
| 76 | 19 | 1 | 多语言栈（Java/Spring/.NET/RN/TanStack/Laravel） | iii-hq/skills |
| 77 | 18 | 0 | 数据库/DevOps/Rust/Go/可观测/测试/CI | — |
| 78 | 17 | 1 | Python/NextJS/Supabase/WASM/Desktop/搜索/工作流 | partme-ai/full-stack-skills |
| 79 | 18 | 0 | Rust/Go/Python数据/Tauri/GSAP/官方库刷新(supabase/clerk/apollo/stripe) | — |
| 80 | 18 | 0 | 多语言栈(Phoenix/Rails/Laravel/Swift/Kotlin) + Bevy + Grafana/Cloudflare/Mongo | — |
| 81 | 18 | 0 | Windmill/Litestar/Angular生态/Go全套(samber)/搜索队列 + 官方库刷新 | — |
| 82 | 12 | 5 | 全栈(Claude-ads/Ultimate-Guide/Spring-Boot/LaTeX/McKinsey-PPTX/AppGenesisForge/Copilot-Studio) | botingw/rulebook-ai, seulee26/mckinsey-pptx, LingyiChen-AI/comfyui-workflow-skill, karanb192/awesome-claude-skills, spences10/claude-skills-cli |
| 83 | 11 | 1 | 全栈工程(vercel-labs/skills官方/Ricko12vPL Python/browserbase/trailofbits精选/AWS/superpowers-chrome/GRC/night-market) | agentskills/agentskills |
| 84 | 12 | 0 | 全栈(graphify/showcase/Rails/plinth/PowerPlatform/transilience/obie/marketplace/SpringBoot/AWSBedrock/plugins/starter) | — |
| 85 | 10 | 4 | 全栈(scrapling/QA-framework/worktree-manager/awesome合集/devops系列) | glebis/claude-skills, itgoyo/awesome-claude-code-skills, Kentobayashi/claude-skills-QA-framework, anikievev/claude-skills-devops |
| 86 | 17 | 2 | 全栈(best-practice/generative-media/pro-workflow/continuous-claude/planning-with-files/baoyu/drawio/java/shinkoku/smart-ralph/ok-skills/openagent/AI-Research/PM) | ciembor/agent-rules-books, jiweiyeah/Skills-Manager |
| 87 | 23 | 0 | 全栈(context-mode/seo/obsidian/godogen/mermaid/narrator/blog/banana/GodotMaker/reins/nelson/ai-agent-team/web-clone/cti-expert/youtube/SkillCompass/word-format/jeecg/youtube-fetcher) | — |

失败原因统一为 `exit 1`（仓库无有效 SKILL.md 或结构不符 `npx skills` 规范）。

---

## 标准闭环（每波必走）

```
1. npx skills search <方向>          # 按全栈技术栈筛选候选
2. scripts/wave<N>-global.ps1        # 后台 schtasks 批量安装
3. python scripts/sync-all-skills-zh.py        # 元数据补全
4. python scripts/generate-skills-reference-zh.py  # 中文手册
5. python scripts/generate-skills-reference.py     # 英文手册
6. python scripts/extract-repo-inventory.py    # 刷新仓库总账
7. git commit + push                 # 推送（用 gh token 内嵌 URL）
```

详见 SOP 记忆 `skill-management-workflow`。

---

## 历史波次（Wave 2–72）

Wave 2–72 由早期 `install-fullstack-skills-wave*.ps1`（Wave 2–42）与
`install-new-skills-wave*.ps1`（Wave 43–72）脚本批量安装，覆盖基础全栈、
框架最佳实践、SaaS 集成、安全/运维等方向。完整仓库清单见总账文档。
