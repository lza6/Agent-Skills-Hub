# Wave 52: 提示工程技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 52: 提示工程技能 ===" -ForegroundColor Cyan

# 1. 综合提示工程
Write-Host "`n[1] Prompt Engineering Skills (treylom)..." -ForegroundColor Yellow
npx skills add https://github.com/treylom/prompt-engineering-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave52.log

# 2. 提示工程技能
Write-Host "[2] Prompt Engineering Skill (PhAlves23)..." -ForegroundColor Yellow
npx skills add https://github.com/PhAlves23/prompt-engineering-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave52.log

# 3. DailyForge 提示工程
Write-Host "[3] DailyForge..." -ForegroundColor Yellow
npx skills add https://github.com/luxie47/DailyForge -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave52.log

# 4. Claude 提示工程技能 (中文)
Write-Host "[4] Claude Prompt Engineering Skills (中文)..." -ForegroundColor Yellow
npx skills add https://github.com/ponyodong2026/claude-prompt-engineering-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave52.log

# 5. CUE 技能
Write-Host "[5] CUE Skill..." -ForegroundColor Yellow
npx skills add https://github.com/clawdbot58-pixel/cue-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave52.log

# 6. 梦幻机器人提示工程
Write-Host "[6] Dreamybot Prompt Engineering..." -ForegroundColor Yellow
npx skills add https://github.com/dreamybot/prompt-engineering-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave52.log

# 7. 六层提示设计框架
Write-Host "[7] CYYDark Prompt Engineering..." -ForegroundColor Yellow
npx skills add https://github.com/cyydark/prompt-engineering-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave52.log

# 8. 模型无关提示工程
Write-Host "[8] Kzhekov Prompt Engineering..." -ForegroundColor Yellow
npx skills add https://github.com/kzhekov/Prompt-Engineering-Skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave52.log

Write-Host "`n=== Wave 52 完成 ===" -ForegroundColor Green
