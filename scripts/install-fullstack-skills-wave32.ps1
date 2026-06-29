# Wave 32 - TypeScript / Figma / Sentry / Design / Prettier+Markdown / Rust+Clippy / SOLID / Engineering
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
$summaryFile = Join-Path $logDir "fullstack-wave32-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave32"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 32 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- TypeScript 深化 ---
Run-SkillBatch -Label "typescript-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "typescript-async-patterns","typescript-type-system","typescript-utility-types"
)

# --- Figma 设计转代码 ---
Run-SkillBatch -Label "figma-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "figma-analyze-frame","figma-extract-tokens","figma-generate-component","figma-sync-design-system"
)

# --- Sentry 运维补全 ---
Run-SkillBatch -Label "sentry-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "sentry-alerts-issues","sentry-release-management"
)

# --- UI/UX 设计 (jezweb) ---
Run-SkillBatch -Label "design-jezweb" -Repo "https://github.com/jezweb/claude-skills" -Skills @(
    "design-loop","design-review","design-system","landing-page","product-showcase","tailwind-theme-builder"
)

# --- Prettier / Markdown ---
Run-SkillBatch -Label "docs-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "prettier-configuration","prettier-integration","prettier-plugins",
    "markdown-documentation","markdown-syntax-fundamentals","markdown-tables","markdownlint-configuration"
)

# --- Rust / Clippy ---
Run-SkillBatch -Label "rust-clippy-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "rust-error-handling","rust-ownership-system","clippy-configuration","clippy-lints","clippy-custom"
)

# --- OOP / SOLID ---
Run-SkillBatch -Label "solid-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "oop-encapsulation","oop-inheritance-composition","oop-polymorphism","solid-principles"
)

# --- 工程实践 (han core skills) ---
Run-SkillBatch -Label "engineering-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "architect","document","optimize"
)

# --- 杂项补全 (Cucumber/Crystal/Erlang/Shell/Monorepo) ---
Run-SkillBatch -Label "misc-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "cucumber-fundamentals","cucumber-step-definitions","cucumber-best-practices",
    "ameba-configuration","dialyzer-configuration","shfmt-configuration","syncpack-version-groups"
)

"`nWave 32 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 32 complete: $summaryFile" -ForegroundColor Green
