# Wave 46: 开发工具/安全/逆向/平台技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 46: 开发工具/安全/逆向/平台技能 ===" -ForegroundColor Cyan

# 1. Android 逆向工程
Write-Host "`n[1] Android Reverse Engineering Skill..." -ForegroundColor Yellow
npx skills add https://github.com/SimoneAvogadro/android-reverse-engineering-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

# 2. 逆向技能
Write-Host "[2] Reverse Skills (逆向工程)..." -ForegroundColor Yellow
npx skills add https://github.com/P4nda0s/reverse-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

# 3. 自动技能安装
Write-Host "[3] Autoskills (midudev)..." -ForegroundColor Yellow
npx skills add https://github.com/midudev/autoskills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

# 4. Skill Scanner (Cisco 安全扫描)
Write-Host "[4] Skill Scanner (安全扫描)..." -ForegroundColor Yellow
npx skills add https://github.com/cisco-ai-defense/skill-scanner -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

# 5. SkillSpector (NVIDIA 安全扫描)
Write-Host "[5] SkillSpector..." -ForegroundColor Yellow
npx skills add https://github.com/NVIDIA/SkillSpector -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

# 6. 专业技能市场
Write-Host "[6] Claude Code Skills Marketplace..." -ForegroundColor Yellow
npx skills add https://github.com/daymade/claude-code-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

# 7. .NET 技能
Write-Host "[7] .NET Skills (Aaronontheweb)..." -ForegroundColor Yellow
npx skills add https://github.com/Aaronontheweb/dotnet-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

# 8. AWS Agent Toolkit
Write-Host "[8] AWS Agent Toolkit..." -ForegroundColor Yellow
npx skills add https://github.com/aws/agent-toolkit-for-aws -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

# 9. GitHub Copilot Plugins
Write-Host "[9] GitHub Copilot Plugins..." -ForegroundColor Yellow
npx skills add https://github.com/github/copilot-plugins -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

# 10. 他山 Cursor Skills (95个技能)
Write-Host "[10] Tashan Cursor Skills (95个)..." -ForegroundColor Yellow
npx skills add https://github.com/TashanGKD/tashan-cursor-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave46.log

Write-Host "`n=== Wave 46 完成 ===" -ForegroundColor Green
