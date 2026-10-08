# PowerShell port of ~/.aliases. Keep the two in step when adding one.

# Built-in aliases that would shadow these.
foreach ($name in 'gc', 'gp', 'h', 'ls') {
  Remove-Item "Alias:$name" -Force -ErrorAction SilentlyContinue
}

function .. { Set-Location .. }
function ... { Set-Location ../.. }

if (Get-Command eza -ErrorAction SilentlyContinue) {
  function ls { eza -la @args }
  function ll { eza -l --sort=modified --reverse @args }
} else {
  function ls { Get-ChildItem -Force @args }
  function ll { Get-ChildItem @args | Sort-Object LastWriteTime -Descending }
}

function g { git @args }
function ga { git add @args }
function gs { git status -s @args }
function gco { git checkout @args }
function gp { git push @args }
function gre($branch) {
  git fetch origin
  git checkout ((git symbolic-ref --short refs/remotes/origin/HEAD) -replace '^origin/', '')
  git branch -D $branch
  git checkout -t "origin/$branch"
}
function gbd { git branch -D @args }
function grs { git reset --hard HEAD }
function gc { git commit @args }
function gct { git commit -t @args }
function grm { git ls-files --deleted | ForEach-Object { git rm $_ } }
function undopush { git push -f origin HEAD^:master }
function undocommit { git reset --soft HEAD~1 }

function h { Set-Location ~ }
function home { Set-Location ~ }
function dotfiles { Set-Location ~/.dotfiles }
function dev { Set-Location ~/dev }

function nom { Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue; npm cache clean --force; npm install }
function rmnm { Get-ChildItem -Recurse -Directory -Filter node_modules | Remove-Item -Recurse -Force }
function server { python -m http.server 1337 }
function ip { (Invoke-RestMethod https://api.ipify.org) }
function untar { tar -xvvf @args }
function reload { . $PROFILE }
function u { chezmoi update }
