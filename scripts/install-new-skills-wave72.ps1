$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave72.log"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"=== Wave 72 安装开始 $timestamp ===" | Tee-Object -FilePath $logFile

# gh search 筛选的全栈/工程类新仓库 (2026-06-30)
$repos = @(
    # 安全/逆向
    "trailofbits/skills",
    # 浏览器自动化/测试
    "lackeyjb/playwright-skill",
    "browserwing/browserwing",
    # 设计/UI
    "dominikmartn/nothing-design-skill",
    "carmahhawwari/ui-design-brain",
    # 全栈/工程集合
    "daymade/claude-code-skills",
    "NeoLabHQ/context-engineering-kit",
    "Aaronontheweb/dotnet-skills",
    "CharlesWiltgen/Axiom",
    "alirezarezvani/claude-code-skill-factory",
    "coleam00/second-brain-skills",
    # Cursor 技能集
    "araguaci/cursor-skills",
    "gnurio/nurijanian-skills",
    "chrisboden/cursor-skills",
    "harrychuang/cursor-skills",
    "yilansun416-design/cursor-skills",
    "TashanGKD/tashan-cursor-skills",
    "dotdc/cursor-workshop",
    "aussiegingersnap/cursor-skills",
    # 专项工具
    "Pluviobyte/jiepi-skill",
    "xuliang2024/video_skills",
    "chencodeX/he-kaiming-style-research-skill",
    "chenShengBiao/cocos-ai-mcp",
    "lihao0318/ai-nl2ui-automation",
    "prepfinders/seedance2-api",
    "robzilla1738/htmlshop",
    "sukilll/prompt-improver",
    "yuhaoliu7456/pdf2md-skill"
)

$success = 0
$fail = 0
$failList = @()

foreach ($repo in $repos) {
    Write-Host "安装: $repo" -ForegroundColor Cyan
    $result = npx skills add $repo 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  v 成功" -ForegroundColor Green
        "  v $repo" | Add-Content $logFile
        $success++
    } else {
        Write-Host "  x 失败" -ForegroundColor Red
        "  x $repo" | Add-Content $logFile
        $fail++
        $failList += $repo
    }
}

$summary = "`n=== Wave 72 完成 === 成功: $success / 失败: $fail ==="
Write-Host $summary -ForegroundColor Yellow
$summary | Add-Content $logFile
if ($failList.Count -gt 0) {
    "失败列表:" | Add-Content $logFile
    $failList | Add-Content $logFile
}
