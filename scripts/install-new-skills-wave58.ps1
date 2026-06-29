# Wave 58: Claude 技能工厂/代码审查路由
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 58: Claude 技能工厂/代码审查 ===" -ForegroundColor Cyan

# 1. Claude Code Skill Factory
Write-Host "`n[1] Claude Code Skill Factory..." -ForegroundColor Yellow
npx skills add https://github.com/alirezarezvani/claude-code-skill-factory -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

# 2. Claude Skill Codex
Write-Host "[2] Claude Skill Codex..." -ForegroundColor Yellow
npx skills add https://github.com/sypsyp97/claude-skill-codex -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

# 3. Claude Skill Codex ImageGen
Write-Host "[3] Claude Skill Codex ImageGen..." -ForegroundColor Yellow
npx skills add https://github.com/JunSeo99/claude-skill-codex-imagegen -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

# 4. Claude Skill Code Review
Write-Host "[4] Claude Skill Code Review..." -ForegroundColor Yellow
npx skills add https://github.com/Jojo252511/claude-skill-codereview -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

# 5. Claude Skill Code Review Router
Write-Host "[5] Claude Skill Code Review Router..." -ForegroundColor Yellow
npx skills add https://github.com/wayne45/claude-skill-code-review-router -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

# 6. Claude Skill Code Walkthrough
Write-Host "[6] Claude Skill Code Walkthrough..." -ForegroundColor Yellow
npx skills add https://github.com/axelv/claude-skill-code-walkthrough -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

# 7. Claude Skill Code Cleanup
Write-Host "[7] Claude Skill Code Cleanup..." -ForegroundColor Yellow
npx skills add https://github.com/Hao0321/claude-skill-code-cleanup -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

# 8. Claude Skill Code Memory
Write-Host "[8] Claude Skill Code Memory..." -ForegroundColor Yellow
npx skills add https://github.com/jimdawdy-hub/claude-skill-code-memory -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

# 9. Agent Skill Creator
Write-Host "[9] Agent Skill Creator..." -ForegroundColor Yellow
npx skills add https://github.com/FrancyJGLisboa/agent-skill-creator -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

# 10. PPT Agent Skills
Write-Host "[10] PPT Agent Skills..." -ForegroundColor Yellow
npx skills add https://github.com/sunbigfly/ppt-agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave58.log

Write-Host "`n=== Wave 58 完成 ===" -ForegroundColor Green
