# Wave 47: 精选合集/工作流/平台管理
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 47: 精选合集/工作流/平台管理 ===" -ForegroundColor Cyan

# 1. awesome-claude-code-skills (精选合集)
Write-Host "`n[1] Awesome Claude Code Skills (精选合集)..." -ForegroundColor Yellow
npx skills add https://github.com/helloianneo/awesome-claude-code-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

# 2. awesome-agent-skills (教程指南)
Write-Host "[2] Awesome Agent Skills (教程指南)..." -ForegroundColor Yellow
npx skills add https://github.com/heilcheng/awesome-agent-skills -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

# 3. awesome-claude-code-workflows (工作流)
Write-Host "[3] Awesome Claude Code Workflows..." -ForegroundColor Yellow
npx skills add https://github.com/ithiria894/awesome-claude-code-workflows -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

# 4. awesome-claude (注册表)
Write-Host "[4] Awesome Claude (注册表)..." -ForegroundColor Yellow
npx skills add https://github.com/JSONbored/awesome-claude -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

# 5. everything-ai-coding (聚合资源)
Write-Host "[5] Everything AI Coding (聚合资源)..." -ForegroundColor Yellow
npx skills add https://github.com/zgsm-ai/everything-ai-coding -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

# 6. Claude Dev Suite (代理+MCP+仪表盘)
Write-Host "[6] Claude Dev Suite..." -ForegroundColor Yellow
npx skills add https://github.com/claude-dev-suite/claude-dev-suite -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

# 7. Claude Code Studio (Web工作空间)
Write-Host "[7] Claude Code Studio..." -ForegroundColor Yellow
npx skills add https://github.com/Lexus2016/claude-code-studio -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

# 8. Cross-Code Organizer (跨平台管理)
Write-Host "[8] Cross-Code Organizer..." -ForegroundColor Yellow
npx skills add https://github.com/mcpware/cross-code-organizer -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

# 9. VSync (跨平台同步)
Write-Host "[9] VSync..." -ForegroundColor Yellow
npx skills add https://github.com/nicepkg/vsync -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

# 10. ECC2Cursor (同步到Cursor)
Write-Host "[10] ECC2Cursor..." -ForegroundColor Yellow
npx skills add https://github.com/cminn10/ecc2cursor -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave47.log

Write-Host "`n=== Wave 47 完成 ===" -ForegroundColor Green
