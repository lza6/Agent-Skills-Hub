# Wave 50: 个人技能集合/资产注册/工作流
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 50: 个人技能集合/资产注册 ===" -ForegroundColor Cyan

# 1. Off-the-shelf 资产注册
Write-Host "`n[1] Off-the-shelf (资产注册表)..." -ForegroundColor Yellow
npx skills add https://github.com/XeldarAlz/off-the-shelf -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

# 2. Obsidian 技能管理器
Write-Host "[2] Obsidian Skills Manager..." -ForegroundColor Yellow
npx skills add https://github.com/cbruyndoncx/obsidian-skills-manager -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

# 3. Modsearch 搜索工具
Write-Host "[3] Modsearch..." -ForegroundColor Yellow
npx skills add https://github.com/liustack/modsearch -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

# 4. Dualform 开发工具
Write-Host "[4] Dualform Labs..." -ForegroundColor Yellow
npx skills add https://github.com/dualform-labs/.github -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

# 5. 个人技能集
Write-Host "[5] HCaiano Skills..." -ForegroundColor Yellow
npx skills add https://github.com/hcaiano/skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

# 6. 个人技能集
Write-Host "[6] Steve Derico Skills..." -ForegroundColor Yellow
npx skills add https://github.com/stevederico/skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

# 7. 个人技能集
Write-Host "[7] PMarreck LLM Skills..." -ForegroundColor Yellow
npx skills add https://github.com/pmarreck/llm_skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

# 8. Dot Agents
Write-Host "[8] Dot Agents..." -ForegroundColor Yellow
npx skills add https://github.com/PaulRBerg/dot-agents -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

# 9. WebGPU Metal 调试
Write-Host "[9] WebGPU Metal Debug Kit..." -ForegroundColor Yellow
npx skills add https://github.com/penspanic/webgpu-metal-debug-kit -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

# 10. Woo Review
Write-Host "[10] Woo Review (PR 审查)..." -ForegroundColor Yellow
npx skills add https://github.com/howarewoo/woo-review -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave50.log

Write-Host "`n=== Wave 50 完成 ===" -ForegroundColor Green
