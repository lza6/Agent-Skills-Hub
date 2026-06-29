# Wave 41 — alirezarezvani 第四批 / mukul 安全第三批 / antigravity 第四批
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave41-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave41"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Wave 41 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

Run-SkillBatch -Label "alirezarezvani-4" -Repo "https://github.com/alirezarezvani/claude-skills" -Skills @(
    "cfo-advisor","cfo-review","challenge","changelog","changelog-generator","change-management","channel-economics",
    "chaos-experiment","chief-customer-officer-advisor","chief-of-staff","chro-advisor","churn-prevention","ciso-advisor",
    "ciso-review","claude-coach","c-level-agents","c-level-skills","clinical-research","cmd-a11y-audit","cmd-code-to-prd",
    "cmd-cs-aeo","cmd-focused-fix","cmo-advisor","cmo-review","code-to-prd","cold-email","collab-proof","commercial-forecaster",
    "commercial-policy","commercial-skills","company-os","competitive-intel","competitive-matrix","competitive-teardown",
    "competitor-alternatives"
)

Run-SkillBatch -Label "mukul-security-3" -Repo "https://github.com/mukul975/anthropic-cybersecurity-skills" -Skills @(
    "analyzing-typosquatting-domains-with-dnstwist","analyzing-uefi-bootkit-persistence","analyzing-usb-device-connection-history",
    "analyzing-web-server-logs-for-intrusion","analyzing-windows-amcache-artifacts","analyzing-windows-lnk-files-for-artifacts",
    "analyzing-windows-prefetch-with-python","analyzing-windows-registry-for-artifacts","analyzing-windows-shellbag-artifacts",
    "assessing-vector-and-embedding-weaknesses","attacking-entra-id-with-roadtools","attacking-oauth-with-device-code-phishing",
    "auditing-aws-s3-bucket-permissions","auditing-azure-active-directory-configuration","auditing-cloud-with-cis-benchmarks",
    "auditing-entra-id-with-aadinternals","auditing-foundry-smart-contract-security","auditing-gcp-iam-permissions",
    "auditing-kubernetes-cluster-rbac","auditing-kubernetes-rbac-privilege-escalation","auditing-mcp-servers-for-tool-poisoning",
    "auditing-terraform-infrastructure-for-security","auditing-tls-certificate-transparency-logs","auditing-uefi-firmware-with-chipsec",
    "automating-ioc-enrichment","benchmarking-kubernetes-with-kube-bench","building-adversary-infrastructure-tracking-system",
    "building-attack-pattern-library-from-cti-reports","building-automated-malware-submission-pipeline",
    "building-c2-infrastructure-with-sliver-framework","building-c2-redirector-infrastructure","building-cloud-siem-with-sentinel",
    "building-detection-rules-with-sigma","building-detection-rule-with-splunk-spl","building-devsecops-pipeline-with-gitlab-ci"
)

Run-SkillBatch -Label "antigravity-dev4" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "expo-ui-swift-ui","faf-expert","faf-wizard","fal-audio","fal-generate","fal-image-edit","fal-platform","fal-upscale",
    "fal-workflow","family-health-analyzer","fastapi-router-py","favicon","fda-food-safety-auditor","fda-medtech-compliance-auditor",
    "ffuf-claude-skill","ffuf-web-fuzzing","figma-automation","file-path-traversal","filesystem-context","file-uploads",
    "firecrawl-scraper","firmware-analyst","fitness-analyzer","fixing-accessibility","fixing-metadata","fixing-motion-performance",
    "fix-review","flat-design","flat-design-2","floating-ui","flowhunt-skill","food-database-query","form-cro","fp-async","fp-backend"
)

"`nWave 41 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 41 complete: $summaryFile" -ForegroundColor Green
