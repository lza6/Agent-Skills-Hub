# 鍏ㄦ爤鎶€鑳?Wave 2 鈥?鑱旂綉琛ュ厖锛圢ext.js / Prisma / Supabase / Stripe / tRPC / shadcn 绛夛級
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave2-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave2-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
    try {
        $output = & npx @skillCliArgs 2>&1 | Out-String
        $output | Out-File $logFile -Encoding utf8
        if ($output -match "Installed \d+ skill" -or $output -match "Installation complete") {
            "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
            return $true
        }
        "FAIL $Label (exit $LASTEXITCODE)" | Tee-Object -FilePath $summaryFile -Append
        return $false
    } catch {
        "ERROR $Label : $_" | Tee-Object -FilePath $summaryFile -Append
        return $false
    }
}

"Fullstack Wave 2 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- 鏁版嵁搴?/ ORM ---
Install-SkillBatch -Label "prisma-core" -Repo "https://github.com/prisma/skills" -Skills @(
    "prisma-database-setup","prisma-client-api","prisma-cli","prisma-postgres",
    "prisma-driver-adapter-implementation","prisma-upgrade-v7"
)
Install-SkillBatch -Label "supabase" -Repo "https://github.com/supabase/agent-skills" -Skills @(
    "supabase","supabase-postgres-best-practices"
)
Install-SkillBatch -Label "drizzle-trpc" -Repo "https://github.com/bobmatnyc/claude-mpm-skills" -Skills @(
    "drizzle-orm","trpc-type-safety"
)
Install-SkillBatch -Label "developer-kit-orm" -Repo "https://github.com/giuseppe-trisciuoglio/developer-kit" -Skills @(
    "drizzle-orm-patterns","shadcn-ui","nestjs"
)

# --- Next.js / React / 鍓嶇 ---
Install-SkillBatch -Label "wshobson-fullstack" -Repo "https://github.com/wshobson/agents" -Skills @(
    "nextjs-app-router-patterns","postgresql-table-design","tailwind-design-system",
    "api-design-principles","react-state-management","react-modernization",
    "typescript-advanced-types","nodejs-backend-patterns","auth-patterns"
)
Install-SkillBatch -Label "clerk-auth0-next" -Repo "https://github.com/clerk/skills" -Skills @("clerk-nextjs-patterns")
Install-SkillBatch -Label "auth0-nextjs" -Repo "https://github.com/auth0/agent-skills" -Skills @("auth0-nextjs")
Install-SkillBatch -Label "shadcn-ui" -Repo "https://github.com/shadcn/ui" -Skills @("shadcn")
Install-SkillBatch -Label "hyperframes-tailwind" -Repo "https://github.com/heygen-com/hyperframes" -Skills @("tailwind")

# --- NestJS / 鍚庣 ---
Install-SkillBatch -Label "nestjs-best-practices" -Repo "https://github.com/kadajett/agent-nestjs-skills" -Skills @("nestjs-best-practices")
Install-SkillBatch -Label "nestjs-patterns-ecc" -Repo "https://github.com/affaan-m/everything-claude-code" -Skills @("nestjs-patterns","docker-patterns")

# --- tRPC / 绫诲瀷瀹夊叏鍏ㄦ爤 ---
Install-SkillBatch -Label "mindrally-trpc" -Repo "https://github.com/mindrally/skills" -Skills @("trpc")
Install-SkillBatch -Label "type-safety-trpc" -Repo "https://github.com/ariegoldkin/ai-agent-hub" -Skills @("type-safety-validation")
Install-SkillBatch -Label "trpc-tanstack-next" -Repo "https://github.com/diegojohnsonl/trpc-tanstack-nextjs" -Skills @("trpc-tanstack-nextjs")

# --- 鏀粯 / GraphQL ---
Install-SkillBatch -Label "stripe-all" -Repo "https://github.com/stripe/ai" -All
Install-SkillBatch -Label "apollo-graphql" -Repo "https://github.com/apollographql/skills" -Skills @("apollo-client")

# --- Antigravity 琛ュ厖 ---
Install-SkillBatch -Label "antigravity-nextjs" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "nextjs-best-practices","nextjs-supabase-auth"
)

# --- 鍏ㄦ爤宸ヤ綔娴?---
Install-SkillBatch -Label "fullstackrecipes" -Repo "https://github.com/andrelandgraf/fullstackrecipes" -Skills @("ralph-loop")

"`nWave 2 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 2 complete: $summaryFile" -ForegroundColor Green
