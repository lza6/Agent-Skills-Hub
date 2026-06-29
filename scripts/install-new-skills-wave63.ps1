# Wave 63: 状态管理/API设计/内部审计技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 63: 状态管理/API设计/内部审计技能 ===" -ForegroundColor Cyan

# 1. Task Tracker (状态管理)
Write-Host "`n[1] Task Tracker..." -ForegroundColor Yellow
npx skills add https://github.com/rikouu/task-tracker -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave63.log

# 2. Google API Design Skill
Write-Host "[2] Google API Design Skill..." -ForegroundColor Yellow
npx skills add https://github.com/IveTian/google-api-design-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave63.log

# 3. Express API Design Skill (中文)
Write-Host "[3] Express API Design Skill (中文)..." -ForegroundColor Yellow
npx skills add https://github.com/LiuDaZheng/express-api-design-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave63.log

# 4. API Design AI Skills
Write-Host "[4] API Design AI Skills..." -ForegroundColor Yellow
npx skills add https://github.com/hazamashoken/api-design-ai-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave63.log

# 5. Internal Audit Ops
Write-Host "[5] Internal Audit Ops..." -ForegroundColor Yellow
npx skills add https://github.com/lucasbrisolla/internal-audit-ops -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave63.log

# 6. Accounting Ops
Write-Host "[6] Accounting Ops..." -ForegroundColor Yellow
npx skills add https://github.com/lucasbrisolla/accounting-ops -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave63.log

Write-Host "`n=== Wave 63 完成 ===" -ForegroundColor Green
