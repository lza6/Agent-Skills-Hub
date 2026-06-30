$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave74-global.log"
$endMarker = "###END###"

$repos = @(
    "nidhinjs/prompt-master",
    "SawyerHood/dev-browser",
    "joeseesun/qiaomu-anything-to-notebooklm",
    "SnailSploit/Claude-Red",
    "elementalsouls/Claude-BugHunter",
    "elementalsouls/Claude-OSINT",
    "glitternetwork/pinme",
    "yctimlin/mcp_excalidraw",
    "mohitagw15856/pm-claude-skills",
    "adamlyttleapps/claude-skill-app-onboarding-questionnaire",
    "bevibing/tutor-skills",
    "huangserva/skill-prompt-generator",
    "aiwithremy/claude-skills-llm-council",
    "alchaincyf/huashu-md-html",
    "jwangkun/claude-for-financial-services-cn",
    "Gabberflast/academic-pptx-skill",
    "Sushegaad/Claude-Skills-Governance-Risk-and-Compliance",
    "BrownFineSecurity/iothackbot",
    "ItsssssJack/power-design",
    "zarazhangrui/youtube-to-ebook",
    "chujianyun/skills",
    "davepoon/buildwithclaude",
    "rokpiy/auto-commenter"
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
"=== Wave74 DONE: OK=$ok FAIL=$fail ===" | Out-File -FilePath $logFile -Append -Encoding ascii
if ($failList.Count -gt 0) {
    "FAILED: $($failList -join ', ')" | Out-File -FilePath $logFile -Append -Encoding ascii
}
"$endMarker $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $logFile -Append -Encoding ascii
