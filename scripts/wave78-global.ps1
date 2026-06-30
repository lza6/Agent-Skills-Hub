$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave78-global.log"
$endMarker = "###END###"

$repos = @(
    "sugarforever/01coder-agent-skills",
    "wsimmonds/claude-nextjs-skills",
    "oimiragieo/agent-studio",
    "caffeinelabs/skills",
    "rightnow-ai/openfang",
    "rand/cc-polymath",
    "sanity-io/agent-toolkit",
    "opensearch-project/opensearch-agent-skills",
    "partme-ai/full-stack-skills",
    "vladm3105/aidoc-flow-framework",
    "sundial-org/awesome-openclaw-skills",
    "promptadvisers/n8n-powerhouse",
    "jamditis/claude-skills-journalism",
    "popup-studio-ai/bkit-claude-code",
    "giuseppe-trisciuoglio/developer-kit",
    "bobmatnyc/claude-mpm-skills",
    "sickn33/antigravity-awesome-skills",
    "davila7/claude-code-templates"
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
"=== Wave78 DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) {
    "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii
}
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
