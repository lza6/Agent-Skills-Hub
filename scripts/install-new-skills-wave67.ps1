$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave67.log"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"=== Wave 67 安装开始 $timestamp ===" | Tee-Object -FilePath $logFile

# 全栈编程类新仓库 (2026-06-28 搜索)
$repos = @(
    # 全栈/企业级
    "nguyenchilong/claude-skills-fullstacks",
    "rampstackco/claude-skills",
    "abubakarsiddik31/claude-skills-collection",
    "staruhub/ClaudeSkills",
    "iamzhihuix/happy-claude-skills",
    "NTCoding/claude-skillz",
    "instavm/open-skills",
    "mrgoonie/claudekit-skills",
    "mhattingpete/claude-skills-marketplace",
    # Go / 后端
    "smallnest/goskills",
    "simonw/claude-skills",
    # 前端框架
    "spences10/svelte-claude-skills",
    "dgreenheck/webgpu-claude-skill",
    # DevOps
    "ahmedasmar/devops-claude-skills",
    "harikrishna8121999/antigravity-workflows",
    # 数据可视化
    "chrisvoncsefalvay/claude-d3js-skill",
    # Rails / Ruby
    "thoughtbot/rails-audit-thoughtbot",
    "palkan/skills",
    # 编程工作流
    "StrongAI/claude-skills-programming",
    "distil-labs/distil-cli-skill",
    "K-Dense-AI/claude-skills-mcp",
    "proficientlyjobs/proficiently-claude-skills",
    # 知识管理/第二大脑
    "coleam00/second-brain-skills",
    # 通用技能集
    "jezweb/claude-skills",
    "Fokkyp/claude-skills",
    "secondsky/claude-skills",
    "posit-dev/skills",
    "molefrog/skills",
    "OzTamir/skills",
    "jamessawle/skills",
    "artwist-polyakov/polyakov-claude-skills",
    # 中文技能
    "lingxling/awesome-skills-cn",
    "LeastBit/Claude_skills_zh-CN",
    # 办公/产品
    "claude-office-skills/skills",
    "ognjengt/founder-skills"
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
        "  ✗ $repo | $result" | Add-Content $logFile
        $fail++
        $failList += $repo
    }
}

$summary = "`n=== Wave 67 完成 === 成功: $success / 失败: $fail ==="
Write-Host $summary -ForegroundColor Yellow
$summary | Add-Content $logFile

if ($failList.Count -gt 0) {
    "`n失败列表:" | Add-Content $logFile
    $failList | ForEach-Object { "  $_" | Add-Content $logFile }
}
