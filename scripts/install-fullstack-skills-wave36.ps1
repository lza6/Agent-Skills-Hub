# Wave 36 - Vercel / Azure / makfly Symfony / vaquarkhan / antigravity 补装
#
# Sources (skills.sh, GitHub mirror):
#   vercel-labs/agent-skills              https://github.com/vercel-labs/agent-skills
#   microsoft/azure-skills                  https://github.com/microsoft/azure-skills
#   makfly/superpowers-symfony              https://github.com/makfly/superpowers-symfony
#   vaquarkhan/Fullstack-development-agent-skills https://github.com/vaquarkhan/Fullstack-development-agent-skills
#   sickn33/antigravity-awesome-skills      https://github.com/sickn33/antigravity-awesome-skills
#
# makfly: CLI 技能名使用 symfony: 前缀（quality-checks 已下架跳过）
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave36-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave36"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 36 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Vercel agent-skills 全量 ---
Run-SkillBatch -Label "vercel-agent-skills" -Repo "https://github.com/vercel-labs/agent-skills" -Skills @(
    "composition-patterns","deploy-to-vercel","react-best-practices","react-native-skills",
    "react-view-transitions","vercel-cli-with-tokens","vercel-optimize","web-design-guidelines","writing-guidelines"
)

# --- Microsoft Azure 补装 ---
Run-SkillBatch -Label "azure-microsoft" -Repo "https://github.com/microsoft/azure-skills" -Skills @(
    "airunway-aks-setup","azure-aigateway","azure-cloud-migrate","azure-compliance",
    "azure-enterprise-infra-planner","azure-hosted-copilot-sdk","azure-kubernetes-automatic-readiness",
    "azure-kusto","azure-messaging","azure-prepare","azure-quotas","azure-resource-lookup",
    "azure-resource-visualizer","azure-upgrade","azure-validate","capacity","customize",
    "deploy-model","entra-agent-id","finetuning","microsoft-foundry","preset","python-appservice-deploy"
)

# --- makfly Symfony (1/2) ---
Run-SkillBatch -Label "makfly-symfony-1" -Repo "https://github.com/makfly/superpowers-symfony" -Skills @(
    "symfony:api-platform-serialization","symfony:api-platform-tests","symfony:bootstrap-check",
    "symfony:config-env-parameters","symfony:cqrs-and-handlers","symfony:daily-workflow",
    "symfony:doctrine-batch-processing","symfony:doctrine-events","symfony:doctrine-fetch-modes",
    "symfony:doctrine-fixtures-foundry","symfony:doctrine-relations","symfony:doctrine-transactions",
    "symfony:e2e-panther-playwright"
)

# --- makfly Symfony (2/2) ---
Run-SkillBatch -Label "makfly-symfony-2" -Repo "https://github.com/makfly/superpowers-symfony" -Skills @(
    "symfony:effective-context","symfony:form-types-validation","symfony:functional-tests",
    "symfony:messenger-retry-failures","symfony:ports-and-adapters","symfony:rate-limiting",
    "symfony:runner-selection","symfony:strategy-pattern","symfony:symfony-voters",
    "symfony:test-doubles-mocking","symfony:twig-components","symfony:using-symfony-superpowers",
    "symfony:value-objects-and-dtos"
)

