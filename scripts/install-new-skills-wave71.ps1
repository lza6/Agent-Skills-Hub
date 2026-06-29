$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave71.log"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"=== Wave 71 安装开始 $timestamp ===" | Tee-Object -FilePath $logFile

# 全栈开发工具/代理/安全类 - 第五批 (2026-06-29)
$repos = @(
    # 开发工具/自动化
    "bacoco/ShipGuard",
    "rm3-pro/claude-toaster-mode",
    "4hum-ai/slide-deck-skill",
    "saitoco/wholework",
    "aryaxt/aryaxt-skills",
    "IoIqq/ftb-quests-skills",
    "wellcaffeinated/well-cafe-skills",
    "allshaks/paper2blogpost",
    "daviidarr/deepweb",
    "paipeline/auto-routines",
    "Linux9505/claude-code-skill-activator",
    "Sanskar015/claude-skills-supercharged",
    "OrionArchitekton/orion-skills",
    "GXLooong/claude-learning-skills",
    # 产品/创业/GTM
    "NousC/gtm-skills",
    "sales-skills/sales",
    "virgiliojr94/book-to-skill",
    "Smetools/odoo-demo-architect",
    "itsfromgaurav/grand-slam-offer-skill",
    "kevvykevwin/kevin-skills",
    # 设计/视觉
    "jpoindexter/tufte-skills",
    "threerocks/hand-drawn-styles",
    "itsSIGI/ag-design-skills",
    # 安全
    "jassics/awesome-claude-security",
    "Frun1753/claude-codecraft-toolkit",
    # 3D打印/制造
    "m-esm/bambu-3mf-export",
    "m-esm/3d-print-modeling",
    # 计划/审查
    "abassaf/plan-review-hub",
    # 通用技能集合
    "oalders/kitchen-sink",
    "philippasigl/psg-skills"
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

$summary = "`n=== Wave 71 完成 === 成功: $success / 失败: $fail ==="
Write-Host $summary -ForegroundColor Yellow
$summary | Add-Content $logFile
if ($failList.Count -gt 0) {
    "失败列表:" | Add-Content $logFile
    $failList | Add-Content $logFile
}
