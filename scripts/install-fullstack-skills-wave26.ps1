# Wave 26 - FastAPI 深化 / React Native Web / Symfony Pest / K8s+IaC / 反向代理 / Lua+Nim
#
# Sources (skills.sh, GitHub mirror):
#   thebushidocollective/han            https://github.com/thebushidocollective/han
#   makfly/superpowers-symfony          https://github.com/makfly/superpowers-symfony
#   davidcastagnetoa/skills             https://github.com/davidcastagnetoa/skills
#   dimdasci/vps-setup                  https://github.com/dimdasci/vps-setup
#   membranedev/application-skills      https://github.com/membranedev/application-skills
#   aj-geddes/useful-ai-prompts         https://github.com/aj-geddes/useful-ai-prompts
#   patricio0312rev/skills              https://github.com/patricio0312rev/skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave26-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave26"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 26 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- FastAPI 异步 / DI / 校验 (han) ---
Run-SkillBatch -Label "fastapi-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "fastapi-async-patterns","fastapi-dependency-injection","fastapi-validation"
)

# --- React Native Web ---
Run-SkillBatch -Label "rnweb-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "react-native-web-core","react-native-web-navigation","react-native-web-performance","react-native-web-styling"
)

# --- Symfony Pest / Scheduler ---
Run-SkillBatch -Label "symfony-pest-makfly" -Repo "https://github.com/makfly/superpowers-symfony" -Skills @(
    "symfony:tdd-with-pest","symfony:symfony-scheduler"
)

# --- K8s Kustomize / Manifests ---
Run-SkillBatch -Label "k8s-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "kustomize-basics","kustomize-overlays","kubernetes-manifests","kubernetes-resources","kubernetes-security"
)

# --- Terraform / Pulumi IaC ---
Run-SkillBatch -Label "iac-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "terraform-modules","terraform-configuration","pulumi-stacks","pulumi-components"
)
Run-SkillBatch -Label "terraform-patricio" -Repo "https://github.com/patricio0312rev/skills" -Skills @("terraform-module-builder")

# --- 反向代理 / Service Mesh ---
Run-SkillBatch -Label "proxy-traefik" -Repo "https://github.com/davidcastagnetoa/skills" -Skills @("traefik")
Run-SkillBatch -Label "proxy-caddy" -Repo "https://github.com/dimdasci/vps-setup" -Skills @("caddy-reverse-proxy")
Run-SkillBatch -Label "proxy-haproxy" -Repo "https://github.com/membranedev/application-skills" -Skills @("haproxy")
Run-SkillBatch -Label "mesh-ajgeddes" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @("service-mesh-implementation")

# --- Lua / Nim 补全 ---
Run-SkillBatch -Label "lua-nim-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "Lua Coroutines","Lua Tables Patterns","Nim C Interop"
)

"`nWave 26 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 26 complete: $summaryFile" -ForegroundColor Green
