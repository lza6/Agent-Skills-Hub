# 鍏ㄦ爤鎶€鑳?Wave 8 鈥?鑱旂綉琛ュ厖锛圥ayments / Observability / DevOps / PM 宸ュ叿闆嗘垚锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   stripe/ai                        https://github.com/stripe/ai
#   getsentry/skills                 https://github.com/getsentry/skills
#   openai/skills                    https://github.com/openai/skills
#   datadog-labs/agent-skills        https://github.com/datadog-labs/agent-skills
#   intellectronica/agent-skills     https://github.com/intellectronica/agent-skills
#   schpet/linear-cli                https://github.com/schpet/linear-cli
#   addyosmani/agent-skills          https://github.com/addyosmani/agent-skills
#   xixu-me/skills                   https://github.com/xixu-me/skills
#   microsoft/azure-skills           https://github.com/microsoft/azure-skills
#   github/awesome-copilot           https://github.com/github/awesome-copilot  (mcp-cli 琛ヨ)
#   different-ai/openwork            https://github.com/different-ai/openwork  (solidjs 琛ヨ)
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave8-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave8-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
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

"Fullstack Wave 8 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Stripe 瀹樻柟 ---
Install-SkillBatch -Label "stripe-official" -Repo "https://github.com/stripe/ai" -Skills @(
    "stripe-best-practices","stripe-directory","stripe-projects","upgrade-stripe","connect-recommend"
)

# --- Sentry 浠ｇ爜瀹℃煡 / 瀹夊叏 ---
Install-SkillBatch -Label "sentry-review" -Repo "https://github.com/getsentry/skills" -Skills @(
    "security-review","code-review","find-bugs","gha-security-review","skill-scanner"
)

# --- OpenAI 瀹樻柟锛歀inear / Notion / Sentry / CI / Vercel ---
Install-SkillBatch -Label "openai-integrations" -Repo "https://github.com/openai/skills" -Skills @(
    "linear","notion-knowledge-capture","notion-meeting-intelligence",
    "notion-research-documentation","notion-spec-to-implementation",
    "sentry","gh-fix-ci","vercel-deploy"
)

# --- Datadog 鍙娴嬫€?---
Install-SkillBatch -Label "datadog" -Repo "https://github.com/datadog-labs/agent-skills" -Skills @("agent-skills")

# --- Notion REST API ---
Install-SkillBatch -Label "notion-api" -Repo "https://github.com/intellectronica/agent-skills" -Skills @("notion-api")

# --- Linear CLI ---
Install-SkillBatch -Label "linear-cli" -Repo "https://github.com/schpet/linear-cli" -Skills @("linear-cli")

# --- CI/CD ---
Install-SkillBatch -Label "cicd-automation" -Repo "https://github.com/addyosmani/agent-skills" -Skills @("ci-cd-and-automation")
Install-SkillBatch -Label "github-actions-docs" -Repo "https://github.com/xixu-me/skills" -Skills @("github-actions-docs")

# --- Azure 璇婃柇 / 鍙娴嬫€?---
Install-SkillBatch -Label "azure-observability" -Repo "https://github.com/microsoft/azure-skills" -Skills @(
    "azure-diagnostics","appinsights-instrumentation"
)

# --- Wave 7 琛ヨ ---
Install-SkillBatch -Label "mcp-cli-retry" -Repo "https://github.com/github/awesome-copilot" -Skills @("mcp-cli")
# solidjs-patterns 宸蹭粠 different-ai/openwork 涓嬫灦锛岃烦杩囷紙瑙?logs/wave8-solidjs-retry.log锛?

"`nWave 8 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 8 complete: $summaryFile" -ForegroundColor Green
