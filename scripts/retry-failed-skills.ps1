$ErrorActionPreference = "Continue"
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
$summaryFile = Join-Path $logDir "retry-summary-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

# Failed repos from batch run - install skills one at a time for reliability
$failedInstalls = @(
    @{ repo = "https://github.com/github/awesome-copilot"; skills = @(
        "git-commit","prd","documentation-writer","refactor","multi-stage-dockerfile",
        "create-specification","refactor-plan","sql-optimization","postgresql-optimization",
        "sql-code-review","agentic-eval","ai-prompt-engineering-safety-review","markdown-to-html",
        "devops-rollout-plan","create-architectural-decision-record","refactor-method-complexity-reduce",
        "breakdown-feature-implementation","update-specification","remember",
        "folder-structure-blueprint-generator","breakdown-test","breakdown-epic-pm",
        "technology-stack-blueprint-generator","code-exemplars-blueprint-generator",
        "structured-autonomy-plan","what-context-needed","update-markdown-file-index",
        "structured-autonomy-implement","polyglot-test-agent","create-web-form","web-coder",
        "premium-frontend-ui","secret-scanning","create-agentsmd","react-audit-grep-patterns"
    )},
    @{ repo = "https://github.com/sickn33/antigravity-awesome-skills"; skills = @(
        "executing-plans","cc-skill-coding-standards","code-refactoring-tech-debt",
        "backend-development-feature-development","api-documenter","postgresql","kaizen",
        "python-pro","writing-plans","antigravity-workflows","architecture-patterns",
        "plan-writing","code-reviewer","codebase-cleanup-refactor-clean","database-architect",
        "api-design-principles","backend-security-coder","fastapi-pro"
    )},
    @{ repo = "https://github.com/alirezarezvani/claude-skills"; skills = @(
        "agenthub","api-test-suite-builder","browser-automation","api-design-reviewer",
        "sql-database-assistant","cto-advisor"
    )},
    @{ repo = "https://github.com/affaan-m/ecc"; skills = @(
        "parallel-execution-optimizer","data-throughput-accelerator","benchmark-optimization-loop",
        "ios-icon-gen","cisco-ios-patterns"
    )},
    @{ repo = "https://github.com/yeachan-heo/oh-my-claudecode"; skills = @("autopilot","deepinit","ai-slop-cleaner") },
    @{ repo = "https://github.com/davila7/claude-code-templates"; skills = @("nestjs-expert","docker-expert","code-reviewer") },
    @{ repo = "https://github.com/kostja94/marketing-skills"; skills = @("status-page-generator","feedback-page-generator") },
    @{ repo = "https://github.com/ruvnet/ruflo"; skills = @("v3-performance-optimization","v3-ddd-architecture","pair-programming") },
    @{ repo = "https://github.com/tirth8205/code-review-graph"; skills = @("review-changes","explore-codebase") },
    @{ repo = "https://github.com/affaan-m/everything-claude-code"; skills = @("benchmark-optimization-loop","parallel-execution-optimizer") },
    @{ repo = "https://github.com/charleswiltgen/axiom"; skills = @("axiom-networking") },
    @{ repo = "https://github.com/yonatangross/orchestkit"; skills = @("domain-driven-design") },
    @{ repo = "https://github.com/jezweb/claude-skills"; skills = @("wordpress-plugin-core") },
    @{ repo = "https://github.com/rtgs2017/nagaagent"; skills = @("file-manager") },
    @{ repo = "https://github.com/vercel-labs/vercel-plugin"; skills = @("nextjs") },
    @{ repo = "https://github.com/pproenca/dot-skills"; skills = @("clean-code") },
    @{ repo = "https://github.com/redis/agent-skills"; skills = @("redis-development") },
    @{ repo = "https://github.com/software-mansion/argent"; skills = @("argent-react-native-optimization") },
    @{ repo = "https://github.com/hugorcd/evlog"; skills = @("review-logging-patterns") },
    @{ repo = "https://github.com/langchain-ai/deepagents"; skills = @("schema-exploration") },
    @{ repo = "https://github.com/aj-geddes/claude-code-bmad-skills"; skills = @("system-architect") },
    @{ repo = "https://github.com/civitai/civitai"; skills = @("clickup") },
    @{ repo = "https://github.com/windmill-labs/windmill"; skills = @("rust-backend") },
    @{ repo = "https://github.com/k-dense-ai/scientific-agent-skills"; skills = @("optimize-for-gpu") }
)

$ok = 0; $fail = 0; $total = ($failedInstalls | ForEach-Object { $_.skills.Count } | Measure-Object -Sum).Sum
"Retrying $total skills individually at $(Get-Date)" | Tee-Object -FilePath $summaryFile

foreach ($entry in $failedInstalls) {
    foreach ($skill in $entry.skills) {
        Write-Host "Installing $skill from $($entry.repo)..." -ForegroundColor Cyan
        $output = & npx skills add $entry.repo --skill $skill -g -a '*' -y 2>&1 | Out-String
        if ($LASTEXITCODE -eq 0 -or $output -match "Installed \d+ skill") {
            $ok++; "OK  $skill" | Tee-Object -FilePath $summaryFile -Append
        } else {
            $fail++; "FAIL $skill ($($entry.repo))" | Tee-Object -FilePath $summaryFile -Append
            if ($output -match "No matching skills|No valid skills|Available skills") {
                ($output -split "`n" | Select-Object -Last 8) -join " | " | Tee-Object -FilePath $summaryFile -Append
            }
        }
    }
}

"`nRetry done: OK=$ok FAIL=$fail at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
