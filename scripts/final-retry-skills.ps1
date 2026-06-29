$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$log = Join-Path $logDir "final-retry-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

$remaining = @(
    @{ repo = "https://github.com/github/awesome-copilot"; skill = "premium-frontend-ui" },
    @{ repo = "https://github.com/github/awesome-copilot"; skill = "secret-scanning" },
    @{ repo = "https://github.com/github/awesome-copilot"; skill = "create-agentsmd" },
    @{ repo = "https://github.com/github/awesome-copilot"; skill = "react-audit-grep-patterns" },
    @{ repo = "https://github.com/github/awesome-copilot"; skill = "polyglot-test-agent" },
    @{ repo = "https://github.com/github/awesome-copilot"; skill = "create-web-form" },
    @{ repo = "https://github.com/github/awesome-copilot"; skill = "web-coder" },
    @{ repo = "https://github.com/vercel-labs/next-skills"; skill = "next-cache-components" },
    @{ repo = "https://github.com/vercel-labs/vercel-plugin"; skill = "nextjs" },
    @{ repo = "https://github.com/vercel-labs/agent-skills"; skill = "vercel-react-best-practices" },
    @{ repo = "https://github.com/redis/agent-skills"; skill = "redis-development" },
    @{ repo = "https://github.com/jezweb/claude-skills"; skill = "wordpress-plugin-core" },
    @{ repo = "https://github.com/aj-geddes/claude-code-bmad-skills"; skill = "system-architect" },
    @{ repo = "https://github.com/skillcreatorai/ai-agent-skills"; skill = "code-refactoring" },
    @{ repo = "https://github.com/hugorcd/evlog"; skill = "review-logging-patterns" },
    @{ repo = "https://github.com/tirth8205/code-review-graph"; skill = "review-changes" },
    @{ repo = "https://github.com/tirth8205/code-review-graph"; skill = "explore-codebase" },
    @{ repo = "https://github.com/kostja94/marketing-skills"; skill = "status-page-generator" },
    @{ repo = "https://github.com/kostja94/marketing-skills"; skill = "feedback-page-generator" },
    @{ repo = "https://github.com/bobmatnyc/claude-mpm-skills"; skill = "nodejs-backend-typescript" },
    @{ repo = "https://github.com/ruvnet/ruflo"; skill = "v3-performance-optimization" },
    @{ repo = "https://github.com/ruvnet/ruflo"; skill = "v3-ddd-architecture" },
    @{ repo = "https://github.com/ruvnet/ruflo"; skill = "pair-programming" }
)

"Final retry of $($remaining.Count) skills at $(Get-Date)" | Out-File $log
$ok = 0; $fail = 0

foreach ($item in $remaining) {
    $skill = $item.skill
    if (Test-Path "$env:USERPROFILE\.agents\skills\$skill") {
        "SKIP $skill (already installed)" | Tee-Object -FilePath $log -Append
        $ok++
        continue
    }
    $r = Invoke-SkillInstall -Label $skill -Repo $item.repo -Skills @($skill) -LogDir $logDir -LogPrefix "final"
    if ($r.Ok -or (Test-Path "$env:USERPROFILE\.agents\skills\$skill")) {
        "OK   $skill" | Tee-Object -FilePath $log -Append
        $ok++
    } else {
        "FAIL $skill" | Tee-Object -FilePath $log -Append
        $fail++
    }
}

"`nDone: OK=$ok FAIL=$fail" | Tee-Object -FilePath $log -Append
