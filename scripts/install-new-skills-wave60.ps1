# Wave 60: CLI工具/代码生成/管理技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 60: CLI工具/代码生成/管理技能 ===" -ForegroundColor Cyan

# 1. CLI Tools Skill
Write-Host "`n[1] CLI Tools Skill..." -ForegroundColor Yellow
npx skills add https://github.com/netresearch/cli-tools-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

# 2. CLI Power Skills
Write-Host "[2] CLI Power Skills..." -ForegroundColor Yellow
npx skills add https://github.com/ykotik/cli-power-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

# 3. OpenCode Skills
Write-Host "[3] OpenCode Skills..." -ForegroundColor Yellow
npx skills add https://github.com/hosseinmirzapur/opencode-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

# 4. CLI Toolkit Skills
Write-Host "[4] CLI Toolkit Skills..." -ForegroundColor Yellow
npx skills add https://github.com/KalebCole/cli-toolkit-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

# 5. Keepup AI Tools
Write-Host "[5] Keepup AI Tools..." -ForegroundColor Yellow
npx skills add https://github.com/liuqi1024/keepup-ai-tools -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

# 6. Kyrell OS Marketplace
Write-Host "[6] Kyrell OS Marketplace..." -ForegroundColor Yellow
npx skills add https://github.com/kyrelldixon/kyrell-os-marketplace -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

# 7. AWS CLI Skills
Write-Host "[7] AWS CLI Skills..." -ForegroundColor Yellow
npx skills add https://github.com/ordiy/aws-cli-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

# 8. 代码生成技能 (中文)
Write-Host "[8] Code Generation Skill (中文)..." -ForegroundColor Yellow
npx skills add https://github.com/lunashia/code-generation-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

# 9. 嵌入式代码生成技能
Write-Host "[9] FAE Embedded Code Generation..." -ForegroundColor Yellow
npx skills add https://github.com/sinemcu/FAE_embedded_code_generation_SKILL -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

# 10. Laravel 最佳实践技能
Write-Host "[10] Laravel Best Practices Skill..." -ForegroundColor Yellow
npx skills add https://github.com/0xmergen/laravel-best-practices-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave60.log

Write-Host "`n=== Wave 60 完成 ===" -ForegroundColor Green
