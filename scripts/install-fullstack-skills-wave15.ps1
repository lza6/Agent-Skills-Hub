# 鍏ㄦ爤鎶€鑳?Wave 15 鈥?鑱旂綉琛ュ厖锛圢etlify / Cloudflare 娣卞寲 / Remix / WebSocket / 娴嬭瘯锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   netlify/context-and-tools              https://github.com/netlify/context-and-tools
#   cloudflare/skills                      https://github.com/cloudflare/skills
#   remix-run/agent-skills                 https://github.com/remix-run/agent-skills
#   Jeffallan/claude-skills                https://github.com/Jeffallan/claude-skills
#   addyosmani/agent-skills                https://github.com/addyosmani/agent-skills
#   sickn33/antigravity-awesome-skills      https://github.com/sickn33/antigravity-awesome-skills (python-fastapi 閲嶈瘯)
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave15-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave15-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
    try {
        $output = & npx @skillCliArgs 2>&1 | Out-String
        $output | Out-File $logFile -Encoding utf8
        if ($output -match "Installed \d+ skill" -or $output -match "Installation complete" -or $output -match "Done!") {
            "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
            return $true
        }
        "FAIL $Label (exit $LASTEXITCODE)" | Tee-Object -FilePath $summaryFile -Append
        return $false
    } catch {
        "ERROR $Label : $_" | Tee-Object -FilePath $summaryFile -Append
        return $false
    }
}

"Fullstack Wave 15 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Netlify 瀹樻柟鍏ㄩ噺 ---
Install-SkillBatch -Label "netlify-official" -Repo "https://github.com/netlify/context-and-tools" -All

# --- Cloudflare 琛ヨ ---
Install-SkillBatch -Label "cloudflare-remaining" -Repo "https://github.com/cloudflare/skills" -Skills @(
    "sandbox-sdk","web-perf","cloudflare-email-service","turnstile-spin",
    "cloudflare-one","cloudflare-one-migrations"
)

# --- React Router / Remix ---
Install-SkillBatch -Label "react-router-remix" -Repo "https://github.com/remix-run/agent-skills" -Skills @(
    "react-router-data-mode","react-router-declarative-mode"
)

# --- WebSocket 宸ョ▼甯?---
Install-SkillBatch -Label "websocket-jeffallan" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @("websocket-engineer")

# --- 鎬ц兘 / 鍙娴嬫€?(addyosmani) ---
Install-SkillBatch -Label "addyosmani-perf" -Repo "https://github.com/addyosmani/agent-skills" -Skills @(
    "performance-optimization","observability-and-instrumentation"
)

# --- python-fastapi-development 琛ヨ ---
Install-SkillBatch -Label "python-fastapi-retry" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @("python-fastapi-development")

"`nWave 15 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 15 complete: $summaryFile" -ForegroundColor Green
