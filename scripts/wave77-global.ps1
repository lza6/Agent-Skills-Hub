$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave77-global.log"
$endMarker = "###END###"

$repos = @(
    "yoanbernabeu/grepai-skills",
    "encoredev/skills",
    "eyadsibai/ltk",
    "zechenzhangagi/ai-research-skills",
    "ashchupliak/dream-team",
    "alphaonedev/openclaw-graph",
    "geoffjay/claude-plugins",
    "eng0ai/eng0-template-skills",
    "mlflow/skills",
    "ruvnet/ruflo",
    "ancoleman/ai-design-components",
    "adobe/skills",
    "hack23/homepage",
    "erichowens/some_claude_skills",
    "wshobson/agents",
    "redis/agent-skills",
    "neondatabase/agent-skills",
    "prisma/skills"
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
        $fail++
        $failList += $repo
    }
}
"=== Wave77 DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) {
    "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii
}
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
