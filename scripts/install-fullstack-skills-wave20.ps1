# Wave 20 - Spring/Flask/Celery / Three.js WebGL / GCP Azure / Pulumi / WASM
#
# Sources (skills.sh, GitHub mirror):
#   Jeffallan/claude-skills            https://github.com/Jeffallan/claude-skills
#   github/awesome-copilot             https://github.com/github/awesome-copilot
#   sivaprasadreddy/sivalabs-agent-skills https://github.com/sivaprasadreddy/sivalabs-agent-skills
#   aj-geddes/useful-ai-prompts         https://github.com/aj-geddes/useful-ai-prompts
#   affaan-m/everything-claude-code     https://github.com/affaan-m/everything-claude-code
#   davila7/claude-code-templates       https://github.com/davila7/claude-code-templates
#   cloudai-x/threejs-skills            https://github.com/cloudai-x/threejs-skills
#   freshtechbro/claudedesignskills     https://github.com/freshtechbro/claudedesignskills
#   google/skills                       https://github.com/google/skills
#   microsoft/azure-skills              https://github.com/microsoft/azure-skills
#   pulumi/agent-skills                 https://github.com/pulumi/agent-skills
#   cosmonic-labs/skills                https://github.com/cosmonic-labs/skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave20-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave20"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 20 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Java / Spring Boot ---
Run-SkillBatch -Label "spring-jeffallan" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @("spring-boot-engineer","java-architect")
Run-SkillBatch -Label "spring-copilot" -Repo "https://github.com/github/awesome-copilot" -Skills @("create-spring-boot-java-project")
Run-SkillBatch -Label "spring-sivalabs" -Repo "https://github.com/sivaprasadreddy/sivalabs-agent-skills" -Skills @("spring-boot-skill")

# --- Python backend (Flask / Celery) ---
Run-SkillBatch -Label "flask-ajgeddes" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @("flask-api-development")
Run-SkillBatch -Label "celery-affaan" -Repo "https://github.com/affaan-m/everything-claude-code" -Skills @("django-celery")

# --- Job queue ---
Run-SkillBatch -Label "bullmq-davila7" -Repo "https://github.com/davila7/claude-code-templates" -Skills @("bullmq-specialist")

# --- Three.js / WebGL ---
Run-SkillBatch -Label "threejs-core" -Repo "https://github.com/cloudai-x/threejs-skills" -Skills @(
    "threejs-fundamentals","threejs-animation","threejs-shaders","threejs-materials","threejs-postprocessing"
)
Run-SkillBatch -Label "threejs-webgl" -Repo "https://github.com/freshtechbro/claudedesignskills" -Skills @("threejs-webgl")

# --- Google Cloud Platform ---
Run-SkillBatch -Label "gcp-google-skills" -Repo "https://github.com/google/skills" -Skills @(
    "gcloud","cloud-run-basics","bigquery-basics","google-cloud-recipe-auth","google-cloud-recipe-onboarding"
)
Run-SkillBatch -Label "gcp-vertex-agent" -Repo "https://github.com/google/skills" -Skills @(
    "agent-platform-rag-engine-management","agent-platform-deploy","bigquery-ai-ml"
)

# --- Azure deepening ---
Run-SkillBatch -Label "azure-microsoft" -Repo "https://github.com/microsoft/azure-skills" -Skills @(
    "azure-compute","azure-rbac","azure-reliability","azure-cost"
)

# --- Pulumi + WASM ---
Run-SkillBatch -Label "pulumi-esc" -Repo "https://github.com/pulumi/agent-skills" -Skills @("pulumi-esc")
Run-SkillBatch -Label "wasm-cosmonic" -Repo "https://github.com/cosmonic-labs/skills" -Skills @("webassembly-component-development")

"`nWave 20 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 20 complete: $summaryFile" -ForegroundColor Green
