# =============================================================================
# Agent Skills Hub — 总安装脚本（基础 226 + Wave 1–42 + 失败补装 + 更新文档）
#
# 用法（在 Agent-Skills-Hub 目录下）:
#   .\install-all-skills-total.ps1
#
# 或任意位置（替换为你的 Hub 路径）:
#   powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\你的用户名\Agent-Skills-Hub\install-all-skills-total.ps1"
#
# 预计耗时: 30–90 分钟（取决于网络）
# 前提: Node.js 18+（含 npx）、Python 3.10+
# =============================================================================
$ErrorActionPreference = "Continue"
$HubDir = $PSScriptRoot
$ScriptsDir = Join-Path $HubDir "scripts"
. (Join-Path $ScriptsDir "github-mirror.ps1")
Enable-GitHubMirror

$StartTime = Get-Date
$TotalSteps = 48

function Write-Step {
    param([int]$Num, [string]$Title)
    Write-Host "`n========================================" -ForegroundColor DarkGray
    Write-Host "=== Step $Num/$TotalSteps: $Title ===" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor DarkGray
}

function Test-Prerequisites {
    $ok = $true
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        Write-Host "缺少 Node.js。请安装: https://nodejs.org/" -ForegroundColor Red
        $ok = $false
    } else {
        Write-Host "Node.js: $(node -v)" -ForegroundColor DarkGray
    }
    if (-not (Get-Command npx -ErrorAction SilentlyContinue)) {
        Write-Host "缺少 npx（随 Node.js 安装）" -ForegroundColor Red
        $ok = $false
    }
    if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
        Write-Host "缺少 Python（更新文档需要）。请安装: https://python.org/" -ForegroundColor Red
        $ok = $false
    } else {
        Write-Host "Python: $(python --version 2>&1)" -ForegroundColor DarkGray
    }
    return $ok
}

function Invoke-HubScript {
    param([string]$RelativePath)
    $path = Join-Path $HubDir $RelativePath
    if (-not (Test-Path $path)) {
        Write-Host "脚本不存在: $path" -ForegroundColor Red
        return $false
    }
    powershell -NoProfile -ExecutionPolicy Bypass -File $path
    return ($LASTEXITCODE -eq 0)
}

Write-Host @"

  Agent Skills Hub — 总安装
  Hub 路径: $HubDir
  开始时间: $StartTime

"@ -ForegroundColor Green

if (-not (Test-Prerequisites)) {
    Write-Host "`n请先安装缺失依赖后重试。" -ForegroundColor Red
    exit 1
}

Write-Step 1 "Install base skills (226 repos, install-all-skills.ps1)"
Invoke-HubScript "scripts\install-all-skills.ps1"

