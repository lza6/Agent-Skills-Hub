# Wave 25 - Symfony 深化 / KMP / Ansible / Sentry SDK / Nim+PHP / Splunk
#
# Sources (skills.sh, GitHub mirror):
#   makfly/superpowers-symfony          https://github.com/makfly/superpowers-symfony
#   chrisbanes/skills                   https://github.com/chrisbanes/skills
#   aj-geddes/useful-ai-prompts         https://github.com/aj-geddes/useful-ai-prompts
#   thebushidocollective/han            https://github.com/thebushidocollective/han
#   getsentry/sentry-for-ai             https://github.com/getsentry/sentry-for-ai
#   mukul975/anthropic-cybersecurity-skills https://github.com/mukul975/anthropic-cybersecurity-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave25-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave25"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 25 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Symfony: Messenger / Cache / TDD / API Platform ---
Run-SkillBatch -Label "symfony-makfly" -Repo "https://github.com/makfly/superpowers-symfony" -Skills @(
    "symfony:symfony-messenger",
    "symfony:symfony-cache",
    "symfony:tdd-with-phpunit",
    "symfony:api-platform-resources",
    "symfony:api-platform-dto-resources"
)

# --- Kotlin Multiplatform 深化 ---
Run-SkillBatch -Label "kmp-chrisbanes" -Repo "https://github.com/chrisbanes/skills" -Skills @("kotlin-multiplatform-expect-actual")

# --- Ansible / 错误追踪 ---
Run-SkillBatch -Label "ansible-ajgeddes" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @(
    "ansible-automation","error-tracking"
)
Run-SkillBatch -Label "ansible-han" -Repo "https://github.com/thebushidocollective/han" -Skills @("ansible-playbooks")

# --- Sentry SDK / 性能监控 ---
Run-SkillBatch -Label "sentry-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "sentry-performance-monitoring","sentry-sdk-configuration","sentry-error-capturing"
)
Run-SkillBatch -Label "sentry-for-ai" -Repo "https://github.com/getsentry/sentry-for-ai" -Skills @(
    "sentry-sdk-setup","sentry-sdk-upgrade"
)

# --- Nim / PHP (han) ---
Run-SkillBatch -Label "nim-php-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "Nim Metaprogramming","Nim Memory Management","PHP Modern Features","PHP Security Patterns"
)

# --- Splunk 日志分析 ---
Run-SkillBatch -Label "splunk-security" -Repo "https://github.com/mukul975/anthropic-cybersecurity-skills" -Skills @(
    "analyzing-security-logs-with-splunk"
)

"`nWave 25 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 25 complete: $summaryFile" -ForegroundColor Green
