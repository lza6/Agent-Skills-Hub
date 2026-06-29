# Wave 30 - Vue/Next.js / Tailwind / Zustand / Angular / React / SvelteFlow / GlueStack / Ink / Atomic Design
#
# Sources (skills.sh, GitHub mirror):
#   thebushidocollective/han            https://github.com/thebushidocollective/han
#   jezweb/claude-skills                 https://github.com/jezweb/claude-skills
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror

$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave30-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Run-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    $r = Invoke-SkillInstall -Label $Label -Repo $Repo -Skills $Skills -All:$All -LogDir $logDir -LogPrefix "wave30"
    if ($r.Ok) {
        "OK  $Label" | Tee-Object -FilePath $summaryFile -Append
        return $true
    }
    "FAIL $Label" | Tee-Object -FilePath $summaryFile -Append
    return $false
}

"Fullstack Wave 30 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- Vue 3 深化 ---
Run-SkillBatch -Label "vue-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "vue-component-patterns","vue-composition-api","vue-reactivity-system"
)

# --- Next.js App Router ---
Run-SkillBatch -Label "nextjs-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "nextjs-app-router","nextjs-data-fetching","nextjs-server-components"
)

# --- Tailwind CSS 深化 ---
Run-SkillBatch -Label "tailwind-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "tailwind-components","tailwind-configuration","tailwind-performance",
    "tailwind-responsive-design","tailwind-utility-classes"
)

# --- Zustand 状态管理 ---
Run-SkillBatch -Label "zustand-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "zustand-advanced-patterns","zustand-middleware","zustand-store-patterns","zustand-typescript"
)

# --- Angular 补全 ---
Run-SkillBatch -Label "angular-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "angular-dependency-injection","angular-rxjs-patterns"
)

# --- React 模式 ---
Run-SkillBatch -Label "react-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "react-context-patterns","react-hooks-patterns","react-performance"
)

# --- React Flow / Svelte Flow ---
Run-SkillBatch -Label "flow-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "reactflow-fundamentals","reactflow-custom-nodes","svelteflow-fundamentals","svelteflow-custom-nodes"
)

# --- GlueStack (React Native UI) ---
Run-SkillBatch -Label "gluestack-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "gluestack-components","gluestack-theming","gluestack-accessibility","gluestack-mcp-tools"
)

# --- Ink (React CLI) ---
Run-SkillBatch -Label "ink-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "ink-component-patterns","ink-hooks-state","ink-layout-styling"
)

# --- Atomic Design ---
Run-SkillBatch -Label "atomic-han" -Repo "https://github.com/thebushidocollective/han" -Skills @(
    "atomic-design-fundamentals","atomic-design-atoms","atomic-design-molecules",
    "atomic-design-organisms","atomic-design-templates"
)

# --- TanStack Start / shadcn-ui (jezweb) ---
Run-SkillBatch -Label "jezweb-frontend" -Repo "https://github.com/jezweb/claude-skills" -Skills @(
    "tanstack-start","shadcn-ui"
)

"`nWave 30 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 30 complete: $summaryFile" -ForegroundColor Green
