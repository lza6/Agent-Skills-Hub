# 鍏ㄦ爤鎶€鑳?Wave 10 鈥?鑱旂綉琛ュ厖锛圥risma / FastAPI / WordPress / MCP-AI / SRE / 鎼滅储宸ュ叿锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   prisma/skills                           https://github.com/prisma/skills
#   sickn33/antigravity-awesome-skills        https://github.com/sickn33/antigravity-awesome-skills
#   jezweb/claude-skills                      https://github.com/jezweb/claude-skills
#   BagelHole/DevOps-Security-Agent-Skills    https://github.com/BagelHole/DevOps-Security-Agent-Skills
#   intellectronica/agent-skills              https://github.com/intellectronica/agent-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave10-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave10-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
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

"Fullstack Wave 10 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Prisma 瀹樻柟鍏ㄩ噺 ---
Install-SkillBatch -Label "prisma-official" -Repo "https://github.com/prisma/skills" -All

# --- FastAPI 娣卞寲 ---
Install-SkillBatch -Label "fastapi-antigravity" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "fastapi-router-py","python-fastapi-development","fastapi-templates"
)

# --- WordPress 鍐呭 / Elementor ---
Install-SkillBatch -Label "wordpress-jezweb" -Repo "https://github.com/jezweb/claude-skills" -Skills @(
    "wordpress-content","wordpress-elementor"
)

# --- MCP / LLM 瀹夊叏涓庢垚鏈?---
Install-SkillBatch -Label "mcp-llm-security" -Repo "https://github.com/BagelHole/DevOps-Security-Agent-Skills" -Skills @(
    "mcp-server-security","llm-caching","llm-cost-optimization",
    "ai-agent-security","prompt-injection-defense","agent-evals"
)

# --- SRE / 杩愮淮鎵嬪唽 ---
Install-SkillBatch -Label "sre-runbooks" -Repo "https://github.com/BagelHole/DevOps-Security-Agent-Skills" -Skills @(
    "incident-management","runbook-creation","disaster-recovery","ai-sre-incident-response"
)

# --- 鎼滅储 / KV 宸ュ叿 ---
Install-SkillBatch -Label "search-tools" -Repo "https://github.com/intellectronica/agent-skills" -Skills @(
    "tavily","mgrep-code-search","upstash-redis-kv"
)

"`nWave 10 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 10 complete: $summaryFile" -ForegroundColor Green