$waveScripts = @(
    @{ N = 2;  File = "scripts\install-fullstack-skills.ps1";          Title = "Wave 1 — vaquarkhan/Jeffallan/Vercel" },
    @{ N = 3;  File = "scripts\install-fullstack-skills-wave2.ps1";    Title = "Wave 2 — Prisma/Supabase/Stripe/tRPC" },
    @{ N = 4;  File = "scripts\install-fullstack-skills-wave3.ps1";    Title = "Wave 3 — K8s/AWS/GraphQL/Remix" },
    @{ N = 5;  File = "scripts\install-fullstack-skills-wave4.ps1";    Title = "Wave 4 — Cloudflare/Azure/Bun/Svelte" },
    @{ N = 6;  File = "scripts\install-fullstack-skills-wave5.ps1";    Title = "Wave 5 — Rust/Vue/Angular/GCP/MQ" },
    @{ N = 7;  File = "scripts\install-fullstack-skills-wave6.ps1";    Title = "Wave 6 — Flutter/Pulumi/Terraform" },
    @{ N = 8;  File = "scripts\install-fullstack-skills-wave7.ps1";    Title = "Wave 7 — AI/Security/Design/Figma" },
    @{ N = 9;  File = "scripts\install-fullstack-skills-wave8.ps1";    Title = "Wave 8 — Stripe/Sentry/DevOps/PM" },
    @{ N = 10; File = "scripts\install-fullstack-skills-wave9.ps1";    Title = "Wave 9 — DevOps/GitOps/AI/Shopify" },
    @{ N = 11; File = "scripts\install-fullstack-skills-wave10.ps1";   Title = "Wave 10 — Prisma/WordPress/MCP/SRE" },
    @{ N = 12; File = "scripts\install-fullstack-skills-wave11.ps1";   Title = "Wave 11 — 补装 GraphQL/FastAPI/ClickHouse" },
    @{ N = 13; File = "scripts\install-fullstack-skills-wave12.ps1";   Title = "Wave 12 — ClickHouse/Neo4j/FastAPI" },
    @{ N = 14; File = "scripts\install-fullstack-skills-wave13.ps1";   Title = "Wave 13 — LangChain/LangSmith/Snowflake/dbt" },
    @{ N = 15; File = "scripts\install-fullstack-skills-wave14.ps1";   Title = "Wave 14 — Security/AWS/Pentest/Semgrep" },
    @{ N = 16; File = "scripts\install-fullstack-skills-wave15.ps1";   Title = "Wave 15 — Netlify/Cloudflare/Remix/WebSocket" },
    @{ N = 17; File = "scripts\install-fullstack-skills-wave16.ps1";   Title = "Wave 16 — Jest/Cypress/Selenium/Playwright/pnpm" },
    @{ N = 18; File = "scripts\install-fullstack-skills-wave17.ps1";   Title = "Wave 17 — FastAPI/Mobile/Deno/SolidJS/Expo" },
    @{ N = 19; File = "scripts\install-fullstack-skills-wave18.ps1";   Title = "Wave 18 — n8n/Temporal/Neon/VectorDB/Drizzle" },
    @{ N = 20; File = "scripts\install-fullstack-skills-wave19.ps1";   Title = "Wave 19 — AI/Observability/shadcn/Vue/Svelte" },
    @{ N = 21; File = "scripts\install-fullstack-skills-wave20.ps1";   Title = "Wave 20 — Spring/Three.js/GCP/Azure/Pulumi" },
    @{ N = 22; File = "scripts\install-fullstack-skills-wave21.ps1";   Title = "Wave 21 — Rails/Go/K8s/Shopify/WooCommerce" },
    @{ N = 23; File = "scripts\install-fullstack-skills-wave22.ps1";   Title = "Wave 22 — PHP/.NET/DevSecOps/Godot/WordPress" },
    @{ N = 24; File = "scripts\install-fullstack-skills-wave23.ps1";   Title = "Wave 23 — Symfony/Observability/Mobile/Elixir" },
    @{ N = 25; File = "scripts\install-fullstack-skills-wave24.ps1";   Title = "Wave 24 — Datadog/API Platform/KMP/Langs" },
    @{ N = 26; File = "scripts\install-fullstack-skills-wave25.ps1";   Title = "Wave 25 — Symfony/Ansible/Sentry/Nim/Splunk" },
    @{ N = 27; File = "scripts\install-fullstack-skills-wave26.ps1";   Title = "Wave 26 — FastAPI/RNWeb/K8s/IaC/Proxy" },
    @{ N = 28; File = "scripts\install-fullstack-skills-wave27.ps1";   Title = "Wave 27 — Django/GraphQL/Helm/iOS" },
    @{ N = 29; File = "scripts\install-fullstack-skills-wave28.ps1";   Title = "Wave 28 — NestJS/BDD/TF/GitLab/Ruby" },
    @{ N = 30; File = "scripts\install-fullstack-skills-wave29.ps1";   Title = "Wave 29 — Storybook/Vitest/Phoenix/Bun" },
    @{ N = 31; File = "scripts\install-fullstack-skills-wave30.ps1";   Title = "Wave 30 — Vue/Next/Tailwind/Zustand/React" },
    @{ N = 32; File = "scripts\install-fullstack-skills-wave31.ps1";   Title = "Wave 31 — Python/C++/Java/SRE/Shell" },
    @{ N = 33; File = "scripts\install-fullstack-skills-wave32.ps1";   Title = "Wave 32 — TypeScript/Figma/Sentry/Design" },
    @{ N = 34; File = "scripts\install-fullstack-skills-wave33.ps1";   Title = "Wave 33 — GHA/Stripe/SOP/React+Expo" },
    @{ N = 35; File = "scripts\install-fullstack-skills-wave34.ps1";   Title = "Wave 34 — han扫尾/Mobile/SRE/jezweb" },
    @{ N = 36; File = "scripts\install-fullstack-skills-wave35.ps1";   Title = "Wave 35 — han收尾/jezweb/Jeffallan" },
    @{ N = 37; File = "scripts\install-fullstack-skills-wave36.ps1";   Title = "Wave 36 — Vercel/Azure/makfly/vaquarkhan" },
    @{ N = 38; File = "scripts\install-fullstack-skills-wave37.ps1";   Title = "Wave 37 — Sentry/mindrally/aj-geddes/antigravity" },
    @{ N = 39; File = "scripts\install-fullstack-skills-wave38.ps1";   Title = "Wave 38 — mindrally/aj-geddes/bobmatnyc/techleads" },
    @{ N = 40; File = "scripts\install-fullstack-skills-wave38-resume.ps1"; Title = "Wave 38 补跑 — aj-geddes/bobmatnyc/techleads/antigravity" },
    @{ N = 41; File = "scripts\install-fullstack-skills-wave39.ps1";   Title = "Wave 39 — minimax/shubham/andre/alireza/mukul/antigravity" },
    @{ N = 42; File = "scripts\install-fullstack-skills-wave39-resume.ps1"; Title = "Wave 39 补跑 — TLS失败批次/antigravity/techleads" },
    @{ N = 43; File = "scripts\install-fullstack-skills-wave40.ps1";   Title = "Wave 40 — shubham重试/alireza/mukul/antigravity" },
    @{ N = 44; File = "scripts\install-fullstack-skills-wave41.ps1";   Title = "Wave 41 — alirezarezvani/mukul/antigravity" },
    @{ N = 45; File = "scripts\install-fullstack-skills-wave42.ps1";   Title = "Wave 42 — alirezarezvani/mukul/antigravity" }
)

