-- Loaded before lazy.nvim starts. LazyVim defaults:
-- https://www.lazyvim.org/configuration/general

-- Comma leader, as in the original vimrc.
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- VS Code / Cursor shortcuts (lua/config/vscode-keys.lua). On by default. Set to
-- false to turn them off everywhere, or set NVIM_VSCODE_KEYS=0 on one machine.
vim.g.vscode_keys = true

local opt = vim.opt

-- From the original vimrc
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.modeline = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.scrolloff = 3
opt.relativenumber = false
opt.wrap = true
opt.textwidth = 79
opt.formatoptions = "qrn1j"
opt.gdefault = true
opt.visualbell = true
opt.list = true
opt.listchars = { tab = "▸ ", trail = "·", nbsp = "␣" }
opt.iskeyword:remove({ "_", "-" })

-- WSL: send the + register to the Windows clipboard. Without this Neovim finds
-- no clipboard tool in WSL and yanks never leave the terminal. From
-- :help clipboard-wsl; win32yank.exe, if installed, is faster and is used instead.
if vim.fn.has("wsl") == 1 and vim.fn.executable("win32yank.exe") == 0 then
  local paste = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = { ["+"] = "clip.exe", ["*"] = "clip.exe" },
    paste = { ["+"] = paste, ["*"] = paste },
    cache_enabled = 0,
  }
end
