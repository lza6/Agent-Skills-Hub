# Wave 66: VSCode、TypeScript、MCP Server 技能安装
$ErrorActionPreference = "Continue"

Write-Host "=== Wave 66: VSCode + TypeScript + MCP Server Skills ===" -ForegroundColor Cyan

# VSCode 相关
npx skills add https://github.com/matee911/claude-skill-vscode-theme -g -a "*" -y

# TypeScript Agent
npx skills add https://github.com/vyredo/Agent-skill-typescript -g -a "*" -y
npx skills add https://github.com/PaulGiletich/skills-ref-ts -g -a "*" -y
npx skills add https://github.com/codecell-germany/sevdesk-agent-skill -g -a "*" -y

# MCP Server
npx skills add https://github.com/Olderdriver/mcp-skill-server -g -a "*" -y
npx skills add https://github.com/foxj77/mcp-skills-server -g -a "*" -y
npx skills add https://github.com/jcc-ne/mcp-skill-server -g -a "*" -y
npx skills add https://github.com/footnote42/claude-mcp-skills-server -g -a "*" -y
npx skills add https://github.com/lionw/go-mcp-skill-server-sse -g -a "*" -y
npx skills add https://github.com/openagent-uno/openagent-mcp-template -g -a "*" -y
npx skills add https://github.com/penumbraforge/mcp-librarian -g -a "*" -y
npx skills add https://github.com/OPENSPHERE-Inc/agent-sequencer -g -a "*" -y

Write-Host "Wave 66 完成" -ForegroundColor Green
