# Wave 43: 新发现高价值技能 2025-06
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 43: 新发现高价值技能 ===" -ForegroundColor Cyan

# 1. 科学研究技能 (K-Dense-AI) - 140+ 科学技能
Write-Host "`n[1] 科学研究技能 (scientific-agent-skills)..." -ForegroundColor Yellow
npx skills add https://github.com/K-Dense-AI/scientific-agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

# 2. PM 技能市场 (phuryn) - 100+ PM 技能
Write-Host "[2] PM 技能市场 (pm-skills)..." -ForegroundColor Yellow
npx skills add https://github.com/phuryn/pm-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

# 3. 上下文工程技能 (muratcankoylan)
Write-Host "[3] 上下文工程技能 (Agent-Skills-for-Context-Engineering)..." -ForegroundColor Yellow
npx skills add https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

# 4. Obsidian 技能 (kepano)
Write-Host "[4] Obsidian 技能 (obsidian-skills)..." -ForegroundColor Yellow
npx skills add https://github.com/kepano/obsidian-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

# 5. Vue 3 官方技能 (vuejs-ai)
Write-Host "[5] Vue 3 官方技能 (vuejs-ai/skills)..." -ForegroundColor Yellow
npx skills add https://github.com/vuejs-ai/skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

# 6. NVIDIA 技能
Write-Host "[6] NVIDIA 技能 (NVIDIA/skills)..." -ForegroundColor Yellow
npx skills add https://github.com/NVIDIA/skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

# 7. Firebase 官方技能
Write-Host "[7] Firebase 官方技能 (firebase/agent-skills)..." -ForegroundColor Yellow
npx skills add https://github.com/firebase/agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

# 8. Google 官方技能
Write-Host "[8] Google 官方技能 (google/skills)..." -ForegroundColor Yellow
npx skills add https://github.com/google/skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

# 9. Apify Agent Skills
Write-Host "[9] Apify Agent Skills (apify/agent-skills)..." -ForegroundColor Yellow
npx skills add https://github.com/apify/agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

# 10. awesome-agent-skills (VoltAgent) - 1000+ 技能
Write-Host "[10] awesome-agent-skills (VoltAgent)..." -ForegroundColor Yellow
npx skills add https://github.com/VoltAgent/awesome-agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave43.log

Write-Host "`n=== Wave 43 完成 ===" -ForegroundColor Green
