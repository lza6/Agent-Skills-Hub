# Wave 17 - FastAPI official / mobile testing / Deno / SolidJS / Expo
#
# Sources (skills.sh, avoid sickn33 large repo):
#   fastapi/fastapi                    https://github.com/fastapi/fastapi
#   Jeffallan/claude-skills            https://github.com/Jeffallan/claude-skills
#   jezweb/claude-skills               https://github.com/jezweb/claude-skills
#   LambdaTest/agent-skills            https://github.com/LambdaTest/agent-skills
#   denoland/skills                    https://github.com/denoland/skills
#   mindrally/skills                   https://github.com/mindrally/skills
#   suryavirkapur/skills               https://github.com/suryavirkapur/skills
#   expo/skills                        https://github.com/expo/skills
#   react-native-community/skills      https://github.com/react-native-community/skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave17-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave17"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 17 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- FastAPI official + experts (replace sickn33 python-fastapi-development) ---
Run-SkillBatch -Label "fastapi-official" -Repo "https://github.com/fastapi/fastapi" -Skills @("fastapi")
Run-SkillBatch -Label "fastapi-jeffallan" -Repo "https://github.com/Jeffallan/claude-skills" -Skills @("fastapi-expert")
# jezweb/claude-skills 已无 fastapi 技能，已跳过

# --- LambdaTest mobile / visual / browser ---
Run-SkillBatch -Label "lambdatest-mobile-visual" -Repo "https://github.com/LambdaTest/agent-skills" -Skills @(
    "appium-skill","detox-skill","flutter-testing-skill","smartui-skill"
)
Run-SkillBatch -Label "lambdatest-browser-runners" -Repo "https://github.com/LambdaTest/agent-skills" -Skills @(
    "puppeteer-skill","karma-skill","mocha-skill"
)

# --- Deno ---
Run-SkillBatch -Label "deno-official" -Repo "https://github.com/denoland/skills" -Skills @("deno-expert")
Run-SkillBatch -Label "deno-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("deno-typescript")

# --- SolidJS (solidjs-patterns delisted; use suryavirkapur) ---
Run-SkillBatch -Label "solidjs-suryavirkapur" -Repo "https://github.com/suryavirkapur/skills" -Skills @("solidjs")

# --- Expo / React Native ---
Run-SkillBatch -Label "expo-remaining" -Repo "https://github.com/expo/skills" -Skills @(
    "native-data-fetching","upgrading-expo","expo-dev-client","expo-deployment"
)
Run-SkillBatch -Label "react-native-community" -Repo "https://github.com/react-native-community/skills" -Skills @("upgrade-react-native")
Run-SkillBatch -Label "expo-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("expo-react-native-typescript")

# --- Puppeteer (mindrally) ---
Run-SkillBatch -Label "puppeteer-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("puppeteer-automation")

"`nWave 17 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 17 complete: $summaryFile" -ForegroundColor Green
