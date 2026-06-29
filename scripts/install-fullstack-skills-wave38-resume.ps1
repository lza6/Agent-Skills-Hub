# Wave 38 补跑 — ajgeddes-3~5 / bobmatnyc / techleads / antigravity
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave38-resume-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave38-resume"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Wave 38 resume started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

Run-SkillBatch -Label "ajgeddes-3" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @(
    "mocking-stubbing","model-deployment","model-hyperparameter-tuning","model-monitoring","multi-cloud-strategy",
    "natural-language-processing","network-analysis","network-debugging","network-security-groups","neural-network-design",
    "nginx-configuration","nodejs-express-server","nosql-database-design","oauth-implementation","payment-gateway-integration",
    "performance-regression-debugging","performance-testing","polyglot-integration","process-mapping","profiling-optimization",
    "progressive-web-app","project-estimation","prometheus-monitoring","pull-request-automation","push-notification-setup",
    "query-caching-strategies","rate-limiting-implementation","react-component-architecture","reactive-programming",
    "react-native-app","real-time-features","recommendation-engine","recommendation-system","refactor-legacy-code",
    "regression-modeling","release-planning","requirements-gathering","responsive-web-design","retrospective-facilitation","risk-assessment"
)

Run-SkillBatch -Label "ajgeddes-4" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @(
    "root-cause-analysis","secrets-rotation","security-audit-logging","security-compliance-audit","security-documentation",
    "security-headers-configuration","security-testing","semantic-versioning","sentiment-analysis","serverless-architecture",
    "server-side-rendering","session-management","spring-boot-application","sql-injection-prevention","sql-query-optimization",
    "ssl-certificate-management","stakeholder-communication","static-code-analysis","statistical-hypothesis-testing",
    "stored-procedures","stress-testing","survival-analysis","synthetic-monitoring","technical-debt-assessment",
    "technical-roadmap-planning","test-automation-framework","test-data-generation","third-party-integration","time-series-analysis",
    "transaction-management","troubleshooting-guide","unit-testing-framework","uptime-monitoring","user-guide-creation",
    "user-persona-creation","user-research-analysis","user-story-writing","visual-regression-testing","vue-application-structure","vulnerability-scanning"
)

Run-SkillBatch -Label "ajgeddes-5" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @(
    "webhook-development","webhook-integration","web-performance-audit","websocket-implementation","wireframe-prototyping",
    "xss-prevention","zero-trust-architecture"
)

Run-SkillBatch -Label "bobmatnyc-1" -Repo "https://github.com/bobmatnyc/claude-mpm-skills" -Skills @(
    "anthropic","api-design-patterns","api-documentation","api-review","artifacts-builder","asyncio","axum",
    "bad-interdependent-skill","better-auth-authentication","better-auth-core","better-auth-integrations","better-auth-plugins",
    "bug-fix","cargo-release","celery","clap","code-production-process","code-quality-scoring","code-review-standards",
    "condition-based-waiting","daisyui","datadog","dependency-audit","desktop-applications","digitalocean-agentic-cloud",
    "digitalocean-compute","digitalocean-containers-images","digitalocean-managed-databases","digitalocean-management",
    "digitalocean-networking","digitalocean-overview","digitalocean-storage","digitalocean-teams","django","drizzle","drizzle-migrations"
)

Run-SkillBatch -Label "bobmatnyc-2" -Repo "https://github.com/bobmatnyc/claude-mpm-skills" -Skills @(
    "dspy","ecto-patterns","emergency-release-workflow","env-manager","espocrm","fastapi-local-dev","fastify","flask",
    "gh-cli","github-actions","good-self-contained-skill","headlessui","homebrew-formula-maintenance","internal-comms",
    "json-data-handling","kysely","langchain","local-llm-ops","mcp","media-transcoding","mongodb","mpm-orchestration-demo",
    "mypy","netlify","nextjs-core","nextjs-v16","nodejs-backend","openrouter","pre-merge","prisma","pr-quality-checklist",
    "pydantic","pyright","pytest","reporting-pipelines","rust-quality-gate"
)

Run-SkillBatch -Label "bobmatnyc-3" -Repo "https://github.com/bobmatnyc/claude-mpm-skills" -Skills @(
    "screenshot","sec-edgar-pipeline","security-scanning","session-compression","software-patterns","sqlalchemy","stacked-prs",
    "tailwind","tanstack-query","tauri","testing-anti-patterns","test-quality-inspector","threat-modeling","typescript-core",
    "validated-handler","vb6-legacy","vb-core","vb-database","vb-winforms","vector-search-workflows","vercel-ai",
    "vercel-deployments-builds","vercel-functions-runtime","vercel-networking-domains","vercel-observability","vercel-overview",
    "vercel-security-access","vercel-storage-data","vercel-teams-billing","vite","wordpress-advanced-architecture",
    "wordpress-block-editor-fse","wordpress-security-validation","wordpress-testing-qa","xlsx","zustand"
)

Run-SkillBatch -Label "techleads-remaining" -Repo "https://github.com/tech-leads-club/agent-skills" -Skills @(
    "ai-cold-outreach","ai-pricing","ai-sdr","ai-ugc-ads","codenavi","create-technical-design-doc","expansion-retention",
    "gtm-engineering","gtm-metrics","lead-enrichment","legacy-migration-planner","mermaid-studio","modular-design-principles",
    "multi-platform-launch","nestjs-modular-monolith","nx-ci-monitor","nx-generate","nx-run-tasks","nx-workspace",
    "paid-creative-ai","partner-affiliate","perf-astro","perf-lighthouse","perf-web-optimization","positioning-icp",
    "react-best-practices","react-composition-patterns","render-deploy","sales-motion-design","security-ownership-map",
    "shopify-developer","skill-architect","social-selling","solo-founder-gtm","spec-driven-eval","subagent-creator",
    "tactical-ddd","tlc-spec-driven","video-outreach","web-accessibility","web-best-practices","web-quality-audit"
)

Run-SkillBatch -Label "antigravity-dev" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "accessibility-compliance-accessibility-audit","android-ui-journey-testing","api-testing-observability-api-mock",
    "application-performance-performance-optimization","app-store-changelog","app-store-optimization","awt-e2e-testing",
    "azd-deployment","backend-architect","bash-linux","bash-pro","browser-extension-builder","chrome-extension-developer",
    "code-review-ai-ai-review","code-review-checklist","container-security-hardening","copilot-sdk","create-branch",
    "create-issue-gate","debug-buttercup","dependency-management-deps-audit","design-it","design-orchestration",
    "design-spells","design-taste-frontend","devcontainer-setup","devops-deploy","devops-troubleshooter",
    "django-access-review","django-perf-review","docs-architect","email-sequence","email-systems",
    "error-debugging-error-analysis","error-debugging-error-trace"
)

"`nWave 38 resume done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 38 resume complete: $summaryFile" -ForegroundColor Green
