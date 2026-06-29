# Wave 22 - PHP/Laravel / .NET C# / DevSecOps SAST / Godot Unity / WordPress
#
# Sources (skills.sh, GitHub mirror):
#   Jeffallan/claude-skills            https://github.com/Jeffallan/claude-skills
#   asyrafhussin/agent-skills          https://github.com/asyrafhussin/agent-skills
#   mindrally/skills                     https://github.com/mindrally/skills
#   github/awesome-copilot             https://github.com/github/awesome-copilot
#   dotnet/skills                        https://github.com/dotnet/skills
#   markpitt/claude-skills               https://github.com/markpitt/claude-skills
#   trailofbits/skills                   https://github.com/trailofbits/skills
#   martinholovsky/claude-skills-generator https://github.com/martinholovsky/claude-skills-generator
#   jwynia/agent-skills                  https://github.com/jwynia/agent-skills
#   zate/cc-godot                        https://github.com/zate/cc-godot
#   wshobson/agents                      https://github.com/wshobson/agents
#   jezweb/claude-skills                 https://github.com/jezweb/claude-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave22-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave22"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 22 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- PHP / Laravel / WordPress ---
Run-SkillBatch -Label "php-jeffallan" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @("php-pro","wordpress-pro")
Run-SkillBatch -Label "php-best-practices" -Repo "https://github.com/asyrafhussin/agent-skills" -Skills @("php-best-practices")
Run-SkillBatch -Label "drupal-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("drupal-development")
Run-SkillBatch -Label "wordpress-jezweb" -Repo "https://github.com/jezweb/claude-skills" -Skills @("wordpress-setup")

# --- .NET / C# / Blazor / MAUI ---
Run-SkillBatch -Label "dotnet-copilot" -Repo "https://github.com/github/awesome-copilot" -Skills @("dotnet-best-practices","fluentui-blazor")
Run-SkillBatch -Label "dotnet-official" -Repo "https://github.com/dotnet/skills" -Skills @("dotnet-webapi","create-blazor-project","dotnet-maui-doctor","maui-shell-navigation")
Run-SkillBatch -Label "blazor-markpitt" -Repo "https://github.com/markpitt/claude-skills" -Skills @("blazor-expert")

# --- DevSecOps / SAST ---
Run-SkillBatch -Label "codeql-trailofbits" -Repo "https://github.com/trailofbits/skills" -Skills @("codeql")
Run-SkillBatch -Label "devsecops-martin" -Repo "https://github.com/martinholovsky/claude-skills-generator" -Skills @("devsecops-expert")

# --- Game dev (Godot) ---
Run-SkillBatch -Label "godot-zate" -Repo "https://github.com/zate/cc-godot" -Skills @("godot-ui")
# godot-best-practices (jwynia) 已从仓库移除；已有 godot-gdscript-patterns (wshobson)

"`nWave 22 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 22 complete: $summaryFile" -ForegroundColor Green
