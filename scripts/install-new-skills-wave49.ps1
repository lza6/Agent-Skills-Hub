# Wave 49: 实用工具/设计提取/视频生成/一键安装
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 49: 实用工具/设计提取/视频生成 ===" -ForegroundColor Cyan

# 1. 设计系统提取
Write-Host "`n[1] Extract Design System..." -ForegroundColor Yellow
npx skills add https://github.com/arvindrk/extract-design-system -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

# 2. 视频提示词技能
Write-Host "[2] Vibe Creating Skill (视频生成)..." -ForegroundColor Yellow
npx skills add https://github.com/Alisa0808/vibe-creating-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

# 3. 从创意到上线
Write-Host "[3] Idea to Ship Skills..." -ForegroundColor Yellow
npx skills add https://github.com/nelsonwerd/idea-to-ship-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

# 4. Claude 设计风格
Write-Host "[4] Claude Design Style..." -ForegroundColor Yellow
npx skills add https://github.com/catyiqian/claude-design-style -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

# 5. 一键安装 50+ 技能
Write-Host "[5] Skill Blast..." -ForegroundColor Yellow
npx skills add https://github.com/Venkatesh-6921/skill-blast -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

# 6. 90,000+ 技能库
Write-Host "[6] Awesome Skill Forge..." -ForegroundColor Yellow
npx skills add https://github.com/Lord1Egypt/awesome-skill-forge -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

# 7. 韩语技能合集
Write-Host "[7] Awesome Korean Agent Skills..." -ForegroundColor Yellow
npx skills add https://github.com/J-nowcow/awesome-korean-agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

# 8. 技能管理器
Write-Host "[8] Skills Manager..." -ForegroundColor Yellow
npx skills add https://github.com/EfanWang/skills-manager -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

# 9. 自动清理技能
Write-Host "[9] Auto Cleanup Skill..." -ForegroundColor Yellow
npx skills add https://github.com/Wha1eChai/auto-cleanup-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

# 10. 技能编译器
Write-Host "[10] Skill Compiler..." -ForegroundColor Yellow
npx skills add https://github.com/Nexa-Language/Skill-Compiler -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave49.log

Write-Host "`n=== Wave 49 完成 ===" -ForegroundColor Green
