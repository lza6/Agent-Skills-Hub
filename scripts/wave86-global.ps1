$ErrorActionPreference = "Continue"
$logFile = "C:\Users\Administrator.DESKTOP-EGNE9ND\Agent-Skills-Hub\logs\wave86-global.log"
$endMarker = "###END###"

$repos = @(
    "shanraisshan/claude-code-best-practice",
    "SamurAIGPT/Generative-Media-Skills",
    "browser-act/skills",
    "rohitg00/pro-workflow",
    "ciembor/agent-rules-books",
    "wondelai/skills",
    "decebals/claude-code-java",
    "kazukinagata/shinkoku",
    "tzachbon/smart-ralph",
    "mxyhi/ok-skills",
    "jiweiyeah/Skills-Manager",
    "parcadei/Continuous-Claude-v3",
    "pedrohcgs/claude-code-my-workflow",
    "code-yeongyu/oh-my-openagent",
    "OthmanAdi/planning-with-files",
    "JimLiu/baoyu-skills",
    "Orchestra-Research/AI-Research-SKILLs",
    "deanpeters/Product-Manager-Skills",
    "Agents365-ai/drawio-skill"
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
