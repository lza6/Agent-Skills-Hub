# Update skill reference docs and sync to Claude Code
$ErrorActionPreference = "Stop"
$HubDir = $PSScriptRoot

Write-Host "Syncing Chinese metadata for new skills..." -ForegroundColor Cyan
python (Join-Path $HubDir "scripts\sync-skills-zh-data.py")

Write-Host "Generating Chinese reference..." -ForegroundColor Cyan
python (Join-Path $HubDir "scripts\generate-skills-reference-zh.py")
if ($LASTEXITCODE -ne 0) { throw "Chinese doc generation failed" }

Write-Host "Generating English reference..." -ForegroundColor Cyan
python (Join-Path $HubDir "scripts\generate-skills-reference.py")
if ($LASTEXITCODE -ne 0) { throw "English doc generation failed" }

$src = Join-Path $HubDir "docs\SKILLS-REFERENCE-CN.md"
$dst = Join-Path $env:USERPROFILE ".claude\SKILLS-REFERENCE-CN.md"
Copy-Item $src $dst -Force

Write-Host ""
Write-Host "Done." -ForegroundColor Green
Write-Host "  CN doc: $src"
Write-Host "  Claude copy: $dst"
