$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave75-global.log"
$endMarker = "###END###"

$repos = @(
    "leonxlnx/taste-skill",
    "pbakaus/impeccable",
    "addyosmani/agent-skills",
    "mcollina/skills",
    "josiahsiegel/claude-plugin-marketplace",
    "hairyf/skills",
    "ailabs-393/ai-labs-claude-skills",
    "dotneet/claude-code-marketplace",
    "zhanghandong/rust-skills",
    "manutej/luxor-claude-marketplace",
    "yonatangross/orchestkit",
    "langgenius/dify",
    "yaklang/hack-skills",
    "404kidwiz/claude-supercode-skills",
    "samhvw8/dotfiles",
    "cap-go/capacitor-skills"
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
"=== Wave75 DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) {
    "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii
}
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
