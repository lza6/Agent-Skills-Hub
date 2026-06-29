# Wave 55: 综合技能包/中文技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 55: 综合技能包/中文技能 ===" -ForegroundColor Cyan

# 1. WordPress 开发技能
Write-Host "`n[1] WordPress Dev Skills..." -ForegroundColor Yellow
npx skills add https://github.com/CrazySwami/wordpress-dev-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

# 2. Windows 优化技能
Write-Host "[2] Windows Optimize..." -ForegroundColor Yellow
npx skills add https://github.com/prabhatp75/windows-optimize -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

# 3. Python 性能优化
Write-Host "[3] Python Vibeperf..." -ForegroundColor Yellow
npx skills add https://github.com/MickLife/python-vibeperf -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

# 4. Android 性能技能
Write-Host "[4] Android Performance Skills..." -ForegroundColor Yellow
npx skills add https://github.com/helsonzhao/SkillsForAndroidPerformance -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

# 5. iOS 性能优化
Write-Host "[5] iOS Performance Optimizer..." -ForegroundColor Yellow
npx skills add https://github.com/josuediazflores/ios-performance-optimizer-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

# 6. Tailwind Agent Skills
Write-Host "[6] Tailwind Agent Skills..." -ForegroundColor Yellow
npx skills add https://github.com/Lombiq/Tailwind-Agent-Skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

# 7. 文档技能包
Write-Host "[7] Documentation Skill Pack..." -ForegroundColor Yellow
npx skills add https://github.com/609844066/documentation-skill-pack -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

# 8. API 测试文档技能
Write-Host "[8] Claude API Tester..." -ForegroundColor Yellow
npx skills add https://github.com/IncomeStreamSurfer/claude-api-tester -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

# 9. Gemini 文档技能
Write-Host "[9] Gemini Documentation Skills..." -ForegroundColor Yellow
npx skills add https://github.com/davegomez/gemini-documentation-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

# 10. GitHub 文档技能
Write-Host "[10] GitHub Documentation Skills..." -ForegroundColor Yellow
npx skills add https://github.com/jasperdevs/github-documentation-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave55.log

Write-Host "`n=== Wave 55 完成 ===" -ForegroundColor Green
