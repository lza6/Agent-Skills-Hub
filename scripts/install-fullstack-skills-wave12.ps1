# 鍏ㄦ爤鎶€鑳?Wave 12 鈥?鑱旂綉琛ュ厖锛圕lickHouse / Neo4j / FastAPI 琛ヨ锛?
#
# 浠撳簱鏉ユ簮锛坰kills.sh 妫€绱?+ --list 鏍￠獙锛?
#   clickhouse/agent-skills              https://github.com/clickhouse/agent-skills
#   neo4j-contrib/neo4j-skills           https://github.com/neo4j-contrib/neo4j-skills
#   microsoft/skills                     https://github.com/microsoft/skills (fastapi-router-py 鐩撮摼)
#   sickn33/antigravity-awesome-skills     https://github.com/sickn33/antigravity-awesome-skills (python-fastapi 閲嶈瘯)
#
$ErrorActionPreference = "Continue"
. (Join-Path $PSScriptRoot "github-mirror.ps1")
Enable-GitHubMirror
$HubDir = Split-Path $PSScriptRoot -Parent
$logDir = Join-Path $HubDir "logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null
$summaryFile = Join-Path $logDir "fullstack-wave12-$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"

function Install-SkillBatch {
    param([string]$Label, [string]$Repo, [string[]]$Skills, [switch]$All)
    Write-Host "`n>>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray
    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) { $skillCliArgs += @("--all") } else { foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) } }
    $skillCliArgs += @("-g", "-a", "*", "-y")
    $logFile = Join-Path $logDir ("wave12-{0}.log" -f ($Label -replace '[^a-zA-Z0-9_-]','_'))
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

"Fullstack Wave 12 started at $(Get-Date)" | Tee-Object -FilePath $summaryFile

# --- ClickHouse 瀹樻柟 ---
Install-SkillBatch -Label "clickhouse-official" -Repo "https://github.com/clickhouse/agent-skills" -All

# --- Neo4j 瀹樻柟锛堢簿閫?+ 甯哥敤椹卞姩锛?--
Install-SkillBatch -Label "neo4j-core" -Repo "https://github.com/neo4j-contrib/neo4j-skills" -Skills @(
    "neo4j-getting-started-skill","neo4j-cypher-skill","neo4j-graphrag-skill",
    "neo4j-driver-python-skill","neo4j-import-skill","neo4j-gds-skill",
    "neo4j-modeling-skill","neo4j-query-tuning-skill"
)

# --- FastAPI Router锛圡icrosoft 鐩撮摼锛岄伩鍏?sickn33 澶т粨搴撳厠闅嗭級---
Install-SkillBatch -Label "fastapi-router-ms" -Repo "https://github.com/microsoft/skills/tree/main/.github/plugins/azure-sdk-python/skills/fastapi-router-py" -All

# --- python-fastapi-development锛坰ickn33 閲嶈瘯锛屽彲鑳界綉缁滃け璐ワ級---
Install-SkillBatch -Label "python-fastapi-retry" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @("python-fastapi-development")

# --- cc-skill-clickhouse-io锛坰ickn33 琛ヨ锛屼笌瀹樻柟 ClickHouse 浜掕ˉ锛?--
Install-SkillBatch -Label "clickhouse-antigravity-retry" -Repo "https://github.com/sickn33/antigravity-awesome-skills" -Skills @("cc-skill-clickhouse-io")

"`nWave 12 done at $(Get-Date)" | Tee-Object -FilePath $summaryFile -Append
Write-Host "`nWave 12 complete: $summaryFile" -ForegroundColor Green
