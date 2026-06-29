# Wave 39 补跑 — TLS/clone 失败批次 + antigravity + techleads
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave39-resume-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave39-resume"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Wave 39 resume started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

Run-SkillBatch -Label "minimax-all" -Repo "https://github.com/minimax-ai/skills" -Skills @(
    "android-native-dev","buddy-sings","color-font-skill","design-style-skill","flutter-dev","frontend-dev",
    "fullstack-dev","gif-sticker-maker","ios-application-dev","minimax-docx","minimax-multimodal-toolkit",
    "minimax-music-gen","minimax-music-playlist","minimax-pdf","minimax-xlsx","ppt-editing-skill",
    "ppt-orchestra-skill","pptx-generator","pr-review","react-native-dev","shader-dev","slide-making-skill","vision-analysis"
)

Run-SkillBatch -Label "shubham-llm-apps" -Repo "https://github.com/shubhamsaboo/awesome-llm-apps" -Skills @(
    "academic-researcher","chatgpt-app-builder","content-creator","content-writer","decision-helper","editor",
    "email-drafter","fact-checker","fullstack-developer","mcp-apps-builder","meeting-notes","project-planner",
    "python-expert","sprint-planner","strategy-advisor","technical-writer","ux-designer","visualization-expert"
)

Run-SkillBatch -Label "andre-fullstackrecipes" -Repo "https://github.com/andrelandgraf/fullstackrecipes" -Skills @(
    "agent-browser","analytics-best-practices","authentication-best-practices","authoring-recipes",
    "better-auth-best-practices","better-auth-components","better-auth-emails","better-auth-profile",
    "better-auth-protected-routes","better-auth-setup","better-env","drizzle-queries","fallow",
    "neon-postgres-branches","neon-postgres-egress-optimizer","og-image-generation","ralph-loop-workflow",
    "sentry-best-practices","shiki-code-blocks","testing-best-practices","url-state-patterns",
    "use-fullstackrecipes","workflow-best-practices"
)

Run-SkillBatch -Label "alirezarezvani-2" -Repo "https://github.com/alirezarezvani/claude-skills" -Skills @(
    "saas-health","saas-metrics-coach","saas-scaffolder","security-guidance","security-pen-testing",
    "senior-backend","senior-data-engineer","senior-data-scientist","senior-devops","senior-security",
    "site-architecture","skills-chaos-engineering","skills-chief-ai-officer-advisor","skills-chief-data-officer-advisor",
    "skill-security-auditor","skills-eu-ai-act-specialist","skills-kubernetes-operator","soc2-audit-prep",
    "startup-cto","stripe-integration-expert","terraform-patterns"
)

Run-SkillBatch -Label "mukul-security" -Repo "https://github.com/mukul975/anthropic-cybersecurity-skills" -Skills @(
    "abusing-dpapi-for-credential-access","abusing-shadow-credentials-for-privesc","achieving-cmmc-level-2-compliance",
    "analyzing-android-malware-with-apktool","analyzing-azure-activity-logs-for-threats","analyzing-browser-forensics-with-hindsight",
    "analyzing-certificate-transparency-for-phishing","analyzing-docker-container-forensics","analyzing-email-headers-for-phishing-investigation",
    "analyzing-golang-malware-with-ghidra","analyzing-heap-spray-exploitation","analyzing-linux-elf-malware",
    "analyzing-macro-malware-in-office-documents","analyzing-malware-behavior-with-cuckoo-sandbox",
    "analyzing-malware-family-relationships-with-malpedia","analyzing-malware-persistence-with-autoruns",
    "analyzing-malware-sandbox-evasion-techniques","analyzing-memory-forensics-with-lime-and-volatility",
    "analyzing-network-covert-channels-in-malware","analyzing-network-traffic-for-incidents","analyzing-network-traffic-of-malware",
    "analyzing-outlook-pst-for-email-forensics","analyzing-packed-malware-with-upx-unpacker","analyzing-pdf-malware-with-pdfid",
    "analyzing-ransomware-encryption-mechanisms","analyzing-ransomware-leak-site-intelligence",
    "analyzing-ransomware-network-indicators","analyzing-ransomware-payment-wallets","analyzing-supply-chain-malware-artifacts",
    "analyzing-threat-actor-ttps-with-mitre-attack","analyzing-threat-actor-ttps-with-mitre-navigator",
    "analyzing-threat-intelligence-feeds","analyzing-threat-landscape-with-misp","analyzing-tls-certificate-transparency-logs",
    "analyzing-windows-event-logs-in-splunk"
)

Run-SkillBatch -Label "antigravity-dev2" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "agent-creator","agentflow","agentic-actions-auditor","agentmail","agent-manager-skill","agent-orchestrator",
    "agents-md","agent-squad","agents-v2-py","agenttrace-session-audit","antigravity-agent-manager","api-endpoint-builder",
    "api-fuzzing-bug-bounty","astropy","autonomous-agent-patterns","autonomous-agents","biopython",
    "brand-guidelines-anthropic","cc-skill-security-review","claimable-postgres","cloud-penetration-testing",
    "code-documentation-code-explain","code-documentation-doc-generate","code-refactoring-context-restore",
    "code-refactoring-refactor-clean","computer-use-agents","context-agent","context-management-context-restore",
    "dbos-golang","dbos-python","dbos-typescript","debugging-toolkit","debugging-toolkit-smart-debug",
    "deploy-to-vercel","distributed-debugging-debug-trace","documentation","documentation-generation-doc-generate",
    "documentation-templates","dotnet-architect","dotnet-backend"
)

Run-SkillBatch -Label "techleads-fix" -Repo "https://github.com/tech-leads-club/agent-skills" -Skills @(
    "technical-design-doc-creator","accessibility","best-practices"
)

"`nWave 39 resume done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 39 resume complete: $summaryFile" -ForegroundColor Green
