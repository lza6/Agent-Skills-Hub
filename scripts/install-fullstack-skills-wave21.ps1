# Wave 21 - Ruby/Rails / Go microservices / K8s / Shopify / WooCommerce
#
# Sources (skills.sh, GitHub mirror):
#   Jeffallan/claude-skills            https://github.com/Jeffallan/claude-skills
#   mindrally/skills                     https://github.com/mindrally/skills
#   aj-geddes/useful-ai-prompts         https://github.com/aj-geddes/useful-ai-prompts
#   pproenca/dot-skills                  https://github.com/pproenca/dot-skills
#   thehotwireclub/hotwire_club-skills   https://github.com/thehotwireclub/hotwire_club-skills
#   shopify/shopify-ai-toolkit          https://github.com/shopify/shopify-ai-toolkit
#   woocommerce/woocommerce             https://github.com/woocommerce/woocommerce
#   teachingai/full-stack-skills        https://github.com/teachingai/full-stack-skills
#   personamanagmentlayer/pcl           https://github.com/personamanagmentlayer/pcl
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave21-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave21"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 21 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Kubernetes specialist (补装 manifest 缺失项) ---
Run-SkillBatch -Label "k8s-jeffallan" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @("kubernetes-specialist")

# --- Ruby / Rails / Hotwire ---
Run-SkillBatch -Label "ruby-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("ruby-rails")
Run-SkillBatch -Label "ruby-ajgeddes" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @("ruby-rails-application")
Run-SkillBatch -Label "rails-hotwire" -Repo "https://github.com/pproenca/dot-skills" -Skills @("rails-hotwire")
Run-SkillBatch -Label "hotwire-stimulus" -Repo "https://github.com/thehotwireclub/hotwire_club-skills" -Skills @("hwc-stimulus-fundamentals")

# --- Shopify 官方 AI Toolkit ---
Run-SkillBatch -Label "shopify-official-core" -Repo "https://github.com/shopify/shopify-ai-toolkit" -Skills @(
    "shopify-admin","shopify-dev","shopify-liquid","shopify-hydrogen","shopify-functions"
)
Run-SkillBatch -Label "shopify-official-ext" -Repo "https://github.com/shopify/shopify-ai-toolkit" -Skills @(
    "shopify-custom-data","shopify-storefront-graphql","shopify-use-shopify-cli"
)

# --- WooCommerce ---
Run-SkillBatch -Label "woocommerce-official" -Repo "https://github.com/woocommerce/woocommerce" -Skills @(
    "woocommerce-backend-dev","woocommerce-code-review"
)

# --- Go microservices ---
Run-SkillBatch -Label "go-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("go-backend-microservices")
Run-SkillBatch -Label "go-web-beagle" -Repo "https://github.com/existential-birds/beagle" -Skills @("go-web-expert")

# --- GitOps ArgoCD ---
Run-SkillBatch -Label "argocd-pcl" -Repo "https://github.com/personamanagmentlayer/pcl" -Skills @("argocd-expert")

"`nWave 21 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 21 complete: $summaryFile" -ForegroundColor Green
