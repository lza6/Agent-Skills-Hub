$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "summary-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"
$failFile = Join-Path $logDir "failures.txt"

# repo -> skill names (deduplicated)
$repoSkills = @{
    "https://github.com/anthropics/skills" = @(
        "frontend-design","skill-creator","web-artifacts-builder","brand-guidelines"
    )
    "https://github.com/vercel-labs/agent-skills" = @("vercel-react-best-practices")
    "https://github.com/microsoft/azure-skills" = @("entra-app-registration")
    "https://github.com/expo/skills" = @("building-native-ui")
    "https://github.com/github/awesome-copilot" = @(
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
    )
    "https://github.com/vercel-labs/next-skills" = @("next-cache-components")
    "https://github.com/clerk/skills" = @("clerk-custom-ui","clerk-orgs")
    "https://github.com/anthropics/claude-plugins-official" = @("frontend-design","claude-md-improver")
    "https://github.com/getsentry/skills" = @("code-simplifier","code-review","skill-scanner")
    "https://github.com/trailofbits/skills" = @(
        "ask-questions-if-underspecified","fp-check","audit-context-building","guidelines-advisor",
        "coverage-analysis","audit-prep-assistant","semgrep-rule-creator","skill-improver"
    )
    "https://github.com/anthropics/knowledge-work-plugins" = @(
        "code-review","memory-management","system-design","tech-debt","knowledge-synthesis",
        "search-strategy","incident-response","debug","deploy-checklist","update","search",
        "product-brainstorming","sql-queries","write-spec","process-optimization",
        "data-context-extractor","write-query"
    )
    "https://github.com/planetscale/database-skills" = @("postgres")
    "https://github.com/vercel-labs/vercel-plugin" = @("nextjs")
    "https://github.com/software-mansion/argent" = @("argent-react-native-optimization")
    "https://github.com/redis/agent-skills" = @("redis-development")
    "https://github.com/lottiefiles/motion-design-skill" = @("motion-design")
    "https://github.com/assistant-ui/skills" = @("assistant-ui","thread-list")
    "https://github.com/remix-run/agent-skills" = @("react-router-framework-mode")
    "https://github.com/callstack/react-native-testing-library" = @("react-native-testing")
    "https://github.com/forcedotcom/sf-skills" = @("generating-permission-set","generating-flexipage")
    "https://github.com/affaan-m/everything-claude-code" = @("benchmark-optimization-loop","parallel-execution-optimizer")
    "https://github.com/alwaysmeticulous/skills" = @("meticulous-review","meticulous-iterative-dev","meticulous-test")
    "https://github.com/alirezarezvani/claude-skills" = @(
        "agenthub","api-test-suite-builder","browser-automation","api-design-reviewer",
        "sql-database-assistant","cto-advisor"
    )
    "https://github.com/aj-geddes/useful-ai-prompts" = @(
        "docker-containerization","logging-best-practices","e2e-testing-automation",
        "technical-specification","api-contract-testing"
    )
    "https://github.com/posit-dev/skills" = @("critical-code-reviewer")
    "https://github.com/sickn33/antigravity-awesome-skills" = @(
        "executing-plans","cc-skill-coding-standards","code-refactoring-tech-debt",
        "backend-development-feature-development","api-documenter","postgresql","kaizen",
        "python-pro","writing-plans","antigravity-workflows","architecture-patterns",
        "plan-writing","code-reviewer","codebase-cleanup-refactor-clean","database-architect",
        "api-design-principles","backend-security-coder","fastapi-pro"
    )
    "https://github.com/mindrally/skills" = @(
        "fastify-typescript","java","bash-scripting","python-testing","supabase",
        "rabbitmq-development","zod-schema-validation","lua","flask-python"
    )
    "https://github.com/jezweb/claude-skills" = @("wordpress-plugin-core")
    "https://github.com/hyperb1iss/hyperskills" = @("plan")
    "https://github.com/charon-fan/agent-playbook" = @(
        "create-pr","long-task-coordinator","performance-engineer","debugger",
        "qa-expert","test-automator"
    )
    "https://github.com/auth0/agent-skills" = @("auth0-vue")
    "https://github.com/existential-birds/beagle" = @("python-code-review")
    "https://github.com/factory-ai/factory-plugins" = @("no-use-effect")
    "https://github.com/spillwavesolutions/mastering-typescript-skill" = @("mastering-typescript")
    "https://github.com/bobmatnyc/claude-mpm-skills" = @("biome","nodejs-backend-typescript")
    "https://github.com/jnmetacode/superpowers-zh" = @(
        "executing-plans","requesting-code-review","test-driven-development",
        "verification-before-completion","using-superpowers"
    )
    "https://github.com/aj-geddes/claude-code-bmad-skills" = @("system-architect")
    "https://github.com/tanstack-skills/tanstack-skills" = @("tanstack-config")
    "https://github.com/siviter-xyz/dot-agent" = @("cursor-best-practices")
    "https://github.com/yeachan-heo/oh-my-claudecode" = @("autopilot","deepinit","ai-slop-cleaner")
    "https://github.com/skillcreatorai/ai-agent-skills" = @("code-refactoring","backend-development")
    "https://github.com/parcadei/continuous-claude-v3" = @("dead-code","premortem")
    "https://github.com/davila7/claude-code-templates" = @("nestjs-expert","docker-expert","code-reviewer")
    "https://github.com/pproenca/dot-skills" = @("clean-code")
    "https://github.com/secondsky/claude-skills" = @("api-testing")
    "https://github.com/windmill-labs/windmill" = @("rust-backend")
    "https://github.com/chrisbanes/skills" = @("compose-ui-testing-patterns")
    "https://github.com/yoanbernabeu/grepai-skills" = @("grepai-search-tips","grepai-trace-graph")
    "https://github.com/rtgs2017/nagaagent" = @("file-manager")
    "https://github.com/yonatangross/orchestkit" = @("domain-driven-design")
    "https://github.com/tanweai/pua" = @("pua-trae")
    "https://github.com/dotnet/skills" = @("test-anti-patterns")
    "https://github.com/dicklesworthstone/agent_flywheel_clawdbot_skills_and_integrations" = @("ssh")
    "https://github.com/camacho/ai-skills" = @("plan-review")
    "https://github.com/mblode/agent-skills" = @("multi-tenant-architecture")
    "https://github.com/neolabhq/context-engineering-kit" = @(
        "create-rule","why","fix-tests","do-in-steps","do-in-parallel","implement-task",
        "plan-task","agent-evaluation","root-cause-tracing","test-driven-development",
        "critique","brainstorm"
    )
    "https://github.com/zhanghandong/rust-skills" = @("rust-deps-visualizer","unsafe-checker","rust-trait-explorer")
    "https://github.com/k-dense-ai/scientific-agent-skills" = @("optimize-for-gpu")
    "https://github.com/langfuse/langfuse" = @("backend-dev-guidelines")
    "https://github.com/coralogix/cx-cli" = @("cx-incident-management","cx-alerts")
    "https://github.com/vintasoftware/django-ai-plugins" = @("django-celery-expert")
    "https://github.com/charleswiltgen/axiom" = @("axiom-networking")
    "https://github.com/affaan-m/ecc" = @(
        "parallel-execution-optimizer","data-throughput-accelerator","benchmark-optimization-loop",
        "ios-icon-gen","cisco-ios-patterns"
    )
    "https://github.com/cxuu/golang-skills" = @(
        "go-control-flow","go-packages","go-functional-options","go-defensive","go-data-structures",
        "go-context","go-interfaces","go-style-core","go-concurrency","go-performance",
        "go-error-handling","go-naming","go-documentation","go-linting"
    )
    "https://github.com/vasilyu1983/ai-agents-public" = @("software-architecture-design")
    "https://github.com/hugorcd/evlog" = @("review-logging-patterns")
    "https://github.com/enderpuentes/ai-agent-skills" = @("pagespeed-insights")
    "https://github.com/civitai/civitai" = @("clickup")
    "https://github.com/tirth8205/code-review-graph" = @("review-changes","explore-codebase")
    "https://github.com/kostja94/marketing-skills" = @("status-page-generator","feedback-page-generator")
    "https://github.com/nvidia/skills" = @("cudaq-guide")
    "https://github.com/astronomer/agents" = @("checking-freshness")
    "https://github.com/tursodatabase/turso" = @("async-io-model","testing")
    "https://github.com/ailabs-393/ai-labs-claude-skills" = @("test-specialist")
    "https://github.com/ruvnet/ruflo" = @("v3-performance-optimization","v3-ddd-architecture","pair-programming")
    "https://github.com/forztf/open-skilled-sdd" = @("openspec-archiving")
    "https://github.com/langchain-ai/deepagents" = @("schema-exploration")
    "https://github.com/mcollina/skills" = @("oauth")
    "https://github.com/asyrafhussin/agent-skills" = @("clean-code-principles")
    "https://github.com/laurigates/claude-plugins" = @("python-code-quality")
}

