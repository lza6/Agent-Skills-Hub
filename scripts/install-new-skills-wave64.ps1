# Wave 64: 设计模式技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 64: 设计模式技能 ===" -ForegroundColor Cyan

# 1. Agentic Design Patterns Skills (多语言)
Write-Host "`n[1] Agentic Design Patterns Skills..." -ForegroundColor Yellow
npx skills add https://github.com/hajekim/agentic-design-patterns-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave64.log

# 2. Design Pattern Skill (xie-tj)
Write-Host "[2] Design Pattern Skill (23 GoF)..." -ForegroundColor Yellow
npx skills add https://github.com/xie-tj/DesignPattern-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave64.log

# 3. Design Patterns Skill (Mosweed)
Write-Host "[3] Design Patterns Skill (Mosweed)..." -ForegroundColor Yellow
npx skills add https://github.com/Mosweed/design-patterns-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave64.log

# 4. Software Best Design Patterns Skill
Write-Host "[4] Software Best Design Patterns Skill..." -ForegroundColor Yellow
npx skills add https://github.com/gastonmorixe/software-best-design-patterns-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave64.log

# 5. Design Patterns (VoDaiLocz)
Write-Host "[5] Design Patterns (Full Spectrum)..." -ForegroundColor Yellow
npx skills add https://github.com/VoDaiLocz/Design-Patterns -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave64.log

# 6. Unity Design Patterns Skills
Write-Host "[6] Unity Design Patterns Skills..." -ForegroundColor Yellow
npx skills add https://github.com/Linalab-io/unity-design-patterns-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave64.log

# 7. React Design Patterns Skills
Write-Host "[7] React Design Patterns Skills..." -ForegroundColor Yellow
npx skills add https://github.com/pjt3591oo/react-design-patterns-skills-for-agent -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave64.log

# 8. Design Pattern Skill (sirius-zuo)
Write-Host "[8] Design Pattern Skill (Architecture)..." -ForegroundColor Yellow
npx skills add https://github.com/sirius-zuo/design-pattern-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave64.log

Write-Host "`n=== Wave 64 完成 ===" -ForegroundColor Green
