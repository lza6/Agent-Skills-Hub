$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave72-global.log"
$endMarker = "###END###"

if (Test-Path $logFile) {
    $existing = Get-Content $logFile -Raw -ErrorAction SilentlyContinue
    if ($existing -match [regex]::Escape($endMarker)) {
        "SKIP already completed" | Out-File -FilePath $logFile -Append -Encoding ascii
        exit 0
    }
}

"###START### $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Encoding ascii

# Wave72: 28 repos, install GLOBALLY to ~/.claude/skills (claude-code only)
$repos = @(
    "trailofbits/skills","lackeyjb/playwright-skill","browserwing/browserwing",
    "dominikmartn/nothing-design-skill","carmahhawwari/ui-design-brain",
    "daymade/claude-code-skills","NeoLabHQ/context-engineering-kit",
    "Aaronontheweb/dotnet-skills","CharlesWiltgen/Axiom",
    "alirezarezvani/claude-code-skill-factory","coleam00/second-brain-skills",
    "araguaci/cursor-skills","gnurio/nurijanian-skills","chrisboden/cursor-skills",
    "harrychuang/cursor-skills","yilansun416-design/cursor-skills",
    "TashanGKD/tashan-cursor-skills","dotdc/cursor-workshop","aussiegingersnap/cursor-skills",
    "Pluviobyte/jiepi-skill","xuliang2024/video_skills",
    "chencodeX/he-kaiming-style-research-skill","chenShengBiao/cocos-ai-mcp",
    "lihao0318/ai-nl2ui-automation","prepfinders/seedance2-api",
    "robzilla1738/htmlshop","yuhaoliu7456/pdf2md-skill"
)
# prompt-improver already installed manually, skip

$ok = 0; $fail = 0; $failList = @()
foreach ($repo in $repos) {
    "$(Get-Date -Format 'HH:mm:ss') INSTALL: $repo" | Out-File -FilePath $logFile -Append -Encoding ascii
    & npx skills add $repo -g -a claude-code -y 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        "  OK $repo" | Out-File -FilePath $logFile -Append -Encoding ascii
        $ok++
    } else {
        "  FAIL $repo (exit $LASTEXITCODE)" | Out-File -FilePath $logFile -Append -Encoding ascii
        $fail++; $failList += $repo
    }
}
"=== Wave72-global DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) { "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii }
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
