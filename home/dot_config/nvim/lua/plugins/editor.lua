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
}
