# 鍏ㄦ爤鎶€鑳?Wave 9 鈥?鑱旂綉琛ュ厖锛圖evOps / GitOps / AI Agent / Shopify / Auth 琛ヨ锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   BagelHole/DevOps-Security-Agent-Skills  https://github.com/BagelHole/DevOps-Security-Agent-Skills
#   fluxcd/agent-skills                       https://github.com/fluxcd/agent-skills
#   sickn33/antigravity-awesome-skills        https://github.com/sickn33/antigravity-awesome-skills
#   jeffallan/claude-skills                   https://github.com/jeffallan/claude-skills
#   clerk/skills                              https://github.com/clerk/skills
#   auth0/agent-skills                        https://github.com/auth0/agent-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave9-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave9-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
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

"Fullstack Wave 9 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Docker / 瀹瑰櫒 ---
Install-SkillBatch -Label "devops-containers" -Repo "https://github.com/BagelHole/DevOps-Security-Agent-Skills" -Skills @(
    "docker-management","podman"
)

# --- Kubernetes / Helm / GitOps ---
Install-SkillBatch -Label "devops-k8s" -Repo "https://github.com/BagelHole/DevOps-Security-Agent-Skills" -Skills @(
    "kubernetes-ops","helm-charts","argocd-gitops","kustomize",
    "kubernetes-hardening","gpu-kubernetes-operations","model-serving-kubernetes"
)

# --- 鍚堣 / 瀵嗛挜绠＄悊 ---
Install-SkillBatch -Label "devops-compliance" -Repo "https://github.com/BagelHole/DevOps-Security-Agent-Skills" -Skills @(
    "fedramp-compliance","soc2-compliance","hashicorp-vault"
)

# --- Flux CD GitOps ---
Install-SkillBatch -Label "flux-gitops" -Repo "https://github.com/fluxcd/agent-skills" -Skills @(
    "gitops-knowledge","gitops-repo-audit","gitops-cluster-debug"
)

# --- AI Agent 妗嗘灦 ---
Install-SkillBatch -Label "ai-agents" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "langgraph","crewai"
)

# --- Shopify 鐢熸€?---
Install-SkillBatch -Label "shopify-antigravity" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "shopify-development","shopify-apps"
)
Install-SkillBatch -Label "shopify-jeffallan" -Repo "https://github.com/jeffallan/claude-skills" -Skills @("shopify-expert")

# --- Auth 琛ヨ锛圵ave 2 閬楁紡锛?--
Install-SkillBatch -Label "clerk-auth-retry" -Repo "https://github.com/clerk/skills" -Skills @("clerk-nextjs-patterns")
Install-SkillBatch -Label "auth0-retry" -Repo "https://github.com/auth0/agent-skills" -Skills @("auth0-nextjs")

# --- Django / Playwright 娴嬭瘯 ---
Install-SkillBatch -Label "django-playwright" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @("django-pro")
Install-SkillBatch -Label "playwright-jeffallan" -Repo "https://github.com/jeffallan/claude-skills" -Skills @("playwright-expert")

"`nWave 9 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 9 complete: $summaryFile" -ForegroundColor Green
