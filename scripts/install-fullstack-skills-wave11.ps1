# 鍏ㄦ爤鎶€鑳?Wave 11 鈥?琛ヨ锛圙raphQL / FastAPI / ClickHouse / Terraform锛?
#
# 浠撳簱鏉ユ簮锛?-list 鏍￠獙锛?
#   Jeffallan/claude-skills              https://github.com/Jeffallan/claude-skills
#   sickn33/antigravity-awesome-skills   https://github.com/sickn33/antigravity-awesome-skills
#   hashicorp/agent-skills               https://github.com/hashicorp/agent-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave11-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave11-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
    try {
        $output = & npx @skillCliArgs 2>&1 | Out-String
        $output | Out-File $logFile -Encoding utf8
        if ($output -match "Installed \d+ skill" -or $output -match "Installation complete") {
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

"Fullstack Wave 11 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- GraphQL锛圝effallan锛屽皬浠撳簱浼樺厛锛?--
Install-SkillBatch -Label "graphql-jeffallan" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @("graphql-architect")

# --- ClickHouse / GraphQL 娣卞寲锛坅ntigravity锛屼綋绉ぇ鍙兘瓒呮椂锛?--
Install-SkillBatch -Label "clickhouse-graphql" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "cc-skill-clickhouse-io","graphql"
)

# --- FastAPI 琛ヨ锛圵ave 10 缃戠粶澶辫触锛?--
Install-SkillBatch -Label "fastapi-retry" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "fastapi-router-py","python-fastapi-development"
)

# --- Terraform Stacks锛圵ave 6 閬楁紡锛?--
Install-SkillBatch -Label "terraform-stacks" -Repo "https://github.com/hashicorp/agent-skills" -Skills @("terraform-stacks")

"`nWave 11 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 11 complete: $summaryFile" -ForegroundColor Green
