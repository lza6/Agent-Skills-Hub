# Wave 54: Git工作流/性能优化技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 54: Git工作流/性能优化技能 ===" -ForegroundColor Cyan

# 1. Git 工作流技能
Write-Host "`n[1] Git Workflow Skill (netresearch)..." -ForegroundColor Yellow
npx skills add https://github.com/netresearch/git-workflow-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

# 2. Git 工作流技能
Write-Host "[2] Git Workflow Skill (freeman983)..." -ForegroundColor Yellow
npx skills add https://github.com/freeman983/git-workflow-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

# 3. Git 工作流技能
Write-Host "[3] Git Workflow Skills (HermeticOrmus)..." -ForegroundColor Yellow
npx skills add https://github.com/HermeticOrmus/git-workflow-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

# 4. GitHub 工作流技能
Write-Host "[4] GitHub Workflow Skill..." -ForegroundColor Yellow
npx skills add https://github.com/martinvidec/github-workflow-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

# 5. Git/GitHub 工作流
Write-Host "[5] Git GitHub Workflow Skill..." -ForegroundColor Yellow
npx skills add https://github.com/ivogabriel19/git-github-workflow-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

# 6. Claude Code GitHub 工作流
Write-Host "[6] Claude Code GitHub Workflow Skills..." -ForegroundColor Yellow
npx skills add https://github.com/jtaub/claude-code-github-workflow-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

# 7. C++ 性能技能
Write-Host "[7] C++ Perf Skills..." -ForegroundColor Yellow
npx skills add https://github.com/rollysys/cpp-perf-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

# 8. 代码性能优化器
Write-Host "[8] Code Performance Optimizer..." -ForegroundColor Yellow
npx skills add https://github.com/hireblackout/code-performance-optimizer-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

# 9. 极致优化器
Write-Host "[9] Extreme Optimizer..." -ForegroundColor Yellow
npx skills add https://github.com/lapbrian2/extreme-optimizer -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

# 10. React 性能技能
Write-Host "[10] React Performance Skill..." -ForegroundColor Yellow
npx skills add https://github.com/syedmohammeda12-spec/react-performance-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave54.log

Write-Host "`n=== Wave 54 完成 ===" -ForegroundColor Green
