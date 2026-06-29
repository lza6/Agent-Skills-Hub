# 一键：安装全栈技能 -> 同步中文元数据 -> 更新手册

$ErrorActionPreference = "Continue"

$HubDir = $PSScriptRoot
. (Join-Path $HubDir "scripts\github-mirror.ps1")
Enable-GitHubMirror



Write-Host "=== Step 1/41: Install fullstack skills (wave 1) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills.ps1")



Write-Host "`n=== Step 2/41: Install fullstack skills (wave 2) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave2.ps1")



Write-Host "`n=== Step 3/41: Install fullstack skills (wave 3) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave3.ps1")



Write-Host "`n=== Step 4/41: Install fullstack skills (wave 4) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave4.ps1")



Write-Host "`n=== Step 5/41: Install fullstack skills (wave 5) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave5.ps1")



Write-Host "`n=== Step 6/41: Install fullstack skills (wave 6) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave6.ps1")



Write-Host "`n=== Step 7/41: Install fullstack skills (wave 7 - AI/Security/Design) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave7.ps1")



Write-Host "`n=== Step 8/41: Install fullstack skills (wave 8 - Stripe/Sentry/DevOps/PM) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave8.ps1")



Write-Host "`n=== Step 9/41: Install fullstack skills (wave 9 - DevOps/GitOps/AI/Shopify) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave9.ps1")



Write-Host "`n=== Step 10/41: Install fullstack skills (wave 10 - Prisma/FastAPI/MCP/SRE) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave10.ps1")



Write-Host "`n=== Step 11/41: Install fullstack skills (wave 11 - GraphQL/FastAPI/ClickHouse) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave11.ps1")



Write-Host "`n=== Step 12/41: Install fullstack skills (wave 12 - ClickHouse/Neo4j/FastAPI) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave12.ps1")



Write-Host "`n=== Step 13/41: Install fullstack skills (wave 13 - LangChain/LangSmith/Snowflake/dbt) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave13.ps1")



Write-Host "`n=== Step 14/41: Install fullstack skills (wave 14 - Security/AWS/Pentest) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave14.ps1")



Write-Host "`n=== Step 15/41: Install fullstack skills (wave 15 - Netlify/Cloudflare/Remix) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave15.ps1")



Write-Host "`n=== Step 16/41: Install fullstack skills (wave 16 - Jest/Cypress/Selenium/Playwright) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave16.ps1")



Write-Host "`n=== Step 17/41: Install fullstack skills (wave 17 - FastAPI/Mobile/Deno/Expo) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave17.ps1")



Write-Host "`n=== Step 18/41: Install fullstack skills (wave 18 - n8n/Temporal/Neon/VectorDB) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave18.ps1")



Write-Host "`n=== Step 19/41: Install fullstack skills (wave 19 - AI/shadcn/Vue/Svelte) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave19.ps1")



Write-Host "`n=== Step 20/41: Install fullstack skills (wave 20 - Spring/Three.js/GCP/Azure) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave20.ps1")



Write-Host "`n=== Step 21/41: Install fullstack skills (wave 21 - Rails/Go/K8s/Shopify) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave21.ps1")



Write-Host "`n=== Step 22/41: Install fullstack skills (wave 22 - PHP/.NET/DevSecOps/Godot) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave22.ps1")



Write-Host "`n=== Step 23/41: Install fullstack skills (wave 23 - Symfony/Observability/Mobile) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave23.ps1")



Write-Host "`n=== Step 24/41: Install fullstack skills (wave 24 - Datadog/API Platform/KMP) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave24.ps1")



Write-Host "`n=== Step 25/41: Install fullstack skills (wave 25 - Symfony/Ansible/Sentry) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave25.ps1")



Write-Host "`n=== Step 26/41: Install fullstack skills (wave 26 - FastAPI/RNWeb/K8s/IaC) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave26.ps1")



Write-Host "`n=== Step 27/41: Install fullstack skills (wave 27 - Django/GraphQL/Helm/iOS) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave27.ps1")



Write-Host "`n=== Step 28/41: Install fullstack skills (wave 28 - NestJS/BDD/TF/GitLab/Ruby) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave28.ps1")



Write-Host "`n=== Step 29/41: Install fullstack skills (wave 29 - Storybook/Vitest/Phoenix/Bun) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave29.ps1")



Write-Host "`n=== Step 30/41: Install fullstack skills (wave 30 - Vue/Next/Tailwind/Zustand) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave30.ps1")



Write-Host "`n=== Step 31/41: Install fullstack skills (wave 31 - Python/C++/Java/SRE) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave31.ps1")



Write-Host "`n=== Step 32/41: Install fullstack skills (wave 32 - TypeScript/Figma/Sentry/Design) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave32.ps1")



Write-Host "`n=== Step 33/41: Install fullstack skills (wave 33 - GHA/Stripe/SOP/React+Expo) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave33.ps1")



Write-Host "`n=== Step 34/41: Install fullstack skills (wave 34 - han扫尾/Mobile/SRE/jezweb) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave34.ps1")



Write-Host "`n=== Step 35/41: Install fullstack skills (wave 35 - han收尾/jezweb/Jeffallan) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave35.ps1")



Write-Host "`n=== Step 36/41: Install fullstack skills (wave 36 - Vercel/Azure/makfly/vaquarkhan) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave36.ps1")



Write-Host "`n=== Step 37/41: Install fullstack skills (wave 37 - Sentry/mindrally/aj-geddes/antigravity) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave37.ps1")



Write-Host "`n=== Step 38/41: Install fullstack skills (wave 38 - mindrally/aj-geddes/bobmatnyc/techleads) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave38.ps1")



Write-Host "`n=== Step 39/41: Install fullstack skills (wave 38 resume - aj-geddes/bobmatnyc/techleads/antigravity) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave38-resume.ps1")



Write-Host "`n=== Step 40/43: Install fullstack skills (wave 39 - minimax/shubham/andre/alireza/mukul/antigravity) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave39.ps1")



Write-Host "`n=== Step 42/43: Install fullstack skills (wave 39 resume - TLS failures/antigravity/techleads) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave39-resume.ps1")



Write-Host "`n=== Step 43/44: Install fullstack skills (wave 40 - shubham/alireza/mukul/antigravity) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave40.ps1")



Write-Host "`n=== Step 44/45: Install fullstack skills (wave 41 - alirezarezvani/mukul/antigravity) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave41.ps1")



Write-Host "`n=== Step 45/45: Install fullstack skills (wave 42 - alirezarezvani/mukul/antigravity) ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "scripts\install-fullstack-skills-wave42.ps1")



Write-Host "`n=== Sync metadata + update docs ===" -ForegroundColor Cyan

powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $HubDir "update-docs.ps1")



Write-Host "`nAll done. Open: $HubDir\docs\SKILLS-REFERENCE-CN.md" -ForegroundColor Green

