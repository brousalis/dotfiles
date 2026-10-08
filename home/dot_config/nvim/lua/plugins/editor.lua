return {
  -- Show dotfiles in the pickers, like ctrlp_show_hidden in the old vimrc.
  {
    "folke/snacks.nvim",
    opts = {
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
