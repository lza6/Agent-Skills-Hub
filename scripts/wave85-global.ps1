$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave85-global.log"
$endMarker = "###END###"

$repos = @(
    "Cedriccmh/claude-code-skill-scrapling",
    "notmanas/claude-code-skills",
    "jamesrochabrun/skills",
    "julianobarbosa/claude-code-skills",
    "glebis/claude-skills",
    "itgoyo/awesome-claude-code-skills",
    "Wirasm/worktree-manager-skill",
    "Kentobayashi/claude-skills-QA-framework",
    "StreetTsuchikage/r20-glebis-claude-skills-devops",
    "RollerRemember/r14-borghei-claude-skills-devops",
    "nightwayvibrate/r02-alirezarezvani-claude-skills-devops",
    "centiofficermultiply/r17-behisecc-awesome-claude-skills-devops",
    "TopCoppersmithRuin/r09-travisvn-awesome-claude-skills-devops",
    "anikievev/claude-skills-devops"
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
