return {
  -- Merge conflicts (3-way: ours | result | theirs) and PR-style diffs.
  -- In a conflict: <leader>co/ct/cb/ca pick ours/theirs/base/all.
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    opts = {},
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview (working tree)" },
      { "<leader>gD", "<cmd>DiffviewOpen origin/HEAD...HEAD<cr>", desc = "Diffview (vs origin/HEAD)" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview file history" },
      { "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview branch history" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
    },
  },

  -- Full PR review (inline comments, submit review). Snacks keeps the quick
  -- <leader>gp / <leader>gi pickers; Octo lives under <leader>go.
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
    dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
    opts = { picker = "snacks", enable_builtin = true },
    keys = {
      { "<leader>gop", "<cmd>Octo pr list<cr>", desc = "PRs (Octo)" },
      { "<leader>goi", "<cmd>Octo issue list<cr>", desc = "Issues (Octo)" },
      { "<leader>gor", "<cmd>Octo review start<cr>", desc = "Start review (Octo)" },
      { "<leader>gos", "<cmd>Octo review submit<cr>", desc = "Submit review (Octo)" },
    },
  },
}
