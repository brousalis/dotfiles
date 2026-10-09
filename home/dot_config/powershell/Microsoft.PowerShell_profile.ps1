# PowerShell profile. pwsh on macOS/Linux reads this path directly; on Windows
# both PowerShell profiles dot-source it (see the powershell-profile script).

if (-not $env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME = Join-Path $HOME '.config' }
# direnv derives these from $HOME, which Windows doesn't set
if (-not $env:XDG_CACHE_HOME) { $env:XDG_CACHE_HOME = Join-Path $HOME '.cache' }
if (-not $env:XDG_DATA_HOME)  { $env:XDG_DATA_HOME  = Join-Path $HOME '.local/share' }
$env:EDITOR = 'nvim'
$env:VISUAL = 'nvim'
$env:DEV = Join-Path $HOME 'dev'

# Line editing
if (Get-Module -ListAvailable PSReadLine) {
  Set-PSReadLineOption -EditMode Emacs -HistoryNoDuplicates -BellStyle None
  if ($PSVersionTable.PSVersion.Major -ge 7) {
    Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
  }
  Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
  Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
}

function Test-Command($name) { [bool](Get-Command $name -ErrorAction SilentlyContinue) }

# Tools
if (Test-Command mise)     { mise activate pwsh | Out-String | Invoke-Expression }
if (Test-Command zoxide)   { zoxide init powershell | Out-String | Invoke-Expression }
if (Test-Command direnv)   { $h = direnv hook pwsh | Out-String; if ($h.Trim()) { Invoke-Expression $h } }
if (Test-Command direnv) {
  # Empty output (direnv failed) would make Invoke-Expression throw.
  $direnvHook = direnv hook pwsh | Out-String
  if ($direnvHook.Trim()) { Invoke-Expression $direnvHook }
}
# Which system this shell is on, shown by the starship prompt. Windows
# PowerShell 5.1 has no $IsMacOS/$IsLinux, so it falls through to win.
$env:PROMPT_OS = if ($IsMacOS) { 'mac' } elseif ($IsLinux) { if ($env:WSL_DISTRO_NAME) { 'wsl' } else { 'linux' } } else { 'win' }
if (Test-Command starship) { starship init powershell | Out-String | Invoke-Expression }
if (Get-Module -ListAvailable PSFzf) {
  Import-Module PSFzf
  Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}
if (Test-Command nvim) { Set-Alias vim nvim; Set-Alias vi nvim }

# Aliases ported from ~/.aliases
. (Join-Path $PSScriptRoot 'aliases.ps1')

# Machine-only config, not in the repo.
$local = Join-Path $HOME '.localrc.ps1'
if (Test-Path $local) { . $local }
