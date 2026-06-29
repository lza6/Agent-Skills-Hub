# 鍏ㄦ爤鎶€鑳?Wave 4 鈥?鑱旂綉琛ュ厖锛圕loudflare / Azure / Bun / Svelte / Remotion / DB / Go / Rails锛?
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave4-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave4-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
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

"Fullstack Wave 4 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Cloudflare 瀹樻柟 ---
Install-SkillBatch -Label "cloudflare-core" -Repo "https://github.com/cloudflare/skills" -Skills @(
    "wrangler","workers-best-practices","cloudflare","agents-sdk","durable-objects"
)

# --- Azure 鏍稿績 ---
Install-SkillBatch -Label "azure-core" -Repo "https://github.com/microsoft/azure-skills" -Skills @(
    "azure-deploy","azure-kubernetes","azure-ai","azure-compute","azure-storage",
    "azure-identity","appinsights-instrumentation"
)

# --- Bun / Svelte / Remotion ---
Install-SkillBatch -Label "bun-runtime" -Repo "https://github.com/affaan-m/everything-claude-code" -Skills @("bun-runtime")
Install-SkillBatch -Label "sveltekit" -Repo "https://github.com/spences10/svelte-skills-kit" -Skills @("sveltekit-structure")
Install-SkillBatch -Label "remotion" -Repo "https://github.com/remotion-dev/skills" -Skills @("remotion-best-practices")

# --- Python / Rails 鍚庣 ---
Install-SkillBatch -Label "django-extra" -Repo "https://github.com/affaan-m/everything-claude-code" -Skills @("django-security")
Install-SkillBatch -Label "fastapi-mindrally" -Repo "https://github.com/mindrally/skills" -Skills @("fastapi-python")
Install-SkillBatch -Label "rails" -Repo "https://github.com/jeffallan/claude-skills" -Skills @("rails-expert")

# --- 鏁版嵁搴?/ 鎼滅储 ---
Install-SkillBatch -Label "mongodb" -Repo "https://github.com/mongodb/agent-skills" -All
Install-SkillBatch -Label "elasticsearch" -Repo "https://github.com/elastic/agent-skills" -Skills @(
    "elasticsearch-esql","elasticsearch-authn","elasticsearch-onboarding"
)

# --- Go / Nuxt ---
Install-SkillBatch -Label "go-golang" -Repo "https://github.com/netresearch/go-development-skill" -Skills @("go-development")
Install-SkillBatch -Label "golang-samber" -Repo "https://github.com/samber/cc-skills-golang" -Skills @(
    "golang-code-style","golang-error-handling","golang-testing"
)
Install-SkillBatch -Label "nuxt" -Repo "https://github.com/antfu/skills" -Skills @("nuxt")
Install-SkillBatch -Label "nuxt-ui" -Repo "https://github.com/nuxt/ui" -Skills @("nuxt-ui")

"`nWave 4 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 4 complete: $summaryFile" -ForegroundColor Green
