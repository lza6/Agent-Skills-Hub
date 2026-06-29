# Wave 37 - Sentry SDK 全量 / mindrally / aj-geddes / tech-leads / antigravity / bobmatnyc
#
# Sources (skills.sh, GitHub mirror):
#   getsentry/sentry-for-ai                  https://github.com/getsentry/sentry-for-ai
#   mindrally/skills                         https://github.com/mindrally/skills
#   aj-geddes/useful-ai-prompts              https://github.com/aj-geddes/useful-ai-prompts
#   tech-leads-club/agent-skills             https://github.com/tech-leads-club/agent-skills
#   sickn33/antigravity-awesome-skills       https://github.com/sickn33/antigravity-awesome-skills
#   bobmatnyc/claude-mpm-skills              https://github.com/bobmatnyc/claude-mpm-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave37-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave37"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 37 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Sentry SDK 全量补装 ---
Run-SkillBatch -Label "sentry-for-ai" -Repo "https://github.com/getsentry/sentry-for-ai" -Skills @(
    "sentry-android-sdk","sentry-browser-sdk","sentry-cloudflare-sdk","sentry-cocoa-sdk",
    "sentry-code-review","sentry-create-alert","sentry-dotnet-sdk","sentry-feature-setup",
    "sentry-fix-issues","sentry-flutter-sdk","sentry-go-sdk","sentry-instrumentation-guide",
    "sentry-nextjs-sdk","sentry-node-sdk","sentry-otel-exporter-setup","sentry-php-sdk",
    "sentry-pr-code-review","sentry-python-sdk","sentry-react-native-sdk","sentry-react-router-framework-sdk",
    "sentry-react-sdk","sentry-ruby-sdk","sentry-sdk-skill-creator","sentry-setup-ai-monitoring",
    "sentry-span-streaming-js","sentry-span-streaming-python","sentry-svelte-sdk",
    "sentry-tanstack-start-sdk","sentry-workflow"
)

# --- mindrally 全栈开发 ---
Run-SkillBatch -Label "mindrally-dev" -Repo "https://github.com/mindrally/skills" -Skills @(
    "accessibility-a11y","android-development","angular","angular-development","apollo-graphql",
    "aws-development","blazor","ci-cd-best-practices","clean-architecture","cloudflare-development",
    "cypress","data-jupyter-python","deep-learning-python","design-systems","devops",
    "django-python","django-rest-api-development","docker","dotnet","elasticsearch-best-practices",
    "electron-development","esbuild-bundler","expo-react-native-javascript-best-practices",
    "express-typescript","fastapi-microservices-serverless","figma-integration","firebase-development",
    "flutter","go-api-development","graphql-development","hono-typescript","java-quarkus-development",
    "java-spring-development","jwt-security","kubernetes-deployment"
)

# --- aj-geddes API / 后端 (1/2) ---
Run-SkillBatch -Label "ajgeddes-api-1" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @(
    "ab-test-analysis","access-control-rbac","accessibility-testing","api-authentication",
    "api-changelog-versioning","api-error-handling","api-filtering-sorting","api-gateway-configuration",
    "api-pagination","api-rate-limiting","api-reference-documentation","api-response-optimization",
    "api-security-hardening","api-versioning-strategy","application-logging","architecture-diagrams",
    "autoscaling-configuration","aws-cloudfront-cdn","aws-ec2-setup","aws-lambda-functions",
    "aws-rds-database","aws-s3-management","azure-app-service","azure-functions",
    "background-job-processing","backup-disaster-recovery","batch-processing-jobs","blue-green-deployment",
    "alert-management","anomaly-detection","android-kotlin-development","angular-module-design",
    "app-store-deployment","artifact-management","agile-sprint-planning"
)

# --- aj-geddes DevOps / 数据库 (2/2) ---
Run-SkillBatch -Label "ajgeddes-devops-2" -Repo "https://github.com/aj-geddes/useful-ai-prompts" -Skills @(
    "browser-debugging","bundle-size-optimization","caching-strategy","canary-deployment",
    "circuit-breaker-pattern","cloud-cost-management","cloud-security-configuration","code-documentation",
    "concurrency-patterns","configuration-management","container-debugging","container-registry-management",
    "continuous-testing","correlation-tracing","database-backup-restore","database-indexing-strategy",
    "database-migration-management","database-monitoring","database-performance-debugging",
    "database-schema-design","database-schema-documentation","database-sharding","dependency-management",
    "dependency-tracking","deployment-automation","deployment-documentation","disaster-recovery-testing",
    "feature-flag-system","health-check-endpoints","horizontal-scaling"
)

# --- tech-leads-club 架构 / 工程 ---
Run-SkillBatch -Label "techleads-arch" -Repo "https://github.com/tech-leads-club/agent-skills" -Skills @(
    "coding-guidelines","core-web-vitals","create-adr","create-rfc","create-technical-design-doc",
    "docs-writer","domain-analysis","domain-identification-grouping","decomposition-planning-roadmap",
    "component-common-domain-detection","component-flattening-analysis","component-identification-sizing",
    "coupling-analysis","modular-decomposition","frontend-blueprint","aws-advisor","cloudflare-deploy",
    "figma","gh-address-comments","jira-assistant","confluence-assistant","chrome-devtools",
    "learning-opportunities","cursor-subagent-creator","excalidraw-studio","ai-seo","content-to-pipeline"
)

# --- antigravity 开发工具 / 集成 ---
Run-SkillBatch -Label "antigravity-devtools" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "address-github-comments","bun-development","burp-suite-testing","clerk-auth",
    "cloudflare-workers-expert","confluence-automation","datadog-automation","discord-automation",
    "drizzle-orm-expert","firebase","git-hooks-automation","github-actions-advanced",
    "github-automation","github-issue-creator","github-workflow-automation","gitlab-automation",
    "git-pr-review","git-pr-workflows-git-workflow","git-pushing","api-security-best-practices",
    "api-security-testing","aws-penetration-testing","aws-compliance-checker","aws-cost-cleanup",
    "bevy-ecs-expert","bitbucket-automation","discord-bot-architect","data-engineering-data-driven-feature",
    "azure-monitor-opentelemetry-py","azure-monitor-opentelemetry-ts","azure-resource-manager-redis-dotnet",
    "agent-memory-mcp","ai-dev-jobs-mcp","akf-trust-metadata","glassmorphism"
)

# --- bobmatnyc 全栈补装 ---
Run-SkillBatch -Label "bobmatnyc-fullstack" -Repo "https://github.com/bobmatnyc/claude-mpm-skills" -Skills @(
    "phoenix-api-channels","phoenix-ops","golang-cli-cobra-viper","golang-concurrency-patterns",
    "golang-database-patterns","golang-http-frameworks","golang-observability-opentelemetry",
    "golang-testing-strategies","spring-boot","express-production","flexlayout-react",
    "hono-cloudflare","hono-core","hono-jsx","hono-middleware","hono-rpc","hono-testing",
    "hono-validation","react-advanced","react-core","react-hooks-composition","react-state-machine",
    "svelte","svelte5-runes-static","sveltekit"
)

"`nWave 37 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 37 complete: $summaryFile" -ForegroundColor Green
