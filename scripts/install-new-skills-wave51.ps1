# Wave 51: 安全测试技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 51: 安全测试技能 ===" -ForegroundColor Cyan

# 1. 红队测试技能
Write-Host "`n[1] Audn AI Skills (红队测试)..." -ForegroundColor Yellow
npx skills add https://github.com/audn-ai/skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave51.log

# 2. 安全技能市场
Write-Host "[2] Security Skills Marketplace..." -ForegroundColor Yellow
npx skills add https://github.com/mohdhaji87/security-skills-marketplace -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave51.log

# 3. 安全测试技能
Write-Host "[3] Security Testing Skill..." -ForegroundColor Yellow
npx skills add https://github.com/cookiesen77-rgb/security-testing-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave51.log

# 4. 渗透测试技能包
Write-Host "[4] Pentest Security Testing Skills..." -ForegroundColor Yellow
npx skills add https://github.com/45ck/pentest-security-testing-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave51.log

# 5. Web 安全测试
Write-Host "[5] Web Security Testing Skills..." -ForegroundColor Yellow
npx skills add https://github.com/diy777/web-security-testing-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave51.log

Write-Host "`n=== Wave 51 完成 ===" -ForegroundColor Green
