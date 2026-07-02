$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave88-global.log"
$endMarker = "###END###"

$repos = @(
    "nexu-io/open-design",
    "DietrichGebert/ponytail",
    "ComposioHQ/awesome-claude-skills",
    "VoltAgent/awesome-openclaw-skills",
    "hesreallyhim/awesome-claude-code",
    "topoteretes/cognee",
    "eigent-ai/eigent",
    "alibaba/zvec",
    "aden-hive/hive",
    "microsoft/SkillOpt",
    "alibaba/open-code-review",
    "xixu-me/xget",
    "htmlstreamofficial/preline",
    "jnMetaCode/superpowers-zh",
    "breaking-brake/cc-wf-studio",
    "metalbear-co/mirrord"
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
