$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave69.log"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"=== Wave 69 安装开始 $timestamp ===" | Tee-Object -FilePath $logFile

# 全栈编程类 - 第三批 (2026-06-28)
$repos = @(
    # 安全/代码质量
    "VicKayro/claude-security-audit",
    "Security-Phoenix-demo/security-skills-claude-code",
    "agamm/claude-code-owasp",
    # 系统设计/架构
    "DanMcInerney/architect-loop",
    "luoling8192/software-design-philosophy-skill",
    "folkss/plan-then-code",
    # 数据库/数据工程
    "justvinhhere/bigquery-expert",
    # DevOps/云
    "digitalocean-labs/do-app-platform-skills",
    "joomcode/joompulse-skills",
    # 移动/桌面
    "Amanbh997/Urban-Design-Skills-Claude",
    "rshankras/claude-code-apple-skills",
    # 开源工具
    "LukeRenton/explore-claude-code",
    "nelsonwerd/idea-to-ship-skills",
    "MonadWorks/agentify",
    "EfanWang/skills-manager",
    "biocontext-ai/skill-to-mcp",
    # 工程最佳实践
    "Jack-Pision/agentic-AI-development-skills-claude-code",
    "handharr-labs/software-dev-agentic",
    "MCKRuZ/claude-code-mastery",
    "agenticloops-ai/claude-code-insights",
    # Rails/Ruby
    "ombulabs/claude-code_rails-upgrade-skill",
    # 前端/设计
    "arvindrk/extract-design-system",
    "xiehust/awesome-skills-claude-agents",
    "catyiqian/claude-design-style",
    # 多语言/国际化
    "sfrangulov/claude-code-handbook-ru",
    "J-nowcow/awesome-korean-agent-skills",
    # 生产力/通用
    "seranking/seo-skills",
    "AlterLab-IEU/AlterLab-Academic-Skills",
    "prismatic-io/prismatic-skills",
    "jeanpaulsio/nunchuck-skills",
    "stevederico/skills",
    "TimBroddin/skills"
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

$summary = "`n=== Wave 69 完成 === 成功: $success / 失败: $fail ==="
Write-Host $summary -ForegroundColor Yellow
$summary | Add-Content $logFile

if ($failList.Count -gt 0) {
    "`n失败列表:" | Add-Content $logFile
    $failList | ForEach-Object { "  $_" | Add-Content $logFile }
}
