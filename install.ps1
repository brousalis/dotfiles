# Bootstrap these dotfiles on native Windows:
#
#   irm https://raw.githubusercontent.com/brousalis/dotfiles/v2/install.ps1 | iex
#
# Or from a clone: .\install.ps1
$ErrorActionPreference = 'Stop'

$repo = if ($env:DOTFILES_REPO) { $env:DOTFILES_REPO } else { 'brousalis/dotfiles' }
$branch = if ($env:DOTFILES_BRANCH) { $env:DOTFILES_BRANCH } else { 'v2' }
$dest = if ($env:DOTFILES_DIR) { $env:DOTFILES_DIR } else { Join-Path $HOME '.dotfiles' }

# Profiles and local scripts need to be allowed to run.
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

foreach ($id in 'Git.Git', 'twpayne.chezmoi') {
  winget list --exact --id $id --accept-source-agreements *> $null
  if ($LASTEXITCODE -ne 0) {
    winget install --exact --id $id --silent --accept-package-agreements --accept-source-agreements
  }
}
$env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')

if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot '.chezmoiroot'))) {
  chezmoi init --apply --source $PSScriptRoot
} else {
  chezmoi init --apply --branch $branch --source $dest $repo
}
