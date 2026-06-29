# Wave 18 - n8n / Temporal / Neon / Vector DB / Drizzle tRPC Zod / NestJS / Build tools
#
# Sources (skills.sh, GitHub mirror enabled):
#   czlonkowski/n8n-skills              https://github.com/czlonkowski/n8n-skills
#   temporalio/skill-temporal-developer  https://github.com/temporalio/skill-temporal-developer
#   temporalio/skill-temporal-cloud      https://github.com/temporalio/skill-temporal-cloud
#   neondatabase/agent-skills            https://github.com/neondatabase/agent-skills
#   mindrally/skills                     https://github.com/mindrally/skills
#   bobmatnyc/claude-mpm-skills          https://github.com/bobmatnyc/claude-mpm-skills
#   pproenca/dot-skills                  https://github.com/pproenca/dot-skills
#   jezweb/claude-skills                 https://github.com/jezweb/claude-skills
#   kadajett/agent-nestjs-skills         https://github.com/kadajett/agent-nestjs-skills
#   elastic/agent-skills                 https://github.com/elastic/agent-skills
#   timescale/pg-aiguide                 https://github.com/timescale/pg-aiguide
#   qdrant/skills                        https://github.com/qdrant/skills
#   weaviate/agent-skills                https://github.com/weaviate/agent-skills
#   pinecone-io/skills                   https://github.com/pinecone-io/skills
#   tursodatabase/turso                  https://github.com/tursodatabase/turso
#   mohitmishra786/low-level-dev-skills  https://github.com/mohitmishra786/low-level-dev-skills
#   leokemp223/embed-ai-tool             https://github.com/leokemp223/embed-ai-tool
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave18-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave18"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 18 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- n8n workflow automation ---
Run-SkillBatch -Label "n8n-core" -Repo "https://github.com/czlonkowski/n8n-skills" -Skills @(
    "n8n-workflow-patterns","n8n-mcp-tools-expert","n8n-node-configuration","n8n-code-javascript","n8n-error-handling"
)

# --- Temporal ---
Run-SkillBatch -Label "temporal-developer" -Repo "https://github.com/temporalio/skill-temporal-developer" -Skills @("temporal-developer")
Run-SkillBatch -Label "temporal-cloud" -Repo "https://github.com/temporalio/skill-temporal-cloud" -Skills @("temporal-cloud")

# --- Neon Postgres ---
Run-SkillBatch -Label "neon-postgres" -Repo "https://github.com/neondatabase/agent-skills" -Skills @("neon-postgres","neon")

# --- TypeScript data stack (Drizzle / tRPC / Zod) ---
Run-SkillBatch -Label "trpc-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("trpc")
Run-SkillBatch -Label "drizzle-giuseppe" -Repo "https://github.com/giuseppe-trisciuoglio/developer-kit" -Skills @("drizzle-orm-patterns")
Run-SkillBatch -Label "zod-dot-skills" -Repo "https://github.com/pproenca/dot-skills" -Skills @("zod")
Run-SkillBatch -Label "drizzle-jezweb" -Repo "https://github.com/jezweb/claude-skills" -Skills @("d1-drizzle-schema")

# --- NestJS best practices ---
Run-SkillBatch -Label "nestjs-best-practices" -Repo "https://github.com/kadajett/agent-nestjs-skills" -Skills @("nestjs-best-practices")

# --- Elasticsearch / Kibana ---
Run-SkillBatch -Label "elastic-kibana" -Repo "https://github.com/elastic/agent-skills" -Skills @(
    "kibana-dashboards","kibana-alerting-rules","elasticsearch-audit","elasticsearch-file-ingest"
)

# --- Vector databases ---
Run-SkillBatch -Label "pgvector-timescale" -Repo "https://github.com/timescale/pg-aiguide" -Skills @("pgvector-semantic-search")
Run-SkillBatch -Label "qdrant-official" -Repo "https://github.com/qdrant/skills" -Skills @("qdrant-clients-sdk")
Run-SkillBatch -Label "weaviate-official" -Repo "https://github.com/weaviate/agent-skills" -Skills @("weaviate","weaviate-cookbooks")
Run-SkillBatch -Label "pinecone-docs" -Repo "https://github.com/pinecone-io/skills" -Skills @("pinecone-docs")

# --- Turso / libSQL ---
Run-SkillBatch -Label "turso-advanced" -Repo "https://github.com/tursodatabase/turso" -Skills @("cdc","index-knowledge","storage-format")

# --- C/C++ build tools ---
Run-SkillBatch -Label "build-tools-lowlevel" -Repo "https://github.com/mohitmishra786/low-level-dev-skills" -Skills @("cmake")
Run-SkillBatch -Label "makefile-akin" -Repo "https://github.com/akin-ozer/cc-devops-skills" -Skills @("makefile-validator")

"`nWave 18 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 18 complete: $summaryFile" -ForegroundColor Green
