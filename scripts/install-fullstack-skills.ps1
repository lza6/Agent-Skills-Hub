# 鍏ㄦ爤鐩稿叧鎶€鑳?鈥?鍏ㄥ眬鎵归噺瀹夎鑴氭湰
# 鏉ユ簮锛歴kills.sh 妫€绱?+ vaquarkhan/Jeffallan/Vercel 绛夌煡鍚嶅叏鏍堟妧鑳藉簱
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-summary-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"
$failFile = Join-Path $logDir "fullstack-failures.txt"

function Install-SkillBatch {
    param(
        [string]$Label,
        [string]$Repo,
        [string[]]$Skills,
        [switch]$All
    )
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) {
        $skillCliArgs += @("--all")
    } else {
        foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) }
    }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("fullstack-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
    try {
        $output = & npx @skillCliArgs 2>&1 | Out-String
        $output | Out-File $logFile -Encoding utf8
        if ($output -match "Installed \d+ skill" -or $output -match "Installation complete") {
            "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
            return $true
        }
        "FAIL $Label (exit $LASTEXITCODE)" | Tee-Object -FilePath $summaryFile -Append
        "FAIL $Label`n$output" | Out-File $failFile -Append -Encoding utf8
        return $false
    } catch {
        "ERROR $Label : $_" | Tee-Object -FilePath $summaryFile -Append
        return $false
    }
}

"Fullstack skills install started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# 1) vaquarkhan 鈥?72 涓敓浜х骇鍏ㄦ爤宸ヤ綔娴佹妧鑳斤紙UI/寰湇鍔?韬唤/浜?娴嬭瘯/瑙傛祴锛?
Install-SkillBatch -Label "vaquarkhan-fullstack-all" -Repo "https://github.com/vaquarkhan/Fullstack-development-agent-skills" -All

# 2) Jeffallan 鈥?绮鹃€夊叏鏍堝紑鍙戞妧鑳斤紙鍒嗘壒閬垮厤鍛戒护杩囬暱锛?
$jeffBatch1 = @(
    "fullstack-guardian","nestjs-expert","nextjs-developer","react-expert","react-native-expert",
    "typescript-pro","vue-expert","fastapi-expert","django-expert","spring-boot-engineer"
)
$jeffBatch2 = @(
    "golang-pro","graphql-architect","microservices-architect","api-designer","architecture-designer",
    "cloud-architect","database-optimizer","postgres-pro","sql-pro","devops-engineer"
)
$jeffBatch3 = @(
    "kubernetes-specialist","terraform-engineer","websocket-engineer","secure-code-guardian",
    "security-reviewer","test-master","playwright-expert","code-reviewer","debugging-wizard","javascript-pro"
)
Install-SkillBatch -Label "jeffallan-fullstack-1" -Repo "https://github.com/Jeffallan/claude-skills" -Skills $jeffBatch1
Install-SkillBatch -Label "jeffallan-fullstack-2" -Repo "https://github.com/Jeffallan/claude-skills" -Skills $jeffBatch2
Install-SkillBatch -Label "jeffallan-fullstack-3" -Repo "https://github.com/Jeffallan/claude-skills" -Skills $jeffBatch3

# 3) Vercel agent-skills锛圧eact Native + Web 璁捐瑙勮寖锛?
Install-SkillBatch -Label "vercel-agent-skills" -Repo "https://github.com/vercel-labs/agent-skills" -Skills @(
    "vercel-react-native-skills","web-design-guidelines"
)

# 4) skills.sh 鐑棬鍏ㄦ爤鍗曢」鎶€鑳?
$singleInstalls = @(
    @{ Label = "awesome-llm-fullstack"; Repo = "https://github.com/shubhamsaboo/awesome-llm-apps"; Skills = @("fullstack-developer") },
    @{ Label = "minimax-fullstack"; Repo = "https://github.com/minimax-ai/skills"; Skills = @("fullstack-dev") },
    @{ Label = "antigravity-senior-fullstack"; Repo = "https://github.com/sickn33/antigravity-awesome-skills"; Skills = @("senior-fullstack") },
    @{ Label = "alirezarezvani-senior-fullstack"; Repo = "https://github.com/alirezarezvani/claude-skills"; Skills = @("senior-fullstack") },
    @{ Label = "tech-leads-club"; Repo = "https://github.com/tech-leads-club/agent-skills"; Skills = @("full-stack-development") }
)
foreach ($item in $singleInstalls) {
    Install-SkillBatch -Label $item.Label -Repo $item.Repo -Skills $item.Skills
}

"`nFullstack install done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nSummary: $summaryFile" -ForegroundColor Green
Write-Host "Run: python $HubDir\scripts\sync-skills-zh-data.py" -ForegroundColor Yellow
Write-Host "Then: $HubDir\update-docs.ps1" -ForegroundColor Yellow
