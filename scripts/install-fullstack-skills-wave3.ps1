# 鍏ㄦ爤鎶€鑳?Wave 3 鈥?鑱旂綉琛ュ厖锛圞8s / AWS / GraphQL / Remix / Hono / Astro / Playwright / 鏋舵瀯锛?
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave3-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave3-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
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

"Fullstack Wave 3 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- AWS 瀹樻柟宸ュ叿鍖咃紙skills.sh 鐑棬锛?--
Install-SkillBatch -Label "aws-core" -Repo "https://github.com/aws/agent-toolkit-for-aws" -Skills @(
    "aws-iam","aws-serverless","aws-cdk","aws-containers","aws-cloudformation",
    "aws-billing-and-cost-management","amazon-bedrock"
)

# --- 鍩虹璁炬柦 CLI 鍚堥泦锛?Mangesh1/dev-skills-collection锛?--
Install-SkillBatch -Label "dev-skills-infra" -Repo "https://github.com/1Mangesh1/dev-skills-collection" -Skills @(
    "aws-cli","kubernetes","terraform","graphql","docker-compose","nginx",
    "postgres","redis","grpc-protobuf","cloudflare-workers","api-design"
)

# --- K8s 杩愮淮涓撻」 ---
Install-SkillBatch -Label "k8s-agent-skills" -Repo "https://github.com/Aidas-dev/k8s-agent-skills" -Skills @(
    "flux","external-secrets","cert-manager","rook-ceph","cilium-gateway","cilium-network"
)
Install-SkillBatch -Label "mindrally-k8s" -Repo "https://github.com/mindrally/skills" -Skills @("kubernetes")

# --- Remix / React Router ---
Install-SkillBatch -Label "remix-react-router" -Repo "https://github.com/remix-run/agent-skills" -Skills @(
    "react-router-data-mode","react-router-declarative-mode"
)

# --- 鐜颁唬妗嗘灦 ---
Install-SkillBatch -Label "hono" -Repo "https://github.com/yusukebe/hono-skill" -Skills @("hono")
Install-SkillBatch -Label "astro" -Repo "https://github.com/astrolicious/agent-skills" -Skills @("astro")
Install-SkillBatch -Label "better-auth" -Repo "https://github.com/better-auth/skills" -All

# --- 鏋舵瀯 / Drizzle 娣卞寲 ---
Install-SkillBatch -Label "robust-skills" -Repo "https://github.com/ccheney/robust-skills" -Skills @(
    "clean-ddd-hexagonal","feature-slicing","postgres-drizzle","modern-javascript"
)

# --- E2E 娴嬭瘯 ---
Install-SkillBatch -Label "playwright-cli" -Repo "https://github.com/microsoft/playwright-cli" -Skills @("playwright-cli")
Install-SkillBatch -Label "playwright-best-practices" -Repo "https://github.com/currents-dev/playwright-best-practices-skill" -Skills @("playwright-best-practices")

# --- GraphQL 鏈嶅姟绔?---
Install-SkillBatch -Label "apollo-graphql-extra" -Repo "https://github.com/apollographql/skills" -Skills @(
    "apollo-federation","apollo-connectors","graphql-schema"
)

"`nWave 3 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 3 complete: $summaryFile" -ForegroundColor Green
