# Wave 29 - Storybook / Vitest+Jest / Phoenix+Ecto+Absinthe / Bun / Gleam / Maven / Testing+Monorepo
#
# Sources (skills.sh, GitHub mirror):
#   thebushidocollective/han            https://github.com/thebushidocollective/han
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave29-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave29"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 29 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Storybook 深化 ---
Run-SkillBatch -Label "storybook-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "storybook-configuration","storybook-story-writing","storybook-play-functions",
    "storybook-args-controls","storybook-component-documentation"
)

# --- Vitest / Jest 补全 ---
Run-SkillBatch -Label "vitest-jest-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "vitest-configuration","vitest-testing-patterns","vitest-performance",
    "jest-advanced","jest-configuration","jest-testing-patterns"
)

# --- Phoenix / Ecto / Elixir OTP ---
Run-SkillBatch -Label "phoenix-ecto-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "phoenix-controllers","phoenix-routing","phoenix-patterns","phoenix-views-templates",
    "ecto-changesets","ecto-query-patterns","ecto-schema-patterns","ecto-schemas",
    "elixir-ecto-patterns","elixir-otp-patterns","elixir-pattern-matching"
)

# --- Absinthe GraphQL (Elixir) ---
Run-SkillBatch -Label "absinthe-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "absinthe-schema","absinthe-resolvers","absinthe-subscriptions"
)

# --- Bun 运行时补全 ---
Run-SkillBatch -Label "bun-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "bun-package-manager","bun-bundler","bun-sqlite","bun-testing"
)

# --- Gleam 语言 ---
Run-SkillBatch -Label "gleam-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "Gleam Type System","Gleam Actor Model","Gleam Erlang Interop"
)

# --- Maven 构建 ---
Run-SkillBatch -Label "maven-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "maven-build-lifecycle","maven-dependency-management","maven-plugin-configuration"
)

# --- 测试框架补全 (Cypress/Mocha/JUnit/TestNG/Playwright) ---
Run-SkillBatch -Label "testing-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "cypress-fundamentals","cypress-advanced","mocha-fundamentals","mocha-assertions",
    "playwright-test-architecture","playwright-page-object-model","playwright-fixtures-and-hooks",
    "junit-fundamentals","junit-parameterized","testng-fundamentals","testng-data-driven"
)

# --- Monorepo / 工具链 ---
Run-SkillBatch -Label "monorepo-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "monorepo-architecture","monorepo-tooling","monorepo-workflows",
    "mise-tool-management","syncpack-configuration"
)

"`nWave 29 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 29 complete: $summaryFile" -ForegroundColor Green
