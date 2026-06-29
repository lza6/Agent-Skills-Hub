# Wave 27 - Django / GraphQL Relay / Helm / Memcached / iOS+ObjC+Swift
#
# Sources (skills.sh, GitHub mirror):
#   thebushidocollective/han            https://github.com/thebushidocollective/han
#   Jeffallan/claude-skills               https://github.com/Jeffallan/claude-skills
#   aj-geddes/useful-ai-prompts         https://github.com/aj-geddes/useful-ai-prompts
#   facebook/relay                        https://github.com/facebook/relay
#   apollographql/skills                  https://github.com/apollographql/skills
#   personamanagmentlayer/pcl           https://github.com/personamanagmentlayer/pcl
#   nickcrew/claude-ctx-plugin          https://github.com/nickcrew/claude-ctx-plugin
#   jeremylongshore/claude-code-plugins-plus-skills https://github.com/jeremylongshore/claude-code-plugins-plus-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave27-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave27"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 27 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Django 深化 ---
Run-SkillBatch -Label "django-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "django-orm-patterns","django-rest-framework","django-cbv-patterns"
)
Run-SkillBatch -Label "django-jeffallan" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @("django-expert")
Run-SkillBatch -Label "django-ajgeddes" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @("django-application")

# --- GraphQL / Relay / Apollo ---
Run-SkillBatch -Label "graphql-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "graphql-resolvers","graphql-schema-design","graphql-performance",
    "graphql-inspector-validate","graphql-inspector-diff","graphql-inspector-audit"
)
Run-SkillBatch -Label "relay-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "relay-fragments-patterns","relay-mutations-patterns","relay-pagination"
)
Run-SkillBatch -Label "relay-facebook" -Repo "https://github.com/facebook/relay" -Skills @("relay-best-practices")
Run-SkillBatch -Label "apollo-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "apollo-caching-strategies","apollo-client-patterns","apollo-server-patterns"
)
Run-SkillBatch -Label "apollo-official" -Repo "https://github.com/apollographql/skills" -Skills @(
    "apollo-client","apollo-mcp-server"
)

# --- Helm 模板 ---
Run-SkillBatch -Label "helm-han" -Repo "https://github.com/thebushidocollective/han" -Skills @("helm-templates","helm-values")
Run-SkillBatch -Label "helm-pcl" -Repo "https://github.com/personamanagmentlayer/pcl" -Skills @("helm-expert")
Run-SkillBatch -Label "helm-nickcrew" -Repo "https://github.com/nickcrew/claude-ctx-plugin" -Skills @("helm-chart-patterns")

# --- Memcached ---
Run-SkillBatch -Label "memcached-jeremy" -Repo "https://github.com/jeremylongshore/claude-code-plugins-plus-skills" -Skills @("memcached-config-helper")

# --- iOS / Swift / Objective-C (han 技能名含空格) ---
Run-SkillBatch -Label "ios-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "ios-swiftui-patterns","ios-uikit-architecture","ios-swift-concurrency",
    "Swift Protocol-Oriented Programming","Swift Concurrency","Swift Optionals Patterns",
    "Objective-C ARC Patterns","Objective-C Protocols and Categories","Objective-C Blocks and GCD"
)

"`nWave 27 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 27 complete: $summaryFile" -ForegroundColor Green
