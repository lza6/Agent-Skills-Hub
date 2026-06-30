$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave80-global.log"
$endMarker = "###END###"

$repos = @(
    "oliver-kriska/claude-elixir-phoenix",
    "spatie/guidelines-skills",
    "iliaal/ai-skills",
    "fusengine/agents",
    "dpearson2699/swift-ios-skills",
    "drjacky/claude-android-ninja",
    "travisjneuman/.claude",
    "bfollington/terma",
    "laurigates/claude-plugins",
    "onewave-ai/claude-skills",
    "jackspace/claudeskillz",
    "sergiodxa/agent-skills",
    "mindrally/skills",
    "jeffallan/claude-skills",
    "getsentry/sentry-for-ai",
    "grafana/skills",
    "mongodb/agent-skills",
    "cloudflare/skills"
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
"=== Wave80 DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) {
    "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii
}
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
