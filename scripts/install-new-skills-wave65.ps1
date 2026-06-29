# Wave 65: 部署/配置技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 65: 部署/配置技能 ===" -ForegroundColor Cyan

# 1. Preview Deployments Skill
Write-Host "`n[1] Preview Deployments Skill..." -ForegroundColor Yellow
npx skills add https://github.com/zeke/preview-deployments-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

# 2. SI Coder Agent (全栈部署)
Write-Host "[2] SI Coder Agent..." -ForegroundColor Yellow
npx skills add https://github.com/rahmanef63/si-coder-agent -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

# 3. Deployment Skills
Write-Host "[3] Deployment Skills..." -ForegroundColor Yellow
npx skills add https://github.com/mabebrahimi/deployment-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

# 4. xCloud Docker Deploy Skill
Write-Host "[4] xCloud Docker Deploy Skill..." -ForegroundColor Yellow
npx skills add https://github.com/Asif2BD/xCloud-Docker-Deploy-Skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

# 5. Codex TestFlight Skill
Write-Host "[5] Codex TestFlight Skill..." -ForegroundColor Yellow
npx skills add https://github.com/KewkLW/codex-testflight-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

# 6. Claude Code Blueprint
Write-Host "[6] Claude Code Blueprint..." -ForegroundColor Yellow
npx skills add https://github.com/Aedelon/claude-code-blueprint -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

# 7. Claude Metaskill
Write-Host "[7] Claude Metaskill..." -ForegroundColor Yellow
npx skills add https://github.com/werkamsus/claude-metaskill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

# 8. DS AI Coding Skills (数据科学家)
Write-Host "[8] DS AI Coding Skills..." -ForegroundColor Yellow
npx skills add https://github.com/atsushi-green/ds-ai-coding-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

# 9. Claude Dotfiles
Write-Host "[9] Claude Dotfiles..." -ForegroundColor Yellow
npx skills add https://github.com/peopleforrester/claude-dotfiles -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

# 10. CC Workshop
Write-Host "[10] CC Workshop..." -ForegroundColor Yellow
npx skills add https://github.com/O0000-code/CC-Workshop -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave65.log

Write-Host "`n=== Wave 65 完成 ===" -ForegroundColor Green
