$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave68.log"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"=== Wave 68 安装开始 $timestamp ===" | Tee-Object -FilePath $logFile

# 全栈编程类 - 第二批 (2026-06-28)
$repos = @(
    # 高star编程/工程类
    "trailofbits/skills",
    "tradermonty/claude-trading-skills",
    "onvoyage-ai/gtm-engineer-skills",
    "daymade/claude-code-skills",
    "NeoLabHQ/context-engineering-kit",
    "Aaronontheweb/dotnet-skills",
    "ksimback/tech-debt-skill",
    "levnikolaevich/claude-code-skills",
    "DanMcInerney/architect-loop",
    "luoling8192/software-design-philosophy-skill",
    # 移动开发
    "rshankras/claude-code-apple-skills",
    "dpconde/claude-android-skill",
    # 代码质量/工具
    "agamm/claude-code-owasp",
    "skills-directory/skill-codex",
    "ombulabs/claude-code_rails-upgrade-skill",
    "waybarrios/opencode-power-pack",
    "bassimeledath/dispatch",
    # Web设计/前端
    "xiaopu-ai/web-design",
    "freshtechbro/claudedesignskills",
    "oil-oil/draw-ui",
    # 数据/分析
    "posit-dev/skills",
    "nimrodfisher/data-analytics-skills",
    # 中文技能集
    "laolaoshiren/claude-code-skills-zh",
    "wwwzhouhui/skills_collection",
    "lingxling/awesome-skills-cn",
    # 架构/系统设计
    "Artemxtech/personal-os-skills",
    "michalparkola/tapestry-skills",
    # 其他工程类
    "MyuriKanao/src-hunter-skill",
    "ricocc/rico-skills",
    "bidah/skill-set",
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
        Write-Host "  ✗ 失败: $($result | Select-Object -Last 3)" -ForegroundColor Red
        "  ✗ $repo" | Add-Content $logFile
        $fail++
        $failList += $repo
    }
}

$summary = "`n=== Wave 68 完成 === 成功: $success / 失败: $fail ==="
Write-Host $summary -ForegroundColor Yellow
$summary | Add-Content $logFile

if ($failList.Count -gt 0) {
    "`n失败列表:" | Add-Content $logFile
    $failList | ForEach-Object { "  $_" | Add-Content $logFile }
}
