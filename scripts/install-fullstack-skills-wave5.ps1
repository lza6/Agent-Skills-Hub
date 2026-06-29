# 鍏ㄦ爤鎶€鑳?Wave 5 鈥?鑱旂綉琛ュ厖锛圧ust / Laravel / Vue / Angular / GCP / 娑堟伅闃熷垪 / Redis / 浜嬩欢椹卞姩 / Qwik / C#锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   leonardomso/rust-skills          https://github.com/leonardomso/rust-skills
#   wshobson/agents                  https://github.com/wshobson/agents
#   jeffallan/claude-skills          https://github.com/jeffallan/claude-skills
#   antfu/skills                     https://github.com/antfu/skills
#   analogjs/angular-skills          https://github.com/analogjs/angular-skills
#   mindrally/skills                 https://github.com/mindrally/skills
#   sickn33/antigravity-awesome-skills https://github.com/sickn33/antigravity-awesome-skills
#   alirezarezvani/claude-skills     https://github.com/alirezarezvani/claude-skills
#   redis/agent-skills               https://github.com/redis/agent-skills
#   oimiragieo/agent-studio          https://github.com/oimiragieo/agent-studio
#   github/awesome-copilot           https://github.com/github/awesome-copilot
#   apollographql/skills             https://github.com/apollographql/skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave5-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave5-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
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

"Fullstack Wave 5 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Rust ---
Install-SkillBatch -Label "rust-leonardomso" -Repo "https://github.com/leonardomso/rust-skills" -Skills @("rust-skills")
Install-SkillBatch -Label "rust-wshobson" -Repo "https://github.com/wshobson/agents" -Skills @("rust-async-patterns")

# --- PHP / Laravel ---
Install-SkillBatch -Label "laravel" -Repo "https://github.com/jeffallan/claude-skills" -Skills @("laravel-specialist")

# --- Vue 鐢熸€?(antfu) ---
Install-SkillBatch -Label "vue-antfu" -Repo "https://github.com/antfu/skills" -Skills @(
    "vue","vue-best-practices","pinia","vitest","vue-router-best-practices","unocss"
)

# --- Angular 瀹樻柟鎶€鑳藉寘 ---
Install-SkillBatch -Label "angular" -Repo "https://github.com/analogjs/angular-skills" -Skills @(
    "angular-component","angular-di","angular-directives","angular-signals","angular-forms"
)

# --- GCP 澶氫簯 ---
Install-SkillBatch -Label "gcp-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("gcp-development")
Install-SkillBatch -Label "gcp-cloud-run" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @("gcp-cloud-run")
Install-SkillBatch -Label "gcp-architect" -Repo "https://github.com/alirezarezvani/claude-skills" -Skills @("gcp-cloud-architect")

# --- 娑堟伅闃熷垪 ---
Install-SkillBatch -Label "message-queue" -Repo "https://github.com/mindrally/skills" -Skills @(
    "kafka-development","rabbitmq-development"
)

# --- Redis 瀹樻柟锛堟柊鐗?agent-skills锛岄潪鏃?redis-development锛?--
Install-SkillBatch -Label "redis-official" -Repo "https://github.com/redis/agent-skills" -All

# --- 浜嬩欢椹卞姩 / 寰湇鍔?---
Install-SkillBatch -Label "event-driven" -Repo "https://github.com/wshobson/agents" -Skills @(
    "cqrs-implementation","microservices-patterns","event-store-design","saga-orchestration","workflow-orchestration-patterns"
)

# --- Qwik ---
Install-SkillBatch -Label "qwik" -Repo "https://github.com/oimiragieo/agent-studio" -Skills @("qwik-expert")

# --- C# / .NET ---
Install-SkillBatch -Label "csharp" -Repo "https://github.com/github/awesome-copilot" -Skills @(
    "csharp-async","csharp-xunit"
)

# GraphQL Rust锛堢綉缁滀笉绋虫椂鍙崟鐙噸璇曪級
# Install-SkillBatch -Label "apollo-rust" -Repo "https://github.com/apollographql/skills" -Skills @("rust-best-practices")

"`nWave 5 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 5 complete: $summaryFile" -ForegroundColor Green
