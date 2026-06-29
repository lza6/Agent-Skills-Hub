# Wave 40 — shubham 重试 / alirezarezvani 第三批 / mukul 安全第二批 / antigravity 第三批
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave40-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave40"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Wave 40 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

Run-SkillBatch -Label "shubham-retry" -Repo "https://github.com/shubhamsaboo/awesome-llm-apps" -Skills @(
    "academic-researcher","chatgpt-app-builder","content-creator","content-writer","decision-helper","editor",
    "email-drafter","fact-checker","fullstack-developer","mcp-apps-builder","meeting-notes","project-planner",
    "python-expert","sprint-planner","strategy-advisor","technical-writer","ux-designer","visualization-expert"
)

Run-SkillBatch -Label "alirezarezvani-3" -Repo "https://github.com/alirezarezvani/claude-skills" -Skills @(
    "a11y-audit","ab-test-setup","ad-creative","adversarial-reviewer","aeo","agent-designer","agent-protocol",
    "agent-workflow-designer","agile-product-owner","aims-audit","andreessen","apple-hig-expert","atlassian-admin",
    "atlassian-templates","autoresearch-agent","behuman","board","board-deck-builder","board-meeting","board-prep",
    "boardroom","brief","browserstack","business-growth-skills","business-investment-advisor","business-operations-skills",
    "caio-review","campaign-analytics","capacity-planner","capa-officer","capture","caveman","cco-review","cdo-review",
    "ceo-advisor"
)

Run-SkillBatch -Label "mukul-security-2" -Repo "https://github.com/mukul975/anthropic-cybersecurity-skills" -Skills @(
    "acquiring-disk-image-with-dd-and-dcfldd","analyzing-active-directory-acl-abuse","analyzing-api-gateway-access-logs",
    "analyzing-apt-group-with-mitre-navigator","analyzing-bootkit-and-rootkit-samples","analyzing-campaign-attribution-evidence",
    "analyzing-cloud-storage-access-patterns","analyzing-cobalt-strike-beacon-configuration","analyzing-cobaltstrike-malleable-c2-profiles",
    "analyzing-command-and-control-communication","analyzing-cyber-kill-chain","analyzing-disk-image-with-autopsy",
    "analyzing-dns-logs-for-exfiltration","analyzing-ethereum-smart-contract-vulnerabilities","analyzing-indicators-of-compromise",
    "analyzing-ios-app-security-with-objection","analyzing-kubernetes-audit-logs","analyzing-linux-audit-logs-for-intrusion",
    "analyzing-linux-kernel-rootkits","analyzing-linux-system-artifacts","analyzing-lnk-file-and-jump-list-artifacts",
    "analyzing-malicious-pdf-with-peepdf","analyzing-malicious-url-with-urlscan","analyzing-memory-dumps-with-volatility",
    "analyzing-mft-for-deleted-file-recovery","analyzing-network-flow-data-with-netflow","analyzing-network-packets-with-scapy",
    "analyzing-network-traffic-with-wireshark","analyzing-office365-audit-logs-for-compromise","analyzing-persistence-mechanisms-in-linux",
    "analyzing-powershell-empire-artifacts","analyzing-powershell-script-block-logging","analyzing-prefetch-files-for-execution-history",
    "analyzing-sbom-for-supply-chain-vulnerabilities","analyzing-slack-space-and-file-system-artifacts"
)

Run-SkillBatch -Label "antigravity-dev3" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "draw","dropbox-automation","duotone-design","dwarf-expert","dx-optimizer","earllm-build","ecl-harness-engineer",
    "editorial-design","efficient-web-research","ejentum-reasoning-harness","elixir-pro","elon-musk","emblemai-crypto-wallet",
    "emergency-card","emotional-arc-designer","environment-setup-guide","error-debugging-multi-agent-review","error-detective",
    "error-diagnostics-error-analysis","error-diagnostics-error-trace","error-diagnostics-smart-debug","ethical-hacking-methodology",
    "evaluation","event-sourcing-architect","event-staffing-compliance","event-staffing-ordering","evolution","examprep-ai",
    "explain-like-socrates","expo-api-routes","expo-cicd-workflows","expo-deployment","expo-dev-client","expo-tailwind-setup",
    "expo-ui-jetpack-compose"
)

"`nWave 40 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 40 complete: $summaryFile" -ForegroundColor Green
