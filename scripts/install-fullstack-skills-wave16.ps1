# 全栈技能 Wave 16 — 测试框架补装（Jest / Cypress / Selenium / Playwright / Vitest / pnpm / gRPC）
#
# 仓库来源（skills.sh 检索 + --list 校验，避免 sickn33 大仓库）:
#   LambdaTest/agent-skills          https://github.com/LambdaTest/agent-skills
#   mindrally/skills                   https://github.com/mindrally/skills
#   cypress-io/ai-toolkit              https://github.com/cypress-io/ai-toolkit
#   trailofbits/skills                 https://github.com/trailofbits/skills
#   antfu/skills                       https://github.com/antfu/skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave16-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave16"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 16 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- LambdaTest 核心测试框架 ---
Run-SkillBatch -Label "lambdatest-core-testing" -Repo "https://github.com/LambdaTest/agent-skills" -Skills @(
    "jest-skill","cypress-skill","selenium-skill","playwright-skill","vitest-skill"
)

# --- LambdaTest 迁移 / 云执行 ---
Run-SkillBatch -Label "lambdatest-migration-cloud" -Repo "https://github.com/LambdaTest/agent-skills" -Skills @(
    "test-framework-migration-skill","hyperexecute-skill","pytest-skill","webdriverio-skill"
)

# --- mindrally 通用测试 / 工具链 ---
Run-SkillBatch -Label "mindrally-testing-tools" -Repo "https://github.com/mindrally/skills" -Skills @(
    "jest","selenium-automation","pnpm","grpc-development"
)

# --- Cypress 官方 AI Toolkit ---
Run-SkillBatch -Label "cypress-official-ai" -Repo "https://github.com/cypress-io/ai-toolkit" -Skills @(
    "cypress-author","cypress-docs","cypress-explain"
)

# --- Trail of Bits 测试手册生成 ---
Run-SkillBatch -Label "trailofbits-testing-handbook" -Repo "https://github.com/trailofbits/skills" -Skills @(
    "testing-handbook-generator"
)

# --- antfu pnpm（mindrally 已有 pnpm 时可跳过）---
Run-SkillBatch -Label "antfu-pnpm" -Repo "https://github.com/antfu/skills" -Skills @("pnpm")

"`nWave 16 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 16 complete: $summaryFile" -ForegroundColor Green
Write-Host "若部分失败，请运行: scripts\install-fullstack-skills-wave16-retry.ps1" -ForegroundColor DarkGray
