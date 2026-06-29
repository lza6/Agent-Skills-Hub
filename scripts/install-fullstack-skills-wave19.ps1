# Wave 19 - AI observability / LLM eval / multi-model SDK / Frontend UI deepening
#
# Sources (skills.sh, GitHub mirror):
#   langfuse/skills                    https://github.com/langfuse/skills
#   Jeffallan/claude-skills            https://github.com/Jeffallan/claude-skills
#   github/awesome-copilot             https://github.com/github/awesome-copilot
#   datadog-labs/agent-skills          https://github.com/datadog-labs/agent-skills
#   google/skills                      https://github.com/google/skills
#   openai/skills                      https://github.com/openai/skills
#   shadcn/ui                          https://github.com/shadcn/ui
#   heygen-com/hyperframes             https://github.com/heygen-com/hyperframes
#   hyf0/vue-skills                    https://github.com/hyf0/vue-skills
#   ejirocodes/agent-skills            https://github.com/ejirocodes/agent-skills
#   sveltejs/ai-tools                  https://github.com/sveltejs/ai-tools
#   dalestudy/skills                   https://github.com/dalestudy/skills
#   jezweb/claude-skills               https://github.com/jezweb/claude-skills
#   clerk/skills                       https://github.com/clerk/skills
#   antfu/skills                       https://github.com/antfu/skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave19-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave19"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 19 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- LLM observability / eval / prompts ---
Run-SkillBatch -Label "langfuse-official" -Repo "https://github.com/langfuse/skills" -Skills @("langfuse")
Run-SkillBatch -Label "prompt-engineer-jeffallan" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @("prompt-engineer")
Run-SkillBatch -Label "llm-eval-copilot" -Repo "https://github.com/github/awesome-copilot" -Skills @("eval-driven-dev")
# datadog-labs/agent-skills 仓库仅含 agent-skills 单技能，llm-obs-trace-rca 已不可用

# --- Multi-model SDK (Google Gemini / OpenAI) ---
Run-SkillBatch -Label "google-gemini-api" -Repo "https://github.com/google/skills" -Skills @("gemini-api")
Run-SkillBatch -Label "openai-skills" -Repo "https://github.com/openai/skills" -Skills @("pdf","security-best-practices","gh-fix-ci")

# --- UI: shadcn + Tailwind ---
Run-SkillBatch -Label "shadcn-official" -Repo "https://github.com/shadcn/ui" -Skills @("shadcn")
Run-SkillBatch -Label "tailwind-paulrberg" -Repo "https://github.com/paulrberg/agent-skills" -Skills @("tailwind-css")

# --- Vue ecosystem ---
Run-SkillBatch -Label "vue-hyf0-advanced" -Repo "https://github.com/hyf0/vue-skills" -Skills @(
    "vue-debug-guides","vue-pinia-best-practices","vue-router-best-practices","vue-testing-best-practices"
)
Run-SkillBatch -Label "vue-antfu" -Repo "https://github.com/antfu/skills" -Skills @("vue")

# --- Svelte 5 ---
Run-SkillBatch -Label "svelte5-ejirocodes" -Repo "https://github.com/ejirocodes/agent-skills" -Skills @("svelte5-best-practices")
Run-SkillBatch -Label "svelte-core-official" -Repo "https://github.com/sveltejs/ai-tools" -Skills @("svelte-core-bestpractices")

# --- Storybook + Hono + Clerk Astro ---
Run-SkillBatch -Label "storybook-dalestudy" -Repo "https://github.com/dalestudy/skills" -Skills @("storybook")
Run-SkillBatch -Label "hono-jezweb" -Repo "https://github.com/jezweb/claude-skills" -Skills @("hono-api-scaffolder","hono-routing")
Run-SkillBatch -Label "clerk-astro" -Repo "https://github.com/clerk/skills" -Skills @("clerk-astro-patterns")

"`nWave 19 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 19 complete: $summaryFile" -ForegroundColor Green
