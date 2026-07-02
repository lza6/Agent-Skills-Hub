$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave87-global.log"
$endMarker = "###END###"

$repos = @(
    "mksglu/context-mode",
    "AgriciDaniel/claude-seo",
    "AgriciDaniel/claude-obsidian",
    "htdt/godogen",
    "wuyoscar/GPT-Image2-Skill",
    "codeaashu/claude-code",
    "eugeniughelbur/obsidian-second-brain",
    "alexgreensh/token-optimizer",
    "oh-my-mermaid/oh-my-mermaid",
    "NarratorAI-Studio/narrator-ai-cli-skill",
    "AgriciDaniel/claude-blog",
    "AgriciDaniel/banana-claude",
    "RandallLiuXin/GodotMaker",
    "pegasi-ai/reins",
    "peterfei/ai-agent-team",
    "Jane-xiaoer/claude-skill-web-clone",
    "7onez/cti-expert",
    "AgriciDaniel/claude-youtube",
    "Evol-ai/SkillCompass",
    "yeap531/word-format-skill",
    "jeecgboot/skills",
    "JimmySadek/youtube-fetcher-to-markdown",
    "Aspegio/nelson"
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
