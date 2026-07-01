$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave84-global.log"
$endMarker = "###END###"

$repos = @(
    "safishamsi/graphify",
    "ChrisWiles/claude-code-showcase",
    "ThibautBaissac/rails_ai_agents",
    "jabrena/plinth",
    "microsoft/power-platform-skills",
    "transilienceai/communitytools",
    "obie/skills",
    "adrianpuiu/claude-skills-marketplace",
    "a-pavithraa/springboot-skills-marketplace",
    "ferdinandobons/AWSBedrockAgentCoreSkill",
    "FlorianBruniaux/claude-code-plugins",
    "lightpointventures/claude-code-starter"
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
Write-Host "Wave84 done: OK=$ok FAIL=$fail"
