# 鍏ㄦ爤鎶€鑳?Wave 13 鈥?鑱旂綉琛ュ厖锛圠angChain / LangSmith / Snowflake / Databricks / dbt / MongoDB锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   langchain-ai/langchain-skills        https://github.com/langchain-ai/langchain-skills
#   langchain-ai/langsmith-skills        https://github.com/langchain-ai/langsmith-skills
#   mongodb/agent-skills                 https://github.com/mongodb/agent-skills
#   snowflake-labs/subagent-cortex-code  https://github.com/snowflake-labs/subagent-cortex-code
#   github/awesome-copilot               https://github.com/github/awesome-copilot (snowflake-semanticview)
#   databricks-solutions/ai-dev-kit      https://github.com/databricks-solutions/ai-dev-kit
#   dbt-labs/dbt-agent-skills            https://github.com/dbt-labs/dbt-agent-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave13-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave13-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
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

"Fullstack Wave 13 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- LangChain / LangGraph / Deep Agents 瀹樻柟鍏ㄩ噺 ---
Install-SkillBatch -Label "langchain-official" -Repo "https://github.com/langchain-ai/langchain-skills" -All

# --- LangSmith 鍙娴嬫€?---
Install-SkillBatch -Label "langsmith-official" -Repo "https://github.com/langchain-ai/langsmith-skills" -All

# --- MongoDB 琛ヨ ---
Install-SkillBatch -Label "mongodb-remaining" -Repo "https://github.com/mongodb/agent-skills" -Skills @(
    "mongodb-atlas-stream-processing","mongodb-mcp-setup"
)

# --- Snowflake ---
Install-SkillBatch -Label "snowflake-cortex" -Repo "https://github.com/snowflake-labs/subagent-cortex-code" -Skills @("cortex-code")
Install-SkillBatch -Label "snowflake-semantic" -Repo "https://github.com/github/awesome-copilot" -Skills @("snowflake-semanticview")

# --- Databricks ---
Install-SkillBatch -Label "databricks-devkit" -Repo "https://github.com/databricks-solutions/ai-dev-kit" -Skills @(
    "databricks-python-sdk","python-dev"
)

# --- dbt 鏁版嵁宸ョ▼ ---
Install-SkillBatch -Label "dbt-analytics" -Repo "https://github.com/dbt-labs/dbt-agent-skills" -Skills @(
    "configuring-dbt-mcp-server","answering-natural-language-questions-with-dbt",
    "building-dbt-semantic-layer","running-dbt-commands","using-dbt-for-analytics-engineering",
    "fetching-dbt-docs","troubleshooting-dbt-job-errors"
)

"`nWave 13 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 13 complete: $summaryFile" -ForegroundColor Green
