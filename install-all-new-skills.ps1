# Agent Skills Hub - 新技能总安装入口
# Wave 43-61 一键安装
# 运行: powershell -ExecutionPolicy Bypass -File install-all-new-skills.ps1

$ErrorActionPreference = "Continue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Agent Skills Hub - 新技能总安装" -ForegroundColor Cyan
Write-Host "  Wave 43-61 (共19个安装脚本)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$totalWaves = 19
$currentWave = 0

# 所有 Wave 脚本
$allWaves = @(
    @{Name="Wave 43: 官方/大型技能库"; Script="scripts/install-new-skills-wave43.ps1"},
    @{Name="Wave 44: 实用工具技能"; Script="scripts/install-new-skills-wave44.ps1"},
    @{Name="Wave 45: 中文/营销/视频/交易"; Script="scripts/install-new-skills-wave45.ps1"},
    @{Name="Wave 46: 开发工具/安全/逆向"; Script="scripts/install-new-skills-wave46.ps1"},
    @{Name="Wave 47: 精选合集/工作流"; Script="scripts/install-new-skills-wave47.ps1"},
    @{Name="Wave 48: 代码审查/开发者工具/LLM"; Script="scripts/install-new-skills-wave48.ps1"},
    @{Name="Wave 49: 实用工具/设计提取/视频"; Script="scripts/install-new-skills-wave49.ps1"},
    @{Name="Wave 50: 个人技能集合/资产注册"; Script="scripts/install-new-skills-wave50.ps1"},
    @{Name="Wave 51: 安全测试技能"; Script="scripts/install-new-skills-wave51.ps1"},
    @{Name="Wave 52: 提示工程技能"; Script="scripts/install-new-skills-wave52.ps1"},
    @{Name="Wave 53: 文档/QA/架构"; Script="scripts/install-new-skills-wave53.ps1"},
    @{Name="Wave 54: Git工作流/性能优化"; Script="scripts/install-new-skills-wave54.ps1"},
    @{Name="Wave 55: 综合技能包/中文技能"; Script="scripts/install-new-skills-wave55.ps1"},
    @{Name="Wave 56: 调试/重构/代理技能"; Script="scripts/install-new-skills-wave56.ps1"},
    @{Name="Wave 57: 官方/大型技能库"; Script="scripts/install-new-skills-wave57.ps1"},
    @{Name="Wave 58: Claude技能工厂/代码审查"; Script="scripts/install-new-skills-wave58.ps1"},
    @{Name="Wave 59: MCP Server/工具/代码生成"; Script="scripts/install-new-skills-wave59.ps1"},
    @{Name="Wave 60: CLI工具/代码生成/管理"; Script="scripts/install-new-skills-wave60.ps1"},
    @{Name="Wave 61: 全栈/集成技能"; Script="scripts/install-new-skills-wave61.ps1"}
)

foreach ($wave in $allWaves) {
    $currentWave++
    Write-Host "[$currentWave/$totalWaves] $($wave.Name)..." -ForegroundColor Yellow
    
    if (Test-Path $wave.Script) {
        & powershell -ExecutionPolicy Bypass -File $wave.Script 2>$null
    } else {
        Write-Host "  脚本不存在: $($wave.Script)" -ForegroundColor Red
    }
    
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Green
Write-Host "  安装完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "后续操作:" -ForegroundColor Yellow
Write-Host "1. 运行 .\update-docs.ps1 更新文档" -ForegroundColor White
Write-Host "2. 查看日志: ls logs\" -ForegroundColor White
Write-Host "3. 手册: ~/.claude/SKILLS-REFERENCE-CN.md" -ForegroundColor White
