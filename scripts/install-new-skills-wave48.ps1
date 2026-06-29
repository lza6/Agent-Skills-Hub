# Wave 48: 代码审查/开发者工具/LLM技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 48: 代码审查/开发者工具/LLM技能 ===" -ForegroundColor Cyan

# 1. 综合代码审查技能
Write-Host "`n[1] Code Review Skill (awesome-skills)..." -ForegroundColor Yellow
npx skills add https://github.com/awesome-skills/code-review-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

# 2. 三元技能 (SOLID/安全/性能)
Write-Host "[2] Sanyuan Skills..." -ForegroundColor Yellow
npx skills add https://github.com/sanyuan0704/sanyuan-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

# 3. 网络安全代码审查
Write-Host "[3] Claude Cybersecurity..." -ForegroundColor Yellow
npx skills add https://github.com/AgriciDaniel/claude-cybersecurity -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

# 4. 代码审查分析器
Write-Host "[4] Code Review Analyzer..." -ForegroundColor Yellow
npx skills add https://github.com/michaelshimeles/code-review-analyzer -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

# 5. 中文代码审查（整洁之道）
Write-Host "[5] Clean Code Reviewer Skills (中文)..." -ForegroundColor Yellow
npx skills add https://github.com/googs1025/clean-code-reviewer-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

# 6. 跨模型代码审查
Write-Host "[6] Cross Model Code Review Skill..." -ForegroundColor Yellow
npx skills add https://github.com/craigkitterman/cross-model-code-review-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

# 7. 嵌入式代码审查
Write-Host "[7] Embedded Review..." -ForegroundColor Yellow
npx skills add https://github.com/ylongw/embedded-review -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

# 8. Go 最佳实践
Write-Host "[8] Golang Best Practices Skill..." -ForegroundColor Yellow
npx skills add https://github.com/saifoelloh/golang-best-practices-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

# 9. 开发者工具技能
Write-Host "[9] Asynkron Skills..." -ForegroundColor Yellow
npx skills add https://github.com/asynkron/asynkron-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

# 10. LLM 技能合集
Write-Host "[10] LLM Awesome Skills..." -ForegroundColor Yellow
npx skills add https://github.com/chenhanlu569-ship-it/LLM-Awesome-Skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave48.log

Write-Host "`n=== Wave 48 完成 ===" -ForegroundColor Green
