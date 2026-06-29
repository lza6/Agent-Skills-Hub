$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave70.log"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"=== Wave 70 安装开始 $timestamp ===" | Tee-Object -FilePath $logFile

# 全栈编程类 - 第四批 (2026-06-28)
$repos = @(
    # TypeScript/React专项
    "Impertio-Studio/React-Claude-Skill-Package",
    "sonimanish180/nextjs-skill",
    "jaballer/react-claude-skills",
    "shoaibmalick/development-claude-skills",
    # 创业/产品
    "emotixco/claude-skills-founder",
    "ognjengt/founder-skills",
    "nelsonwerd/idea-to-ship-skills",
    # 开发工具/工作流
    "MonadWorks/agentify",
    "EfanWang/skills-manager",
    "biocontext-ai/skill-to-mcp",
    "folkss/plan-then-code",
    "agenticloops-ai/claude-code-insights",
    "MCKRuZ/claude-code-mastery",
    # 安全审计
    "VicKayro/claude-security-audit",
    "Security-Phoenix-demo/security-skills-claude-code",
    # 移动/Apple
    "rshankras/claude-code-apple-skills",
    "Amanbh997/Urban-Design-Skills-Claude",
    # 数据库/查询
    "justvinhhere/bigquery-expert",
    # 中文/国际
    "sfrangulov/claude-code-handbook-ru",
    "J-nowcow/awesome-korean-agent-skills",
    "lingxling/awesome-skills-cn",
    # 探索/学习
    "LukeRenton/explore-claude-code",
    "hashgraph-online/hol-claude-skills",
    # 运维/平台
    "digitalocean-labs/do-app-platform-skills",
    "joomcode/joompulse-skills",
    "prismatic-io/prismatic-skills",
    "AlterLab-IEU/AlterLab-Academic-Skills",
    # 通用工具
    "stevederico/skills",
    "TimBroddin/skills",
    "jeanpaulsio/nunchuck-skills",
    "AurelienRibon/skills",
    "xiehust/awesome-skills-claude-agents",
    "helloianneo/awesome-claude-code-skills"
)

$success = 0
$fail = 0
$failList = @()

foreach ($repo in $repos) {
    Write-Host "安装: $repo" -ForegroundColor Cyan
    $result = npx skills add $repo 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ 成功" -ForegroundColor Green
        "  ✓ $repo" | Add-Content $logFile
        $success++
    } else {
        Write-Host "  ✗ 失败" -ForegroundColor Red
        "  ✗ $repo" | Add-Content $logFile
        $fail++
        $failList += $repo
    }
}

$summary = "`n=== Wave 70 完成 === 成功: $success / 失败: $fail ==="
Write-Host $summary -ForegroundColor Yellow
$summary | Add-Content $logFile
