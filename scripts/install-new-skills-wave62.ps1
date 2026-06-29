# Wave 62: Monorepo/微服务/项目设置技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 62: Monorepo/微服务/项目设置技能 ===" -ForegroundColor Cyan

# 1. Astro Monorepo Skill
Write-Host "`n[1] Astro Monorepo Skill..." -ForegroundColor Yellow
npx skills add https://github.com/matthewp/astro-monorepo-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

# 2. Monorepo Skills (mateo-khalil)
Write-Host "[2] Monorepo Skills (TypeScript)..." -ForegroundColor Yellow
npx skills add https://github.com/mateo-khalil/monorepo-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

# 3. Hermes Skill Toolkit
Write-Host "[3] Hermes Skill Toolkit..." -ForegroundColor Yellow
npx skills add https://github.com/leonluo2008-ops/hermes-skill-toolkit -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

# 4. Electron Web Monorepo Skill
Write-Host "[4] Electron Web Monorepo Skill..." -ForegroundColor Yellow
npx skills add https://github.com/2048Nemo/electron-web-monorepo-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

# 5. FastAPI Microservice Skills
Write-Host "[5] FastAPI Microservice Skills..." -ForegroundColor Yellow
npx skills add https://github.com/forvaidya/fastapi-microservice-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

# 6. Project Setup Skill
Write-Host "[6] Project Setup Skill..." -ForegroundColor Yellow
npx skills add https://github.com/KHammer404/project-setup-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

# 7. Apple Platform Project Setup
Write-Host "[7] Apple Platform Project Setup..." -ForegroundColor Yellow
npx skills add https://github.com/inekipelov/apple-platform-project-setup-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

# 8. Claude GitHub Skill
Write-Host "[8] Claude GitHub Skill..." -ForegroundColor Yellow
npx skills add https://github.com/pppeee861005/claude-github-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

# 9. Next.js Intelligence Toolkit
Write-Host "[9] Next.js Intelligence Toolkit..." -ForegroundColor Yellow
npx skills add https://github.com/yangsi7/nextjs-intelligence-toolkit -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

# 10. Code Learning Tutorial Skill
Write-Host "[10] Code Learning Tutorial Skill..." -ForegroundColor Yellow
npx skills add https://github.com/shuolsure/code-learning-tutorial-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave62.log

Write-Host "`n=== Wave 62 完成 ===" -ForegroundColor Green
