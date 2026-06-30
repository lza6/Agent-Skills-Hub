$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave76-global.log"
$endMarker = "###END###"

$repos = @(
    "alinaqi/claude-bootstrap",
    "margelo/react-native-skills",
    "pluginagentmarketplace/custom-plugin-java",
    "jabrena/cursor-rules-java",
    "mhagrelius/dotfiles",
    "wshaddix/dotnet-skills",
    "toss/es-toolkit",
    "deepgram/skills",
    "pixijs/pixijs-skills",
    "iii-hq/skills",
    "patricio0312rev/skills",
    "blogic-cz/blogic-marketplace",
    "omer-metin/skills-for-antigravity",
    "thebeardedbearsas/claude-craft",
    "ovachiever/droid-tings",
    "asyrafhussin/agent-skills",
    "evanca/flutter-ai-rules",
    "modu-ai/moai-adk",
    "oakoss/agent-skills",
    "aradotso/trending-skills"
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
"=== Wave76 DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) {
    "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii
}
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
