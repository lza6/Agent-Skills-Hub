$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave73-global.log"
$endMarker = "###END###"

if (Test-Path $logFile) {
    $existing = Get-Content $logFile -Raw -ErrorAction SilentlyContinue
    if ($existing -match [regex]::Escape($endMarker)) { "SKIP" | Out-File -FilePath $logFile -Append -Encoding ascii; exit 0 }
}
"###START### $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Encoding ascii

# Wave73: gh search 筛选的全栈/工程/文档类新仓库 (2026-06-30)
$repos = @(
    "googleworkspace/cli",
    "larksuite/cli",
    "refly-ai/refly",
    "nexu-io/html-anything",
    "posit-dev/skills",
    "anthropics/launch-your-agent",
    "DenisSergeevitch/agents-best-practices",
    "amElnagdy/guard-skills",
    "withkynam/vibecode-pro-max-kit",
    "JimLiu/baoyu-design",
    "instavm/open-skills",
    "haidang1810/md2html",
    "alonw0/web-asset-generator",
    "tigicion/dao-code",
    "DanMcInerney/architect-loop",
    "MyuriKanao/src-hunter-skill",
    "zLanqing/codex-claude-academic-skills",
    "feicaoclub/video-spec-builder",
    "u7079256/paperjury",
    "realrossmanngroup/no_ai_slop_writing_rules",
    "worldwonderer/video-recap-skills",
    "zapier/gtm-cheat-codes",
    "mobiusquant/OpenMobius-skill",
    "Haojae/scipilot-figure-skill",
    "op7418/guizang-social-card-skill"
)

$ok=0; $fail=0; $failList=@()
foreach ($repo in $repos) {
    "$(Get-Date -Format 'HH:mm:ss') INSTALL: $repo" | Out-File -FilePath $logFile -Append -Encoding ascii
    & npx skills add $repo -g -a claude-code -y 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) { "  OK $repo" | Out-File -FilePath $logFile -Append -Encoding ascii; $ok++ }
    else { "  FAIL $repo (exit $LASTEXITCODE)" | Out-File -FilePath $logFile -Append -Encoding ascii; $fail++; $failList += $repo }
}
"=== Wave73 DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) { "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii }
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
