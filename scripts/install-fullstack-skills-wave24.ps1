# Wave 24 - Datadog / Symfony API Platform / Kotlin Compose / Niche langs / Akka
#
# Sources (skills.sh, GitHub mirror):
#   datadog-labs/agent-skills           https://github.com/datadog-labs/agent-skills
#   membranedev/application-skills      https://github.com/membranedev/application-skills
#   makfly/superpowers-symfony          https://github.com/makfly/superpowers-symfony
#   thebushidocollective/han            https://github.com/thebushidocollective/han
#   affaan-m/everything-claude-code     https://github.com/affaan-m/everything-claude-code
#   vitorpamplona/amethyst              https://github.com/vitorpamplona/amethyst
#   0xbigboss/claude-code               https://github.com/0xbigboss/claude-code
#   sickn33/antigravity-awesome-skills  https://github.com/sickn33/antigravity-awesome-skills
#   metabase/metabase                   https://github.com/metabase/metabase
#   aaronontheweb/dotnet-skills         https://github.com/aaronontheweb/dotnet-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave24-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave24"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 24 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Datadog official ---
Run-SkillBatch -Label "datadog-official" -Repo "https://github.com/datadog-labs/agent-skills" -Skills @("agent-skills")
# dd-pup / dd-logs 当前仓库仅暴露 agent-skills（skills.sh 目录已过期）

# --- Distributed tracing / Honeycomb ---
Run-SkillBatch -Label "membrane-obs" -Repo "https://github.com/membranedev/application-skills" -Skills @(
    "jaegertracing","honeycombio"
)

# --- Symfony API Platform ---
Run-SkillBatch -Label "symfony-api-makfly" -Repo "https://github.com/makfly/superpowers-symfony" -Skills @(
    "symfony:api-platform-security",
    "symfony:api-platform-filters",
    "symfony:api-platform-state-providers",
    "symfony:api-platform-versioning"
)

# --- Kotlin / Android Compose / KMP ---
Run-SkillBatch -Label "android-compose-han" -Repo "https://github.com/thebushidocollective/han" -Skills @("android-jetpack-compose")
Run-SkillBatch -Label "kmp-affaan" -Repo "https://github.com/affaan-m/everything-claude-code" -Skills @(
    "compose-multiplatform-patterns","fsharp-testing"
)
Run-SkillBatch -Label "kmp-amethyst" -Repo "https://github.com/vitorpamplona/amethyst" -Skills @("kotlin-multiplatform")

# --- Niche languages: Zig / Haskell / Clojure / Erlang ---
Run-SkillBatch -Label "zig-bigboss" -Repo "https://github.com/0xbigboss/claude-code" -Skills @("zig-best-practices")
Run-SkillBatch -Label "haskell-sickn33" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @("haskell-pro")
Run-SkillBatch -Label "clojure-metabase" -Repo "https://github.com/metabase/metabase" -Skills @("clojure-write","clojure-review")
Run-SkillBatch -Label "erlang-han" -Repo "https://github.com/thebushidocollective/han" -Skills @("Erlang OTP Behaviors")
# 安装后目录名: erlang-otp-behaviors

# --- Scala / Crystal (han 仓库) ---
Run-SkillBatch -Label "scala-crystal-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "Scala Collections","Scala Functional Patterns","Scala Type System","crystal-engineer"
)

# --- Akka.NET ---
Run-SkillBatch -Label "akka-dotnet" -Repo "https://github.com/aaronontheweb/dotnet-skills" -Skills @("akka-net-best-practices")

"`nWave 24 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 24 complete: $summaryFile" -ForegroundColor Green
