# Wave 59: MCP Server/工具/代码生成技能
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 59: MCP Server/工具/代码生成技能 ===" -ForegroundColor Cyan

# 1. AWS Agent Toolkit
Write-Host "`n[1] AWS Agent Toolkit..." -ForegroundColor Yellow
npx skills add https://github.com/aws/agent-toolkit-for-aws -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

# 2. 语雀生态系统
Write-Host "[2] Yuque Ecosystem..." -ForegroundColor Yellow
npx skills add https://github.com/yuque/yuque-ecosystem -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

# 3. Nix Agent
Write-Host "[3] Nix Agent..." -ForegroundColor Yellow
npx skills add https://github.com/JEFF7712/nix-agent -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

# 4. 阿里云工具包
Write-Host "[4] Alibaba Cloud Agent Toolkit..." -ForegroundColor Yellow
npx skills add https://github.com/aliyun/alibabacloud-agent-toolkit -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

# 5. Agentify (OpenAPI 转技能)
Write-Host "[5] Agentify..." -ForegroundColor Yellow
npx skills add https://github.com/MonadWorks/agentify -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

# 6. MCP Gateway
Write-Host "[6] MCP Gateway..." -ForegroundColor Yellow
npx skills add https://github.com/aiguicai/MCP-Gateway -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

# 7. Pure Data MCP Server
Write-Host "[7] PD MCP Server..." -ForegroundColor Yellow
npx skills add https://github.com/jfboisvenue/pd-mcp-server -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

# 8. Agent Tools
Write-Host "[8] Agent Tools..." -ForegroundColor Yellow
npx skills add https://github.com/omry/agent_tools -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

# 9. LocalWP Agent Tools
Write-Host "[9] LocalWP Agent Tools..." -ForegroundColor Yellow
npx skills add https://github.com/10up/localwp-agent-tools -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

# 10. Stata AI Fusion
Write-Host "[10] Stata AI Fusion..." -ForegroundColor Yellow
npx skills add https://github.com/haoyu-haoyu/stata-ai-fusion -g -a "*" -y 2>&1 | Out-File -Append -Encoding utf8 logs/wave59.log

Write-Host "`n=== Wave 59 完成 ===" -ForegroundColor Green
