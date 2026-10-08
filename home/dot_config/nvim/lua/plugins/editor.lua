return {
  -- Show dotfiles in the pickers, like ctrlp_show_hidden in the old vimrc.
  {
    "folke/snacks.nvim",
    opts = {
      -- Two panes on wide terminals: header and keys on the left, recent files,
      -- projects and git status on the right. Narrow ones get one pane.
      dashboard = {
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          {
            pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1,
            cwd = true, limit = 8, enabled = function() return vim.o.columns >= 110 end,
          },
          {
            pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1,
            limit = 5, enabled = function() return vim.o.columns >= 110 end,
          },
          {
            pane = 2, icon = " ", title = "Git Status", section = "terminal", indent = 3, padding = 1, ttl = 5 * 60,
            cmd = "git status --short --branch --renames", height = 6,
            enabled = function() return vim.o.columns >= 110 and Snacks.git.get_root() ~= nil end,
          },
          { section = "startup" },
        },
      },
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          -- The explorer hides git-ignored dirs; `include` overrides that for the
          -- gitignored repos inside ~/dev/armhr.
          explorer = { hidden = true, include = { "**/armhr-frontend", "**/armhr-python" } },
        },
      },
    },
  },

  -- Close the grug-far buffer after a replace; the keymaps are in vscode-keys.lua.
  { "MagicDuck/grug-far.nvim", opts = { transient = true } },

  -- Dock the symbols outline on the right, next to Grug Far and Claude Code.
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, { title = "Outline", ft = "Outline", size = { width = 0.25 } })
    end,
  },
}
