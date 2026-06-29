# Wave 53: 文档/QA/架构技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 53: 文档/QA/架构技能 ===" -ForegroundColor Cyan

# 1. QA 技能 (50+ 技能)
Write-Host "`n[1] QA Skills (50+)..." -ForegroundColor Yellow
npx skills add https://github.com/petrkindlmann/qa-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

# 2. 文档技能工具包
Write-Host "[2] Documentation Skills Toolkit..." -ForegroundColor Yellow
npx skills add https://github.com/lampd-2157/documentation-skills-toolkit -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

# 3. 文档技能生成器
Write-Host "[3] Documentation Skill Generator..." -ForegroundColor Yellow
npx skills add https://github.com/AureliustechandTalentSolutions/DocumentationSkillGenerator -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

# 4. AI API 测试技能
Write-Host "[4] AI API Test Skill..." -ForegroundColor Yellow
npx skills add https://github.com/buer2233/ai-api-test-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

# 5. 架构设计技能
Write-Host "[5] Architecture Design Skill..." -ForegroundColor Yellow
npx skills add https://github.com/sandpl/architecture-design-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

# 6. 前端架构设计
Write-Host "[6] Frontend Architecture Designer..." -ForegroundColor Yellow
npx skills add https://github.com/Skyinfi/frontend-architecture-designer-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

# 7. 多代理架构师
Write-Host "[7] Multi-Agent Architect..." -ForegroundColor Yellow
npx skills add https://github.com/daydaydream233/multi-agent-architect -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

# 8. Obsidian 文档技能
Write-Host "[8] Obsidian Documentation Skill..." -ForegroundColor Yellow
npx skills add https://github.com/rubber-ducks-syndicate/obsidian-documentation-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

# 9. PKM 文档
Write-Host "[9] PKM Documentation..." -ForegroundColor Yellow
npx skills add https://github.com/balin-ar/pkm-documentation -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

# 10. 视觉文档
Write-Host "[10] Visual Docs..." -ForegroundColor Yellow
npx skills add https://github.com/PabloNAX/visual-docs -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave53.log

Write-Host "`n=== Wave 53 完成 ===" -ForegroundColor Green
