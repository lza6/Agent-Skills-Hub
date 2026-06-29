# 鍏ㄦ爤鎶€鑳?Wave 14 鈥?鑱旂綉琛ュ厖锛堝畨鍏ㄦ祴璇?/ AWS / 娴忚鍣ㄦ祴璇?/ Semgrep锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   addyosmani/agent-skills                  https://github.com/addyosmani/agent-skills
#   trailofbits/skills                       https://github.com/trailofbits/skills
#   BagelHole/DevOps-Security-Agent-Skills   https://github.com/BagelHole/DevOps-Security-Agent-Skills
#   itsmostafa/aws-agent-skills              https://github.com/itsmostafa/aws-agent-skills
#   sickn33/antigravity-awesome-skills       https://github.com/sickn33/antigravity-awesome-skills (playwright-java 閲嶈瘯)
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave14-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave14-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
    try {
        $output = & npx @skillCliArgs 2>&1 | Out-String
        $output | Out-File $logFile -Encoding utf8
        if ($output -match "Installed \d+ skill" -or $output -match "Installation complete" -or $output -match "Done!") {
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

"Fullstack Wave 14 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- 瀹夊叏鍔犲浐 / 娴忚鍣?DevTools 娴嬭瘯 ---
Install-SkillBatch -Label "addyosmani-security" -Repo "https://github.com/addyosmani/agent-skills" -Skills @(
    "security-and-hardening","browser-testing-with-devtools"
)

# --- Trail of Bits 瀹夊叏 / 娴嬭瘯 ---
Install-SkillBatch -Label "trailofbits-security" -Repo "https://github.com/trailofbits/skills" -Skills @(
    "semgrep","insecure-defaults","secure-workflow-guide",
    "mutation-testing","property-based-testing","semgrep-rule-creator","supply-chain-risk-auditor"
)

# --- 娓楅€忔祴璇?/ DAST / WAF ---
Install-SkillBatch -Label "pentest-dast" -Repo "https://github.com/BagelHole/DevOps-Security-Agent-Skills" -Skills @(
    "penetration-testing","dast-scanning","waf-setup","dependency-scanning"
)

# --- AWS 瀹樻柟鎶€鑳藉寘锛?8 鏈嶅姟锛?--
Install-SkillBatch -Label "aws-agent-skills" -Repo "https://github.com/itsmostafa/aws-agent-skills" -All

# --- Playwright Java锛坰ickn33 閲嶈瘯锛屽彲鑳界綉缁滃け璐ワ級---
Install-SkillBatch -Label "playwright-java-retry" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @("playwright-java")

"`nWave 14 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 14 complete: $summaryFile" -ForegroundColor Green