$totalRepos = $repoSkills.Count
$totalSkills = ($repoSkills.Values | ForEach-Object { $_.Count } | Measure-Object -Sum).Sum
$success = 0
$failed = 0
$current = 0

"Starting install: $totalSkills skills from $totalRepos repos at $(Get-Date)" | Tee-Object -FilePath $summaryFile

foreach ($repo in $repoSkills.Keys) {
    $skills = $repoSkills[$repo]
    $current++
    $repoShort = ($repo -replace 'https://github.com/','')
    Write-Host "`n[$current/$totalRepos] $repoShort ($($skills.Count) skills)" -ForegroundColor Cyan
    $skillArgList = @()
    foreach ($s in $skills) { $skillArgList += "--skill"; $skillArgList += $s }
    $allArgs = @("skills", "add", $repo) + $skillArgList + @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("{0}.log" -f ($repoShort -replace '/','_'))

    try {
        $output = & npx @allArgs 2>&1 | Out-String
        $output | Out-File -FilePath $logFile -Encoding utf8

        if ($LASTEXITCODE -eq 0 -or $output -match "Installed \d+ skill") {
            $success += $skills.Count
            "OK  $repoShort -> $($skills -join ', ')" | Tee-Object -FilePath $summaryFile -Append
        } else {
            $failed += $skills.Count
            "FAIL $repoShort (exit $LASTEXITCODE)" | Tee-Object -FilePath $summaryFile -Append
            "FAIL $repoShort`n$output" | Out-File -FilePath $failFile -Append -Encoding utf8
        }
    } catch {
        $failed += $skills.Count
        "ERROR $repoShort : $_" | Tee-Object -FilePath $summaryFile -Append
        "ERROR $repoShort : $_" | Out-File -FilePath $failFile -Append -Encoding utf8
    }
}

"`nDone at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
"Success: ~$success skills | Failed: ~$failed skills" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nInstall complete. Summary: $summaryFile" -ForegroundColor Green