foreach ($w in $waveScripts) {
    Write-Step $w.N $w.Title
    Invoke-HubScript $w.File
}

Write-Step 46 "Wave 16 retry with mirror fallback (install-fullstack-skills-wave16-retry.ps1)"
if (Test-Path (Join-Path $ScriptsDir "install-fullstack-skills-wave16-retry.ps1")) {
    Invoke-HubScript "scripts\install-fullstack-skills-wave16-retry.ps1"
}

Write-Step 47 "Retry previously failed skills (final-retry-skills.ps1)"
if (Test-Path (Join-Path $ScriptsDir "final-retry-skills.ps1")) {
    Invoke-HubScript "scripts\final-retry-skills.ps1"
} else {
    Write-Host "跳过（无 final-retry-skills.ps1）" -ForegroundColor DarkGray
}

Write-Step 48 "Sync metadata + update Chinese docs"
Invoke-HubScript "update-docs.ps1"

$EndTime = Get-Date
$Duration = $EndTime - $StartTime
$ClaudeSkillsDir = Join-Path $env:USERPROFILE ".claude\skills"
$SkillCount = if (Test-Path $ClaudeSkillsDir) {
    (Get-ChildItem $ClaudeSkillsDir -Directory -ErrorAction SilentlyContinue).Count
} else { 0 }

Write-Host @"

========================================
  总安装完成
========================================
  耗时: $($Duration.ToString('hh\:mm\:ss'))
  Claude 技能数: $SkillCount
  中文手册: $HubDir\docs\SKILLS-REFERENCE-CN.md
  Claude 副本: $env:USERPROFILE\.claude\SKILLS-REFERENCE-CN.md
  技能目录: $ClaudeSkillsDir
  路径说明: $HubDir\docs\PATHS-CN.md

"@ -ForegroundColor Green
