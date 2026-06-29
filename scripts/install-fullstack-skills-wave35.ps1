# Wave 35 - han 最后扫尾 + jezweb 全量补装 + Jeffallan 专家技能
#
# Sources (skills.sh, GitHub mirror):
#   thebushidocollective/han            https://github.com/thebushidocollective/han
#   jezweb/claude-skills                 https://github.com/jezweb/claude-skills
#   Jeffallan/claude-skills              https://github.com/Jeffallan/claude-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave35-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave35"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 35 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- han: SIP / SOP / Mise / 文档 ---
Run-SkillBatch -Label "han-sip-sop-mise" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "sip-authentication-security","sip-media-negotiation","sip-protocol-fundamentals",
    "sop-rfc2119","update-sop",
    "mise-environment-management","mise-task-configuration",
    "notetaker-fundamentals","code-annotation-patterns","documentation-linking",
    "cocoapods-test-specs","scratch-workspace","android-kotlin-coroutines"
)

# --- han: GitHub/GitLab Issue 工作流 ---
Run-SkillBatch -Label "han-issues" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "create-issue","view-workflow","my-tickets","ticket","issue","my-issues"
)

# --- han: 核心工作流命令 (short names) ---
Run-SkillBatch -Label "han-core-workflows" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "baseline-restorer","professional-honesty","proof-of-work","silent-execution",
    "comment","complete","create","my-tasks","start","task","validate",
    "develop","explain","explicit-configuration","fix","review","test"
)

# --- jezweb 剩余全量 ---
Run-SkillBatch -Label "jezweb-remaining" -Repo "https://github.com/jezweb/claude-skills" -Skills @(
    "ai-image-generator","app-docs","aussie-business-english","award-application","color-palette",
    "db-seed","elevenlabs-agents","favicon-gen","git-workflow","google-chat-messages",
    "gws-install","icon-set-generator","image-processing","nemoclaw-setup","nz-business-english",
    "parcel-tracking","proposal-writer","react-native","react-patterns","responsiveness-check",
    "resume-cover-letter","seo-local-business","social-media-posts","strategy-document",
    "uk-business-english","us-business-english"
)

# --- Jeffallan 专家技能 (1/2) ---
Run-SkillBatch -Label "jeffallan-experts-1" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @(
    "angular-architect","api-designer","atlassian-mcp","chaos-engineer","cli-developer",
    "cloud-architect","code-documenter","cpp-pro","csharp-developer","database-optimizer",
    "debugging-wizard","devops-engineer","dotnet-core-expert","embedded-systems","feature-forge",
    "fine-tuning-expert","flutter-expert","game-developer","golang-pro","javascript-pro",
    "kotlin-specialist","legacy-modernizer","mcp-developer"
)

# --- Jeffallan 专家技能 (2/2) ---
Run-SkillBatch -Label "jeffallan-experts-2" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @(
    "microservices-architect","ml-pipeline","monitoring-expert","nextjs-developer","pandas-pro",
    "postgres-pro","rag-architect","react-expert","rust-engineer","salesforce-developer",
    "secure-code-guardian","security-reviewer","spark-engineer","spec-miner","sql-pro",
    "sre-engineer","swift-expert","terraform-engineer","test-master","the-fool",
    "typescript-pro","vue-expert","vue-expert-js"
)

"`nWave 35 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 35 complete: $summaryFile" -ForegroundColor Green
