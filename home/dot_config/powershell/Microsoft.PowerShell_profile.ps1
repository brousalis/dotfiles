# PowerShell profile. pwsh on macOS/Linux reads this path directly; on Windows
# both PowerShell profiles dot-source it (see the powershell-profile script).

if (-not $env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME = Join-Path $HOME '.config' }
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
if (Test-Command direnv)   { direnv hook pwsh | Out-String | Invoke-Expression }
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
