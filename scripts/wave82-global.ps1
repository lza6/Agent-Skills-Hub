$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave82-global.log"
$endMarker = "###END###"

$repos = @(
    "AgriciDaniel/claude-ads",
    "FlorianBruniaux/claude-code-ultimate-guide",
    "centminmod/my-claude-code-setup",
    "rohitg00/awesome-claude-code-toolkit",
    "piomin/claude-ai-spring-boot",
    "runesleo/claude-code-workflow",
    "botingw/rulebook-ai",
    "ndpvt-web/latex-document-skill",
    "seulee26/mckinsey-pptx",
    "pcliangx/AppGenesisForge",
    "microsoft/skills-for-copilot-studio",
    "LingyiChen-AI/comfyui-workflow-skill",
    "karanb192/awesome-claude-skills",
    "asgard-ai-platform/skills",
    "ckanner/agent-skills",
    "selmakcby/claude-agents-skills",
    "spences10/claude-skills-cli"
)

$ok = 0; $fail = 0; $failList = @()
"###START### $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Encoding ascii
foreach ($repo in $repos) {
    "$(Get-Date -Format 'HH:mm:ss') INSTALL: $repo" | Out-File -FilePath $logFile -Append -Encoding ascii
    & npx skills add $repo -g -a claude-code -y 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        "  OK $repo" | Out-File -FilePath $logFile -Append -Encoding ascii
        $ok++
    } else {
        "  FAIL $repo (exit $LASTEXITCODE)" | Out-File -FilePath $logFile -Append -Encoding ascii
        $failList += $repo
        $fail++
    }
}
"$endMarker OK=$ok FAIL=$fail" | Out-File -FilePath $logFile -Append -Encoding ascii
Write-Host "Wave82 done: OK=$ok FAIL=$fail"
