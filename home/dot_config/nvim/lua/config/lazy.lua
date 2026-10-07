local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" } }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Keep the plugin lockfile in the dotfiles repo so every machine runs the same
-- plugin versions. :Lazy update writes it there; commit it, and other machines
-- pick it up with `chezmoi update` then :Lazy restore.
local repo_lockfile = vim.fn.expand("~/.dotfiles/home/dot_config/nvim/lazy-lock.json")
local lockfile = vim.uv.fs_stat(repo_lockfile) and repo_lockfile or vim.fn.stdpath("config") .. "/lazy-lock.json"

require("lazy").setup({
  lockfile = lockfile,
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Extras live here rather than in lazyvim.json, which LazyVim rewrites
    -- itself (so chezmoi would keep fighting it). :LazyExtras still shows them.
    { import = "lazyvim.plugins.extras.ai.claudecode" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.util.chezmoi" },
    { import = "lazyvim.plugins.extras.util.dot" },
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
