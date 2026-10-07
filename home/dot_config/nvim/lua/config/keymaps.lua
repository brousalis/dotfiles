-- Loaded on VeryLazy. LazyVim defaults:
-- https://www.lazyvim.org/configuration/keymaps
--
-- Mappings ported from the original vimrc. Changes from the old file:
--   K stays LSP hover (LazyVim); the old split-line K moved to <leader>K.
--   <leader>k was mapped twice in the old file; the window move won, so it stays.
--   <CR> opens a line below only in normal buffers, so quickfix Enter still works.

local map = vim.keymap.set

map("n", "<leader><space>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("i", "jj", "<Esc>")
map("i", "jk", "<Esc>")
map("n", ";", ":", { desc = "Command line" })
map("n", "<leader>K", "i<CR><Esc>", { desc = "Split line" })
map("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })
map("i", "<C-Tab>", "<Esc><<i")
map("n", "'.", "<cmd>cd %:p:h<cr>", { silent = true, desc = "cd to file's directory" })
map("n", "Q", "q", { desc = "Record macro" })
map("n", "q", "<nop>")
map("n", "<CR>", function()
  return vim.bo.buftype == "" and "o<Esc>" or "<CR>"
end, { expr = true, desc = "Open line below" })

-- Tabs
map("n", "<F1>", "<cmd>tabprevious<cr>")
map("n", "<F2>", "<cmd>tabnext<cr>")
map("n", "tj", "<cmd>tabnext<cr>")
map("n", "tk", "<cmd>tabprevious<cr>")
map("n", "tl", "<cmd>tabnext<cr>")
map("n", "th", "<cmd>tabprevious<cr>")
map("n", "<C-t>", ":tabedit ", { desc = "Open in new tab" })

-- Search and replace
map("n", "<leader>r", ":%s/", { desc = "Replace in file" })

-- Windows
map("n", "<leader>h", "<C-w>h", { desc = "Window left" })
map("n", "<leader>j", "<C-w>j", { desc = "Window down" })
map("n", "<leader>k", "<C-w>k", { desc = "Window up" })
map("n", "<leader>l", "<C-w>l", { desc = "Window right" })

-- Paste and reindent
map("n", "<leader>p", "pV`]=", { desc = "Paste and reindent" })
map("n", "<leader>P", "PV`]=", { desc = "Paste above and reindent" })

-- Tab to indent
map("n", "<Tab>", ">>_")
map("n", "<S-Tab>", "<<_")
map("i", "<S-Tab>", "<C-d>")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- x deletes without touching the clipboard
map("n", "x", '"_x')

-- Double quotes to single quotes in the file
map("n", "<F3>", [[:%s/"\(\([^"]*\)\)"/'\1'/g<cr>]], { desc = "Double to single quotes" })

-- VS Code / Cursor shortcuts, on by default (see vscode-keys.lua).
local vscode_env = vim.env.NVIM_VSCODE_KEYS
if vscode_env == "1" or (vscode_env ~= "0" and vim.g.vscode_keys) then
  require("config.vscode-keys")
end
