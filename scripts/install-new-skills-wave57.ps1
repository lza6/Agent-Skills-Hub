# Wave 57: 官方/大型技能库
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 57: 官方/大型技能库 ===" -ForegroundColor Cyan

# 1. HashiCorp 技能
Write-Host "`n[1] HashiCorp Agent Skills..." -ForegroundColor Yellow
npx skills add https://github.com/hashicorp/agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

# 2. WordPress 官方技能
Write-Host "[2] WordPress Agent Skills..." -ForegroundColor Yellow
npx skills add https://github.com/WordPress/agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

# 3. Supabase 技能
Write-Host "[3] Supabase Agent Skills..." -ForegroundColor Yellow
npx skills add https://github.com/supabase/agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

# 4. CallStack React Native 技能
Write-Host "[4] CallStack Agent Skills (React Native)..." -ForegroundColor Yellow
npx skills add https://github.com/callstackincubator/agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

# 5. SwiftUI Agent Skill
Write-Host "[5] SwiftUI Agent Skill (twostraws)..." -ForegroundColor Yellow
npx skills add https://github.com/twostraws/SwiftUI-Agent-Skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

# 6. SwiftUI Agent Skill (AvdLee)
Write-Host "[6] SwiftUI Agent Skill (AvdLee)..." -ForegroundColor Yellow
npx skills add https://github.com/AvdLee/SwiftUI-Agent-Skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

# 7. Swift Concurrency Agent Skill
Write-Host "[7] Swift Concurrency Agent Skill..." -ForegroundColor Yellow
npx skills add https://github.com/AvdLee/Swift-Concurrency-Agent-Skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

# 8. Swift Agent Skills
Write-Host "[8] Swift Agent Skills..." -ForegroundColor Yellow
npx skills add https://github.com/twostraws/Swift-Agent-Skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

# 9. Microsoft Azure 技能
Write-Host "[9] Microsoft Agent Skills..." -ForegroundColor Yellow
npx skills add https://github.com/MicrosoftDocs/Agent-Skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

# 10. Tech Leads Club 技能
Write-Host "[10] Tech Leads Club Agent Skills..." -ForegroundColor Yellow
npx skills add https://github.com/tech-leads-club/agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave57.log

Write-Host "`n=== Wave 57 完成 ===" -ForegroundColor Green
