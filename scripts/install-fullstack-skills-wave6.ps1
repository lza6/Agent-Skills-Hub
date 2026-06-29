# 鍏ㄦ爤鎶€鑳?Wave 6 鈥?鑱旂綉琛ュ厖锛團lutter / SolidJS / Pulumi / Terraform / Java / Kotlin / Swift / Expo / 绉诲姩绔?/ Monorepo锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   flutter/skills                   https://github.com/flutter/skills
#   different-ai/openwork            https://github.com/different-ai/openwork
#   pulumi/agent-skills              https://github.com/pulumi/agent-skills
#   hashicorp/agent-skills           https://github.com/hashicorp/agent-skills
#   wshobson/agents                  https://github.com/wshobson/agents
#   github/awesome-copilot           https://github.com/github/awesome-copilot
#   twostraws/swiftui-agent-skill    https://github.com/twostraws/swiftui-agent-skill
#   avdlee/swiftui-agent-skill       https://github.com/avdlee/swiftui-agent-skill
#   expo/skills                      https://github.com/expo/skills
#   vercel-labs/agent-skills         https://github.com/vercel-labs/agent-skills
#   sveltejs/ai-tools                https://github.com/sveltejs/ai-tools
#   vercel/turborepo                 https://github.com/vercel/turborepo
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave6-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave6-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
    try {
        $output = & npx @skillCliArgs 2>&1 | Out-String
        $output | Out-File $logFile -Encoding utf8
        if ($output -match "Installed \d+ skill" -or $output -match "Installation complete") {
            "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
            return $true
        }
        "FAIL $Label (exit $LASTEXITCODE)" | Tee-Object -FilePath $summaryFile -Append
        return $false
    } catch {
        "ERROR $Label : $_" | Tee-Object -FilePath $summaryFile -Append
        return $false
    }
}

"Fullstack Wave 6 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Flutter 瀹樻柟 ---
Install-SkillBatch -Label "flutter-official" -Repo "https://github.com/flutter/skills" -All

# --- SolidJS ---
Install-SkillBatch -Label "solidjs" -Repo "https://github.com/different-ai/openwork" -Skills @("solidjs-patterns")

# --- Pulumi IaC ---
Install-SkillBatch -Label "pulumi" -Repo "https://github.com/pulumi/agent-skills" -Skills @(
    "pulumi-best-practices","pulumi-overview","pulumi-component","pulumi-terraform-to-pulumi",
    "pulumi-arm-to-pulumi","pulumi-cdk-to-pulumi","pulumi-automation-api"
)

# --- Terraform / HashiCorp ---
Install-SkillBatch -Label "terraform-hashicorp" -Repo "https://github.com/hashicorp/agent-skills" -Skills @(
    "terraform-test","terraform-style-guide","terraform-stacks","refactor-module"
)
Install-SkillBatch -Label "terraform-wshobson" -Repo "https://github.com/wshobson/agents" -Skills @("terraform-module-library")
Install-SkillBatch -Label "terraform-azure" -Repo "https://github.com/github/awesome-copilot" -Skills @("terraform-azurerm-set-diff-analyzer")

# --- Java / Kotlin Spring Boot ---
Install-SkillBatch -Label "java-kotlin-spring" -Repo "https://github.com/github/awesome-copilot" -Skills @(
    "java-springboot","kotlin-springboot"
)

# --- Swift / iOS ---
Install-SkillBatch -Label "swiftui-twostraws" -Repo "https://github.com/twostraws/swiftui-agent-skill" -Skills @("swiftui-pro")
Install-SkillBatch -Label "swiftui-avdlee" -Repo "https://github.com/avdlee/swiftui-agent-skill" -Skills @("swiftui-expert-skill")
Install-SkillBatch -Label "swift-concurrency" -Repo "https://github.com/twostraws/swift-concurrency-agent-skill" -Skills @("swift-concurrency-pro")

# --- Expo / React Native ---
Install-SkillBatch -Label "expo-extra" -Repo "https://github.com/expo/skills" -Skills @(
    "expo-ui","expo-deployment","expo-cicd-workflows","native-data-fetching","expo-module","expo-tailwind-setup"
)
# vercel-react-native-skills 宸插湪 Wave 1 瀹夎锛泇ercel-labs/agent-skills 浠撳簱褰撳墠浠呭惈 web-design-guidelines

# --- Svelte / Monorepo ---
Install-SkillBatch -Label "svelte-ai" -Repo "https://github.com/sveltejs/ai-tools" -Skills @("svelte-code-writer")
Install-SkillBatch -Label "turborepo" -Repo "https://github.com/vercel/turborepo" -Skills @("turborepo")

"`nWave 6 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 6 complete: $summaryFile" -ForegroundColor Green
