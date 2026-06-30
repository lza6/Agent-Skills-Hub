$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave81-global.log"
$endMarker = "###END###"

$repos = @(
    "windmill-labs/windmill",
    "llama-farm/llamafarm",
    "0xdarkmatter/claude-mods",
    "damusix/skills",
    "gopherguides/gopher-ai",
    "alti3/litestar-skills",
    "johnlindquist/claude",
    "besoeasy/open-skills",
    "oguzhan18/angular-ecosystem-skills",
    "mikkelkrogsholm/dev-skills",
    "manifoldhiker/typesense-skill",
    "shipshitdev/library",
    "different-ai/openwork",
    "davila7/claude-code-templates",
    "sickn33/antigravity-awesome-skills",
    "samber/cc-skills-golang",
    "wshobson/agents",
    "anthropics/skills"
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
"=== Wave81 DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) {
    "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii
}
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
