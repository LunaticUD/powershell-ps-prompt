# 在 $PROFILE 末尾加入：
# . "$HOME\Downloads\powershell\ps-prompt.ps1"

$esc = [char]27
$ansiEnabled = -not $env:NO_COLOR

if ($PSVersionTable.PSVersion.Major -lt 6) {
    if ($Host.Name -ne 'ConsoleHost') {
        $ansiEnabled = $false
    }
    else {
        try {
            if (-not ('PsPrompt.Native' -as [type])) {
                Add-Type -Namespace PsPrompt -Name Native -MemberDefinition @'
[DllImport("kernel32.dll", SetLastError = true)]
public static extern IntPtr GetStdHandle(int nStdHandle);

[DllImport("kernel32.dll", SetLastError = true)]
public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);

[DllImport("kernel32.dll", SetLastError = true)]
public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
'@
            }

            $handle = [PsPrompt.Native]::GetStdHandle(-11)
            $mode = [uint32]0
            if ([PsPrompt.Native]::GetConsoleMode($handle, [ref]$mode)) {
                [void][PsPrompt.Native]::SetConsoleMode($handle, $mode -bor 0x0004)
            }
            else {
                $ansiEnabled = $false
            }
        }
        catch {
            $ansiEnabled = $false
        }
    }
}

$palette = @{
    Reset  = '0'
    Env    = '38;5;179'
    Parent = '38;5;245'
    Leaf   = '1;38;5;255'
    Git    = '38;5;114'
    Accent = '1;38;5;81'
}

$colors = @{}
foreach ($name in $palette.Keys) {
    $colors[$name] = if ($ansiEnabled) { "$esc[$($palette[$name])m" } else { '' }
}

$global:PsPromptState = @{
    Colors = $colors
}

function global:Get-PsPromptGitBranch {
    param([string]$Path)

    $gitDir = $null
    $current = $Path

    while ($current) {
        $candidate = Join-Path -Path $current -ChildPath '.git'

        if (Test-Path -LiteralPath $candidate -PathType Container) {
            $gitDir = $candidate
            break
        }

        if (Test-Path -LiteralPath $candidate -PathType Leaf) {
            $gitFile = Get-Content -LiteralPath $candidate -TotalCount 1 -ErrorAction SilentlyContinue
            if ($gitFile -match '^gitdir:\s*(.+)$') {
                $gitDir = $Matches[1].Trim()
                if (-not [IO.Path]::IsPathRooted($gitDir)) {
                    $gitDir = Join-Path -Path $current -ChildPath $gitDir
                }
                break
            }
        }

        $parent = [IO.Path]::GetDirectoryName($current)
        if (-not $parent -or $parent -eq $current) { break }
        $current = $parent
    }

    if (-not $gitDir) { return }

    $head = Get-Content -LiteralPath (Join-Path -Path $gitDir -ChildPath 'HEAD') -TotalCount 1 -ErrorAction SilentlyContinue
    if (-not $head) { return }

    $head = $head.Trim()
    if ($head -match '^ref:\s*refs/heads/(.+)$') {
        return $Matches[1]
    }
    if ($head -match '^[0-9a-f]{40}$') {
        return $head.Substring(0, 7)
    }
}

function global:prompt {
    $c = $global:PsPromptState.Colors

    $displayPath = $PWD.Path
    $isFileSystem = $PWD.Provider.Name -eq 'FileSystem'

    if ($isFileSystem) {
        $homePath = $env:USERPROFILE
        if ($homePath) {
            $homePath = $homePath.TrimEnd('\')
            if ($displayPath.Equals($homePath, [StringComparison]::OrdinalIgnoreCase)) {
                $displayPath = '~'
            }
            elseif ($displayPath.StartsWith($homePath + '\', [StringComparison]::OrdinalIgnoreCase)) {
                $displayPath = '~' + $displayPath.Substring($homePath.Length)
            }
        }
    }

    $parentPart = ''
    $leafPart = $displayPath
    $lastSlash = $displayPath.LastIndexOf('\')

    if ($lastSlash -gt 0 -and $lastSlash -lt ($displayPath.Length - 1)) {
        $parentPart = $displayPath.Substring(0, $lastSlash + 1)
        $leafPart = $displayPath.Substring($lastSlash + 1)
    }

    $branchPart = ''
    if ($isFileSystem) {
        try {
            $branch = Get-PsPromptGitBranch -Path $PWD.ProviderPath
            if ($branch) {
                $branchPart = "$($c.Git)($branch)$($c.Reset)"
            }
        }
        catch {}
    }

    $envPart = ''
    $condaLabel = $env:CONDA_PROMPT_MODIFIER
    if ($condaLabel) {
        $envPart = "$($c.Env)$($condaLabel.Trim())$($c.Reset) "
    }
    elseif ($env:CONDA_DEFAULT_ENV) {
        $envPart = "$($c.Env)($($env:CONDA_DEFAULT_ENV))$($c.Reset) "
    }

    return "$envPart$($c.Parent)$parentPart$($c.Leaf)$leafPart$($c.Reset)$branchPart $($c.Accent)❯$($c.Reset) "
}
