# Wave 44: 实用工具技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 44: 实用工具技能 ===" -ForegroundColor Cyan

# 1. Humanizer - 消除 AI 生成痕迹
Write-Host "`n[1] Humanizer (blader/humanizer)..." -ForegroundColor Yellow
npx skills add https://github.com/blader/humanizer -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

# 2. Humanizer 中文版
Write-Host "[2] Humanizer 中文版 (op7418/Humanizer-zh)..." -ForegroundColor Yellow
npx skills add https://github.com/op7418/Humanizer-zh -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

# 3. Caveman - 节省 65% tokens
Write-Host "[3] Caveman (JuliusBrussee/caveman)..." -ForegroundColor Yellow
npx skills add https://github.com/JuliusBrussee/caveman -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

# 4. PDF 转 Markdown
Write-Host "[4] PDF2MD Skill (yuhaoliu7456/pdf2md-skill)..." -ForegroundColor Yellow
npx skills add https://github.com/yuhaoliu7456/pdf2md-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

# 5. 书籍转技能
Write-Host "[5] Book to Skill (virgiliojr94/book-to-skill)..." -ForegroundColor Yellow
npx skills add https://github.com/virgiliojr94/book-to-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

# 6. 代码库转课程
Write-Host "[6] Codebase to Course (zarazhangrui/codebase-to-course)..." -ForegroundColor Yellow
npx skills add https://github.com/zarazhangrui/codebase-to-course -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

# 7. 架构图生成器
Write-Host "[7] Architecture Diagram Generator..." -ForegroundColor Yellow
npx skills add https://github.com/Cocoon-AI/architecture-diagram-generator -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

# 8. Nothing 设计风格
Write-Host "[8] Nothing Design Skill..." -ForegroundColor Yellow
npx skills add https://github.com/dominikmartn/nothing-design-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

# 9. UI Design Brain - 60+ 组件知识
Write-Host "[9] UI Design Brain..." -ForegroundColor Yellow
npx skills add https://github.com/carmahhawwari/ui-design-brain -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

# 10. 深度阅读分析
Write-Host "[10] Deep Reading Analyst Skill..." -ForegroundColor Yellow
npx skills add https://github.com/ginobefun/deep-reading-analyst-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave44.log

Write-Host "`n=== Wave 44 完成 ===" -ForegroundColor Green
