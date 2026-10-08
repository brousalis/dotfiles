-- VS Code / Cursor shortcuts for Neovim. On by default.
--
-- Turn off with either:
--   * NVIM_VSCODE_KEYS=0 in the environment (per machine, e.g. ~/.localenv or
--     ~/.localrc.ps1), or
--   * vim.g.vscode_keys = false in lua/config/options.lua (every machine).
--
-- These mostly use Ctrl and Alt chords that terminals can send. Ctrl+Shift
-- combos only work where the terminal sends extended keys, so each has a
-- <leader> equivalent that always works. Where a key replaces a Vim or
-- LazyVim default, the comment says what you give up.

local map = function(modes, lhs, rhs, desc, opts)
  vim.keymap.set(modes, lhs, rhs, vim.tbl_extend("force", { desc = "VSCode: " .. desc, silent = true }, opts or {}))
end
local remap = { remap = true }

-- Navigate -------------------------------------------------------------------

map("n", "<C-p>", "<leader>ff", "Go to file (Ctrl+P)", remap) -- replaces: previous line
map("n", "<C-g>", ":", "Go to line (Ctrl+G), type a number", { silent = false }) -- replaces: file info
map({ "n", "x" }, "<C-S-p>", "<leader>sC", "Command palette (Ctrl+Shift+P)", remap)
map("n", "<C-S-o>", "<leader>ss", "Go to symbol (Ctrl+Shift+O)", remap)
map("n", "<C-S-e>", "<leader>e", "Explorer (Ctrl+Shift+E)", remap)
map("n", "<C-b>", "<leader>e", "Toggle explorer (Ctrl+B)", remap) -- replaces: page up
map("n", "<C-S-g>", "<leader>gg", "Source control (Ctrl+Shift+G)", remap)
map("n", "<C-S-m>", "<leader>xx", "Problems (Ctrl+Shift+M)", remap)

-- Find and replace (grug-far). Ctrl+Shift+F toggles the project-wide sidebar, Ctrl+F is the
-- current file. Ctrl+F replaces: page down, which moves to Ctrl+H below.
local function replace(scope)
  return function()
    if scope == "project" then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "grug-far" then
          return vim.api.nvim_win_close(win, true)
        end
      end
    end
    local grug, mode = require("grug-far"), vim.fn.mode()
    local opts = { prefills = scope == "file" and { paths = vim.fn.expand("%") } or nil }
    if mode == "v" or mode == "V" or mode == "\22" then
      grug.with_visual_selection(opts)
    else
      opts.prefills = vim.tbl_extend("force", opts.prefills or {}, { search = vim.fn.expand("<cword>") })
      grug.open(opts)
    end
  end
end
map({ "n", "x" }, "<C-S-f>", replace("project"), "Toggle project find and replace (Ctrl+Shift+F)")
map({ "n", "x" }, "<C-f>", replace("file"), "Find and replace in file (Ctrl+F)")
map({ "n", "x" }, "<C-h>", "<C-f>", "Page down (was Ctrl+F)", { remap = false }) -- replaces: go to left window, use <C-w>h
map("n", "<leader>sS", "<leader>/", "Search in files without replace", remap)

-- Edit -----------------------------------------------------------------------

-- Ctrl+S already saves in LazyVim.
-- Ctrl+/ comments; the terminal toggle that LazyVim has here is still on <leader>ft.
map("n", "<C-/>", "gcc", "Toggle comment (Ctrl+/)", remap)
map("n", "<C-_>", "gcc", "Toggle comment (Ctrl+/)", remap)
map("x", "<C-/>", "gc", "Toggle comment (Ctrl+/)", remap)
map("x", "<C-_>", "gc", "Toggle comment (Ctrl+/)", remap)
map("i", "<C-/>", "<cmd>normal gcc<cr>", "Toggle comment (Ctrl+/)")
map("i", "<C-_>", "<cmd>normal gcc<cr>", "Toggle comment (Ctrl+/)")

-- Alt+Up/Down is not used because tmux resizes panes with it. LazyVim's
-- Alt+j / Alt+k already move lines; Alt+Shift+j / k copy them.
map("n", "<M-J>", "<cmd>t.<cr>", "Copy line down (Shift+Alt+Down)")
map("n", "<M-K>", "<cmd>t-1<cr>", "Copy line up (Shift+Alt+Up)")
map("x", "<M-J>", ":<C-u>'<,'>t'><cr>gv", "Copy selection down")
map("x", "<M-K>", ":<C-u>'<,'>t'<-1<cr>gv", "Copy selection up")

map({ "n", "x" }, "<M-F>", "<leader>cf", "Format (Shift+Alt+F)", remap)

-- Code -----------------------------------------------------------------------

-- F2 (rename) is not mapped: tmux uses F1-F5 for windows. Use <leader>cr.
map({ "n", "x" }, "<M-.>", "<leader>ca", "Quick fix (Ctrl+. in VS Code)", remap)
map({ "n", "x" }, "<C-.>", "<leader>ca", "Quick fix (Ctrl+.)", remap)
map("n", "<F8>", "]d", "Next problem (F8)", remap)
map("n", "<S-F8>", "[d", "Previous problem (Shift+F8)", remap)
-- F12 never reaches Neovim inside tmux (it switches windows): use gd / gr / gI.

-- Editors and buffers --------------------------------------------------------

map("n", "<M-w>", "<leader>bd", "Close editor (Ctrl+W in VS Code)", remap)
for i = 1, 9 do
  map("n", ("<M-%d>"):format(i), ("<cmd>BufferLineGoToBuffer %d<cr>"):format(i), ("Go to buffer %d (Alt+%d)"):format(i, i))
end