# --- vaquarkhan 全栈 (1/2) — 使用仓库实际 CLI 技能名 ---
Run-SkillBatch -Label "vaquarkhan-1" -Repo "https://github.com/vaquarkhan/Fullstack-development-agent-skills" -Skills @(
    "ai-llm-integration-in-fullstack-apps","angular-enterprise-frontend","api-contract-first-development",
    "api-gateway-and-edge-security","authentication-and-authorization-fullstack","autoscaling-capacity-and-cost-guardrails",
    "aws-cognito-authentication-patterns","aws-serverless-fullstack-architecture","azure-serverless-fullstack-architecture",
    "backend-microservices-architecture","bff-architecture-and-api-aggregation","cdn-caching-and-edge-acceleration-patterns",
    "chaos-engineering-and-failure-injection","cicd-gitops-and-progressive-deployment","cloud-cost-optimization",
    "cloud-fullstack-development","compliance-gdpr-and-data-privacy-fullstack","cqrs-and-event-sourcing-patterns",
    "database-migrations-zero-downtime","design-system-governance-and-tokens","distributed-caching-and-invalidation",
    "distributed-monolith-detection-and-remediation","domain-driven-service-decomposition","dotnet-aspnet-core-microservices",
    "e2e-testing-playwright-cypress","email-and-notification-delivery","feature-flags-and-progressive-delivery",
    "file-storage-and-media-delivery","frontend-load-balancing-and-global-delivery","frontend-security-csp-and-xss-hardening",
    "fullstack-observability-and-release-engineering","fullstack-product-specification","fullstack-testing-and-quality-gates",
    "gcp-serverless-fullstack-architecture","graphql-client-and-bff-integration","incident-triage-and-oncall-runbooks"
)

# --- vaquarkhan 全栈 (2/2) ---
Run-SkillBatch -Label "vaquarkhan-2" -Repo "https://github.com/vaquarkhan/Fullstack-development-agent-skills" -Skills @(
    "internationalization-and-localization","interservice-protocol-selection-rest-grpc-graphql","java-spring-boot-microservices",
    "kafka-event-backbone-patterns","kubernetes-fullstack-platform-engineering","load-balancer-strategy-and-traffic-distribution",
    "microservice-patterns-outbox-and-cdc","microservice-patterns-saga-and-compensation",
    "microservice-patterns-service-mesh-and-traffic-management","mobile-api-and-offline-sync-patterns",
    "monolith-to-microservices-migration-strategy","multi-cloud-disaster-recovery","multi-tenant-data-isolation-patterns",
    "nextjs-app-router-and-streaming-ui","nginx-edge-routing-and-security","nodejs-nestjs-backend-microservices",
    "oauth2-oidc-and-token-lifecycle","observability-distributed-tracing-and-ebpf-strategy","okta-identity-integration-patterns",
    "payments-and-webhook-reliability","performance-and-load-testing-fullstack","postgres-and-relational-data-modeling",
    "react-native-fullstack-integration","react-nextjs-frontend-architecture","realtime-ui-websockets-and-sse",
    "redis-caching-and-session-store-patterns","resilience-timeouts-retries-and-circuit-breakers","search-and-discovery-experience",
    "secrets-vault-and-key-rotation","serverless-event-driven-and-workflow-orchestration","terraform-fullstack-infrastructure-as-code",
    "ui-engineering-and-design-systems","using-fullstack-agent-skills","vercel-edge-and-jamstack-delivery",
    "vue-nuxt-frontend","web-accessibility-wcag-compliance"
)

# --- antigravity 重试 + 前端 ---
Run-SkillBatch -Label "antigravity-retry-frontend" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "python-fastapi-development","solidjs-patterns","typescript-expert",
    "nextjs-best-practices","nextjs-supabase-auth"
)

# --- antigravity AWS / Azure AI ---
Run-SkillBatch -Label "antigravity-cloud" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "aws-skills","aws-iam-best-practices","aws-security-audit","aws-cost-optimizer","aws-secrets-rotation",
    "agent-framework-azure-ai-py","azure-ai-ml-py","azure-ai-openai-dotnet","azure-ai-document-intelligence-dotnet",
    "azure-ai-contentsafety-py","azure-ai-agents-persistent-dotnet"
)

# --- antigravity Angular / Agent ---
Run-SkillBatch -Label "antigravity-angular-agent" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @(
    "angular-best-practices","angular-state-management","angular-ui-patterns",
    "agent-memory-systems","agent-orchestration-improve-agent","agent-tool-builder",
    "ai-agent-development","ai-agents-architect","api-patterns","api-documentation-generator"
)

"`nWave 36 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 36 complete: $summaryFile" -ForegroundColor Green
