-- Loaded before lazy.nvim starts. LazyVim defaults:
-- https://www.lazyvim.org/configuration/general

-- Comma leader, as in the original vimrc.
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

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
