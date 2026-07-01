$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave83-global.log"
$endMarker = "###END###"

$repos = @(
    "vercel-labs/skills",
    "agentskills/agentskills",
    "djacobsmeyer/claude-skills-engineering",
    "Ricko12vPL/claude-code-skills",
    "browserbase/skills",
    "trailofbits/skills-curated",
    "zxkane/aws-skills",
    "obra/superpowers-chrome",
    "GRCEngClub/claude-grc-engineering",
    "athola/claude-night-market",
    "jnemargut/better-plan-mode",
    "buildbetter-app/skills"
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
Write-Host "Wave83 done: OK=$ok FAIL=$fail"
