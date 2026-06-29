# Wave 28 - NestJS / Playwright BDD / TensorFlow / GitLab CI / Ruby+Rails / Effect / CocoaPods
#
# Sources (skills.sh, GitHub mirror):
#   thebushidocollective/han            https://github.com/thebushidocollective/han
#   getsentry/sentry-for-ai             https://github.com/getsentry/sentry-for-ai
#   akin-ozer/cc-devops-skills          https://github.com/akin-ozer/cc-devops-skills
#   paulrberg/agent-skills              https://github.com/paulrberg/agent-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave28-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave28"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 28 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- NestJS 深化 ---
Run-SkillBatch -Label "nestjs-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "nestjs-dependency-injection","nestjs-guards-interceptors","nestjs-testing"
)
Run-SkillBatch -Label "sentry-nestjs" -Repo "https://github.com/getsentry/sentry-for-ai" -Skills @("sentry-nestjs-sdk")

# --- Playwright BDD / Cucumber ---
Run-SkillBatch -Label "playwright-bdd-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "playwright-bdd-configuration","playwright-bdd-gherkin-syntax","playwright-bdd-step-definitions",
    "bdd-scenarios","bdd-patterns","bdd-principles"
)

# --- TensorFlow ---
Run-SkillBatch -Label "tensorflow-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "tensorflow-neural-networks","tensorflow-data-pipelines","tensorflow-model-deployment"
)

# --- GitLab CI ---
Run-SkillBatch -Label "gitlab-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "gitlab-ci-pipeline-configuration","gitlab-ci-job-configuration","gitlab-ci-variables-secrets",
    "gitlab-ci-best-practices","gitlab-ci-artifacts-caching"
)
Run-SkillBatch -Label "gitlab-akin" -Repo "https://github.com/akin-ozer/cc-devops-skills" -Skills @("gitlab-ci-validator")

# --- Ruby / Rails 补全 ---
Run-SkillBatch -Label "ruby-rails-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "ruby-metaprogramming","ruby-gems-bundler","ruby-blocks-procs-lambdas","ruby-oop","ruby-standard-library",
    "rails-action-controller-patterns","rails-active-record-patterns"
)
Run-SkillBatch -Label "rspec-rubocop-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "rspec-fundamentals","rspec-advanced","rspec-mocking",
    "rubocop-configuration","rubocop-cops","rubocop-integration"
)

# --- CocoaPods (iOS 依赖管理) ---
Run-SkillBatch -Label "cocoapods-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "cocoapods-podspec-fundamentals","cocoapods-privacy-manifests","cocoapods-publishing-workflow"
)

# --- Effect-TS ---
Run-SkillBatch -Label "effect-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "effect-core-patterns","effect-concurrency","effect-dependency-injection",
    "effect-error-handling","effect-schema","effect-testing"
)
Run-SkillBatch -Label "effect-paulrberg" -Repo "https://github.com/paulrberg/agent-skills" -Skills @("effect-ts")

"`nWave 28 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 28 complete: $summaryFile" -ForegroundColor Green
