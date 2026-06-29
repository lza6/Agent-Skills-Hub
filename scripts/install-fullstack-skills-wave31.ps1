# Wave 31 - Python / C++ / C / Java / SRE+Runbooks / Shell / Pytest / Linters / Terraform
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
$summaryFile = Join-Path $logDir "fullstack-wave31-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave31"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 31 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Python 深化 ---
Run-SkillBatch -Label "python-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "python-async-patterns","python-data-classes","python-type-system"
)

# --- C++ / C 系统编程 ---
Run-SkillBatch -Label "cpp-c-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "cpp-modern-features","cpp-smart-pointers","cpp-templates-metaprogramming",
    "c-data-structures","c-memory-management","c-systems-programming"
)

# --- Java 补全 ---
Run-SkillBatch -Label "java-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "java-concurrency","java-generics","java-streams-api"
)

# --- SRE / Runbooks ---
Run-SkillBatch -Label "sre-runbooks-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "runbooks-incident-response","runbooks-structure","runbooks-troubleshooting-guides",
    "sre-incident-response","sre-monitoring-and-observability","sre-reliability-engineering"
)

# --- Shell 脚本 ---
Run-SkillBatch -Label "shell-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "shell-scripting-fundamentals","shell-error-handling","shell-portability","shell-best-practices"
)

# --- Pytest / Pylint ---
Run-SkillBatch -Label "pytest-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "pytest-advanced","pytest-fixtures","pytest-plugins","pylint-configuration","pylint-integration"
)

# --- 多语言 Linter (Biome/ESLint/Checkstyle/Credo) ---
Run-SkillBatch -Label "linters-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "biome-configuration","biome-formatting","biome-linting",
    "eslint-configuration","eslint-rules","checkstyle-configuration","credo-configuration"
)

# --- Terraform State ---
Run-SkillBatch -Label "terraform-han" -Repo "https://github.com/thebushidocollective/han" -Skills @("terraform-state")

"`nWave 31 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 31 complete: $summaryFile" -ForegroundColor Green
