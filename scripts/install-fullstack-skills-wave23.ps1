# Wave 23 - Symfony / Observability (Grafana/OTel) / Mobile gaps / Elixir-Phoenix / Rust
#
# Sources (skills.sh, GitHub mirror):
#   grafana/skills                        https://github.com/grafana/skills
#   microsoft/azure-skills                https://github.com/microsoft/azure-skills
#   honeycombio/agent-skill               https://github.com/honeycombio/agent-skill
#   arize-ai/phoenix                      https://github.com/arize-ai/phoenix
#   apollographql/skills                  https://github.com/apollographql/skills
#   Jeffallan/claude-skills               https://github.com/Jeffallan/claude-skills
#   krutikjain/android-agent-skills       https://github.com/krutikjain/android-agent-skills
#   jchaselubitz/drill-app                https://github.com/jchaselubitz/drill-app
#   makfly/superpowers-symfony            https://github.com/makfly/superpowers-symfony
#   mindrally/skills                      https://github.com/mindrally/skills
#   bobmatnyc/claude-mpm-skills           https://github.com/bobmatnyc/claude-mpm-skills
#   getsentry/sentry-for-ai               https://github.com/getsentry/sentry-for-ai
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave23-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave23"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 23 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Observability: Grafana stack + Azure + Honeycomb + Arize Phoenix (LLM) ---
Run-SkillBatch -Label "grafana-official" -Repo "https://github.com/grafana/skills" -Skills @(
    "opentelemetry","dashboarding","promql","grafana-oss","loki"
)
Run-SkillBatch -Label "azure-observability" -Repo "https://github.com/microsoft/azure-skills" -Skills @(
    "appinsights-instrumentation","azure-diagnostics"
)
# azure-observability 已从 microsoft/azure-skills 移除
Run-SkillBatch -Label "honeycomb-obs" -Repo "https://github.com/honeycombio/agent-skill" -Skills @("observability-fundamentals")
Run-SkillBatch -Label "arize-phoenix" -Repo "https://github.com/arize-ai/phoenix" -Skills @("phoenix-cli","phoenix-tracing")

# --- Rust best practices (manifest Wave 5 补装) ---
Run-SkillBatch -Label "rust-apollo" -Repo "https://github.com/apollographql/skills" -Skills @("rust-best-practices")

# --- Mobile: React Native / Android / Expo Router ---
Run-SkillBatch -Label "mobile-jeffallan" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @("react-native-expert")
Run-SkillBatch -Label "android-kotlin" -Repo "https://github.com/krutikjain/android-agent-skills" -Skills @("android-kotlin-core")
Run-SkillBatch -Label "expo-router" -Repo "https://github.com/jchaselubitz/drill-app" -Skills @("expo-router")

# --- Symfony (技能名含冒号，需精确匹配) ---
Run-SkillBatch -Label "symfony-makfly" -Repo "https://github.com/makfly/superpowers-symfony" -Skills @(
    "symfony:doctrine-migrations",
    "symfony:interfaces-and-autowiring",
    "symfony:controller-cleanup"
)
# symfony:quality-checks 已从仓库移除

# --- Elixir / Phoenix / WordPress plugin ---
Run-SkillBatch -Label "elixir-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("elixir","phoenix")
Run-SkillBatch -Label "phoenix-bobmatnyc" -Repo "https://github.com/bobmatnyc/claude-mpm-skills" -Skills @(
    "phoenix-liveview","wordpress-plugin-fundamentals"
)
Run-SkillBatch -Label "sentry-elixir" -Repo "https://github.com/getsentry/sentry-for-ai" -Skills @("sentry-elixir-sdk")

"`nWave 23 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 23 complete: $summaryFile" -ForegroundColor Green
