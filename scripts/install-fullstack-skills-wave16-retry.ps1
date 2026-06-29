# Wave 16 补装 — 使用 GitHub 镜像重试此前 TLS 失败的技能
#
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$ErrorActionPreference = "Continue"
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave16-retry-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-Batch {
    param([string]$Label, [string]$Repo, [string[]]$Skills)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -LogDir $logDir -LogPrefix "wave16-retry"
    if ($r.Ok) { "OK  $Label" | Tee-Object -FilePath $summaryFile -Append }
    else { "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append }
    return $r.Ok
}

"Wave 16 retry (mirror) started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

Run-Batch "lambdatest-migration" "https://github.com/LambdaTest/agent-skills" @(
    "test-framework-migration-skill","hyperexecute-skill","pytest-skill","webdriverio-skill"
)

Run-Batch "cypress-official-remaining" "https://github.com/cypress-io/ai-toolkit" @(
    "cypress-docs","cypress-explain"
)

"`nWave 16 retry done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 16 retry complete: $summaryFile" -ForegroundColor Green
