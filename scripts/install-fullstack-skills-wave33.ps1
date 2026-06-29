# Wave 33 - GitHub Actions / Docker Compose / Stripe / Sentry Ops / Fnox / Git / SOP / PR / React+Expo / jezweb 扫尾
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
$summaryFile = Join-Path $logDir "fullstack-wave33-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave33"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 33 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- GitHub Actions (act) ---
Run-SkillBatch -Label "github-actions-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "act-docker-setup","act-local-testing","act-workflow-syntax"
)

# --- Docker Compose 深化 ---
Run-SkillBatch -Label "docker-compose-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "docker-compose-basics","docker-compose-networking","docker-compose-production"
)

# --- Stripe (jezweb) ---
Run-SkillBatch -Label "stripe-jezweb" -Repo "https://github.com/jezweb/claude-skills" -Skills @("stripe-payments")

# --- Sentry 运维操作 ---
Run-SkillBatch -Label "sentry-ops-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "investigate-errors","query-events","check-releases","analyze-performance"
)

# --- Fnox 密钥管理 ---
Run-SkillBatch -Label "fnox-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "fnox-configuration","fnox-providers","fnox-security-best-practices"
)

# --- Git 工作流 / Storytelling ---
Run-SkillBatch -Label "git-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "git-storytelling-commit-strategy","git-storytelling-branch-strategy","git-storytelling-commit-messages","git-workflow"
)

# --- SOP / Blueprints 文档 ---
Run-SkillBatch -Label "sop-blueprints-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "create-sop","sop-authoring","sop-structure","sop-maintenance",
    "blueprints-writing","create-blueprint","generate-blueprints"
)

# --- PR / MR 工作流 (GitHub + GitLab) ---
Run-SkillBatch -Label "pr-mr-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "load-pr-context","load-mr-context","review-mr","create-mr","monitor-pipeline","view-pipeline"
)

# --- React Native / Expo 补全 ---
Run-SkillBatch -Label "react-expo-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "react-patterns","react-native-components","react-native-navigation","react-native-styling","react-native-platform",
    "expo-config","expo-modules","expo-updates","expo-build"
)

# --- jezweb 项目/协作工具 ---
Run-SkillBatch -Label "jezweb-misc" -Repo "https://github.com/jezweb/claude-skills" -Skills @(
    "codex-review","gws-setup","google-apps-script","project-docs","project-health","roadmap","team-update","shopify-content"
)

"`nWave 33 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 33 complete: $summaryFile" -ForegroundColor Green
