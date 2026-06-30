$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave79-global.log"
$endMarker = "###END###"

$repos = @(
    "greensock/gsap-skills",
    "haydenbleasel/ultracite",
    "dchuk/claude-code-tauri-skills",
    "henriqueatila/golang-gin-clean-arch",
    "jorgealves/agent_skills",
    "borghei/claude-skills",
    "reown-com/skills",
    "open-circle/agent-skills",
    "mem0ai/mem0",
    "insforge/agent-skills",
    "danielmiessler/personal_ai_infrastructure",
    "majesticlabs-dev/majestic-marketplace",
    "nice-wolf-studio/claude-code-supabase-skills",
    "spanora/skills",
    "supabase/agent-skills",
    "clerk/skills",
    "apollographql/skills",
    "stripe/ai"
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
"=== Wave79 DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) {
    "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii
}
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
