# Wave 61: 全栈/集成技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 61: 全栈/集成技能 ===" -ForegroundColor Cyan

# 1. Cloud Fullstack Skills
Write-Host "`n[1] Cloud Fullstack Skills..." -ForegroundColor Yellow
npx skills add https://github.com/ferdousbhai/cloud-fullstack-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

# 2. Frappe React Fullstack Skill
Write-Host "[2] Frappe React Fullstack Skill..." -ForegroundColor Yellow
npx skills add https://github.com/sayanthns/frappe-react-fullstack-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

# 3. Spring Boot + Vue 3 全栈技能 (中文)
Write-Host "[3] Fullstack Skill (Spring Boot + Vue 3 中文)..." -ForegroundColor Yellow
npx skills add https://github.com/Shamnick/fullstack-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

# 4. 独立开发全栈技能
Write-Host "[4] Fullstack Skill (独立开发)..." -ForegroundColor Yellow
npx skills add https://github.com/Critical666/fullstack-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

# 5. GEUT Fullstack Skill
Write-Host "[5] GEUT Fullstack Skill..." -ForegroundColor Yellow
npx skills add https://github.com/geut/fullstack-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

# 6. Webhook Skills
Write-Host "[6] Webhook Skills..." -ForegroundColor Yellow
npx skills add https://github.com/hookdeck/webhook-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

# 7. SvelteKit Svelte5 Tailwind Skill
Write-Host "[7] SvelteKit Svelte5 Tailwind Skill..." -ForegroundColor Yellow
npx skills add https://github.com/claude-skills/sveltekit-svelte5-tailwind-skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

# 8. OpenClaw Config
Write-Host "[8] OpenClaw Config..." -ForegroundColor Yellow
npx skills add https://github.com/TechNickAI/openclaw-config -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

# 9. Laborany (桌面 AI 工作力平台)
Write-Host "[9] Laborany..." -ForegroundColor Yellow
npx skills add https://github.com/laborany/laborany -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

# 10. Paymob Integration Skill
Write-Host "[10] Paymob Claude Integration Skill..." -ForegroundColor Yellow
npx skills add https://github.com/PaymobAccept/Paymob-Claude-Integration-Skill -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave61.log

Write-Host "`n=== Wave 61 完成 ===" -ForegroundColor Green
