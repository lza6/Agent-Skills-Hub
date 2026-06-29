# GitHub mirror helper for China network (npx skills uses git clone)
#
# Usage:
#   . (Join-Path $PSScriptRoot "github-mirror.ps1")
#   Enable-GitHubMirror
#
# Disable mirror (direct GitHub):
#   $env:SKILLS_MIRROR_DISABLED = "1"
#
# Single mirror:
#   $env:SKILLS_MIRROR_PREFIX = "https://ghfast.top/https://github.com/"
#
# Custom mirror list (semicolon-separated):
#   $env:SKILLS_MIRROR_LIST = "https://ghfast.top/https://github.com/;https://mirror.ghproxy.com/https://github.com/"

function Get-GitHubMirrorCandidates {
    if ($env:SKILLS_MIRROR_DISABLED -eq "1") {
        return @($null)
    }

    $defaults = @(
        "https://ghfast.top/https://github.com/"
        "https://mirror.ghproxy.com/https://github.com/"
        "https://gh-proxy.com/https://github.com/"
    )

    if ($env:SKILLS_MIRROR_LIST) {
        $list = $env:SKILLS_MIRROR_LIST -split ';' | ForEach-Object { $_.Trim() } | Where-Object { $_ }
        return $list + @($null)
    }

    if ($env:SKILLS_MIRROR_PREFIX) {
        return @($env:SKILLS_MIRROR_PREFIX) + ($defaults | Where-Object { $_ -ne $env:SKILLS_MIRROR_PREFIX }) + @($null)
    }

    return $defaults + @($null)
}

function Set-GitHubMirrorPrefix {
    param([AllowNull()][string]$MirrorPrefix)

    if (-not $MirrorPrefix) {
        Remove-Item Env:SKILLS_MIRROR_ENABLED -ErrorAction SilentlyContinue
        Remove-Item Env:GIT_CONFIG_COUNT -ErrorAction SilentlyContinue
        Remove-Item Env:GIT_CONFIG_KEY_0 -ErrorAction SilentlyContinue
        Remove-Item Env:GIT_CONFIG_VALUE_0 -ErrorAction SilentlyContinue
        return
    }

    if (-not $MirrorPrefix.EndsWith("/")) { $MirrorPrefix += "/" }

    $env:SKILLS_MIRROR_ENABLED = "1"
    $env:SKILLS_MIRROR_PREFIX = $MirrorPrefix
    $env:GIT_CONFIG_COUNT = "1"
    $env:GIT_CONFIG_KEY_0 = "url.$MirrorPrefix.insteadOf"
    $env:GIT_CONFIG_VALUE_0 = "https://github.com/"
}

function Enable-GitHubMirror {
    param(
        [string]$MirrorPrefix = $(if ($env:SKILLS_MIRROR_PREFIX) { $env:SKILLS_MIRROR_PREFIX } else { "https://ghfast.top/https://github.com/" }),
        [switch]$Quiet
    )

    if ($env:SKILLS_MIRROR_DISABLED -eq "1") {
        Set-GitHubMirrorPrefix -MirrorPrefix $null
        if (-not $Quiet) { Write-Host "GitHub mirror disabled (SKILLS_MIRROR_DISABLED=1)" -ForegroundColor DarkGray }
        return
    }

    Set-GitHubMirrorPrefix -MirrorPrefix $MirrorPrefix

    if (-not $Quiet) {
        Write-Host "GitHub mirror enabled: $MirrorPrefix" -ForegroundColor DarkYellow
        Write-Host "  Invoke-SkillInstall will try fallback mirrors on clone failure" -ForegroundColor DarkGray
        Write-Host "  Set SKILLS_MIRROR_DISABLED=1 for direct GitHub" -ForegroundColor DarkGray
    }
}

function Disable-GitHubMirror {
    Set-GitHubMirrorPrefix -MirrorPrefix $null
    Remove-Item Env:SKILLS_MIRROR_PREFIX -ErrorAction SilentlyContinue
}

function Test-InstallOutputFailed {
    param([string]$Output)
    return (
        $Output -match "Failed to clone" -or
        $Output -match "Installation failed" -or
        $Output -match "TLS connect error" -or
        $Output -match "unexpected eof" -or
        $Output -match "Could not resolve host" -or
        $Output -match "Connection timed out" -or
        $Output -match "RPC failed"
    )
}

function Test-InstallOutputSucceeded {
    param([string]$Output)
    return (
        $Output -match "Installed \d+ skill" -or
        $Output -match "Installation complete" -or
        $Output -match "Done!"
    )
}

function Invoke-NpxSkillInstallOnce {
    param(
        [string]$Repo,
        [string[]]$Skills,
        [switch]$All
    )

    $skillCliArgs = @("skills", "add", $Repo)
    if ($All) {
        $skillCliArgs += @("--all")
    } else {
        foreach ($s in $Skills) { $skillCliArgs += @("--skill", $s) }
    }
    $skillCliArgs += @("-g", "-a", "*", "-y")

    try {
        return (& npx @skillCliArgs 2>&1 | Out-String)
    } catch {
        return $_.Exception.Message
    }
}

function Invoke-SkillInstall {
    param(
        [string]$Label,
        [string]$Repo,
        [string[]]$Skills,
        [switch]$All,
        [string]$LogDir,
        [string]$LogPrefix = "batch"
    )

    Write-Host ""
    Write-Host ">>> $Label" -ForegroundColor Cyan
    Write-Host "    Repo: $Repo" -ForegroundColor DarkGray

    $logFile = $null
    if ($LogDir) {
        New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
        $logFile = Join-Path $LogDir ("{0}-{1}.log" -f $LogPrefix, ($Label -replace '[^a-zA-Z0-9_-]', '_'))
    }

    $mirrors = Get-GitHubMirrorCandidates
    $attempt = 0
    $lastOutput = ""

    foreach ($mirror in $mirrors) {
        $attempt++
        if ($mirror) {
            Set-GitHubMirrorPrefix -MirrorPrefix $mirror
            Write-Host "    mirror $attempt of $($mirrors.Count): $mirror" -ForegroundColor DarkYellow
        } else {
            Set-GitHubMirrorPrefix -MirrorPrefix $null
            Write-Host "    direct GitHub $attempt of $($mirrors.Count)" -ForegroundColor DarkGray
        }

        $lastOutput = Invoke-NpxSkillInstallOnce -Repo $Repo -Skills $Skills -All:$All

        if (Test-InstallOutputSucceeded -Output $lastOutput) {
            if ($logFile) { $lastOutput | Out-File $logFile -Encoding utf8 }
            return @{ Ok = $true; Output = $lastOutput; Mirror = $mirror }
        }

        if (-not (Test-InstallOutputFailed -Output $lastOutput)) {
            break
        }
    }

    if ($logFile) { $lastOutput | Out-File $logFile -Encoding utf8 }
    return @{ Ok = $false; Output = $lastOutput; Mirror = $null }
}
