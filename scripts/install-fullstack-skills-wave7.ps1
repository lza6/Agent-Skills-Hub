# 鍏ㄦ爤鎶€鑳?Wave 7 鈥?鑱旂綉琛ュ厖锛圓I/LLM / Security / Design / Figma / Supabase / MCP / Prompt锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   anthropics/skills                https://github.com/anthropics/skills
#   vercel/ai                        https://github.com/vercel/ai
#   openai/skills                    https://github.com/openai/skills
#   figma/mcp-server-guide           https://github.com/figma/mcp-server-guide
#   arvindrk/extract-design-system   https://github.com/arvindrk/extract-design-system
#   firebase/agent-skills            https://github.com/firebase/agent-skills
#   supabase/agent-skills            https://github.com/supabase/agent-skills
#   hoodini/ai-agents-skills         https://github.com/hoodini/ai-agents-skills
#   agamm/claude-code-owasp          https://github.com/agamm/claude-code-owasp  (owasp-security)
#   google-labs-code/stitch-skills   https://github.com/google-labs-code/stitch-skills
#   github/awesome-copilot           https://github.com/github/awesome-copilot
#   different-ai/openwork            https://github.com/different-ai/openwork
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave7-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave7-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
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

"Fullstack Wave 7 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Anthropic 瀹樻柟锛堣烦杩囧凡瑁呯殑 frontend-design / skill-creator / claude-api锛?--
Install-SkillBatch -Label "anthropic-ai" -Repo "https://github.com/anthropics/skills" -Skills @(
    "mcp-builder","webapp-testing","web-artifacts-builder","canvas-design",
    "doc-coauthoring","brand-guidelines","algorithmic-art","theme-factory"
)

# --- Vercel AI SDK ---
Install-SkillBatch -Label "vercel-ai-sdk" -Repo "https://github.com/vercel/ai" -Skills @("migrate-ai-sdk-v6-to-v7")

# --- OpenAI 瀹樻柟锛堝畨鍏?/ Figma / 娴嬭瘯锛?--
Install-SkillBatch -Label "openai-security-design" -Repo "https://github.com/openai/skills" -Skills @(
    "security-best-practices","security-threat-model","figma-implement-design",
    "playwright","openai-docs"
)

# --- Figma MCP ---
Install-SkillBatch -Label "figma-mcp" -Repo "https://github.com/figma/mcp-server-guide" -Skills @(
    "figma-generate-design","figma-use","figma-code-connect","figma-swiftui"
)

# --- Design System 鎻愬彇 ---
Install-SkillBatch -Label "extract-design-system" -Repo "https://github.com/arvindrk/extract-design-system" -Skills @("extract-design-system")

# --- Firebase ---
Install-SkillBatch -Label "firebase" -Repo "https://github.com/firebase/agent-skills" -Skills @(
    "firebase-security-rules-auditor","firebase-firestore","firebase-auth-basics","firebase-basics"
)

# --- Supabase 娣卞寲 ---
Install-SkillBatch -Label "supabase" -Repo "https://github.com/supabase/agent-skills" -All

# --- OWASP 瀹夊叏 ---
Install-SkillBatch -Label "owasp" -Repo "https://github.com/agamm/claude-code-owasp" -Skills @("owasp-security")

# --- Prompt / Stitch 璁捐 ---
Install-SkillBatch -Label "stitch-prompt" -Repo "https://github.com/google-labs-code/stitch-skills" -Skills @(
    "enhance-prompt","taste-design","design-md"
)

# --- MCP CLI ---
Install-SkillBatch -Label "mcp-cli" -Repo "https://github.com/github/awesome-copilot" -Skills @("mcp-cli")

# --- SolidJS 琛ヨ锛圵ave 6 缃戠粶澶辫触锛?--
Install-SkillBatch -Label "solidjs-retry" -Repo "https://github.com/different-ai/openwork" -Skills @("solidjs-patterns")

"`nWave 7 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 7 complete: $summaryFile" -ForegroundColor Green
