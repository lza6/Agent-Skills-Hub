# Wave 34 - han 扫尾（Mobile/Langs/CI/SRE/Linters/Agent）+ jezweb Cloud/Shopify/UX
#
# Sources (skills.sh, GitHub mirror):
#   thebushidocollective/han            https://github.com/thebushidocollective/han
#   jezweb/claude-skills                 https://github.com/jezweb/claude-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave34-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave34"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 34 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Mobile (Android / Kotlin / RN / iOS) ---
# Note: han CLI names differ from install folder names for Kotlin/CocoaPods
Run-SkillBatch -Label "mobile-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "android-architecture","android-jetpack-compose","Kotlin Coroutines","Kotlin DSL Patterns","Kotlin Null Safety",
    "react-native-native-modules","react-native-performance","react-native-web-testing",
    "ios-uikit-architecture","cocoapods-podspec-fundamentals","cocoapods-privacy-manifests","cocoapods-subspecs-organization"
)

# --- 语言深化 (Crystal / C# / Erlang / Gleam / Lua) ---
Run-SkillBatch -Label "langs-han-1" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "crystal-concurrency","crystal-macros","csharp-async-patterns","csharp-linq","csharp-nullable-types",
    "Erlang Concurrency","Erlang Distribution","Gleam Erlang Interop","Lua C Integration"
)

# --- ObjC / Swift / Ruby / PHP ---
Run-SkillBatch -Label "langs-han-2" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "Objective-C ARC Patterns","Objective-C Blocks and GCD","Objective-C Protocols and Categories",
    "Swift Protocol-Oriented Programming","ruby-gems-bundler","ruby-oop","PHP Composer and Autoloading"
)

# --- 测试 / CI / BDD ---
Run-SkillBatch -Label "testing-ci-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "cypress-ci-cd","mocha-configuration","junit-extensions","testng-parallel",
    "bdd-collaboration","graphql-inspector-ci","gitlab-ci-best-practices","gitlab-ci-artifacts-caching"
)

# --- DevOps / SRE / IaC ---
Run-SkillBatch -Label "devops-sre-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "ansible-inventory","ansible-roles","kustomize-generators","pulumi-basics",
    "sre-monitoring-and-observability","sre-reliability-engineering","runbooks-structure",
    "gitlab-ci-pipeline-configuration","gitlab-ci-job-configuration","gitlab-ci-variables-secrets","mise-environment-management"
)

# --- Linter / Validator 补全 ---
Run-SkillBatch -Label "linters-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "ameba-custom-rules","ameba-integration","checkstyle-custom","checkstyle-rules",
    "credo-checks","credo-custom-checks","dialyzer-analysis","dialyzer-integration",
    "eslint-custom","markdownlint-custom-rules","markdownlint-integration","pylint-checkers","shfmt-formatting"
)

# --- han Agent / 工作流工具 ---
Run-SkillBatch -Label "agent-tools-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "claude-agent-sdk-agent-creation","claude-agent-sdk-context-management","git-worktrees-worktree-management",
    "resume-from-pr","search-code","claude-agent-sdk-tool-integration","mise-tool-management",
    "token-efficiency","project-memory"
)

# --- 工程原则 / Effect / Blueprints ---
Run-SkillBatch -Label "principles-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "atomic-design-integration","atomic-design-quarks","boy-scout-rule","legacy-code-safety",
    "orthogonality-principle","simplicity-principles","structural-design-principles",
    "effect-resource-management","blueprints-maintenance","blueprints-organization"
)

# --- jezweb Cloud / Shopify / UX ---
Run-SkillBatch -Label "jezweb-cloud-ux" -Repo "https://github.com/jezweb/claude-skills" -Skills @(
    "cloudflare-api","cloudflare-worker-builder","d1-migration","github-release","fork-discipline",
    "shopify-products","shopify-setup","ux-audit","ux-compare","ux-extract","onboarding-ux","vite-flare-starter"
)

"`nWave 34 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 34 complete: $summaryFile" -ForegroundColor Green
