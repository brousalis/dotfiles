-- Git root of the current buffer, so Diffview works inside the gitignored repos
-- nested in ~/dev/armhr. With no file (or one outside any repo), pick from the
-- child repos of the cwd.
local function with_repo(cb)
  local function root(dir)
    local out = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
    return vim.v.shell_error == 0 and out[1] or nil
  end
  local file = vim.api.nvim_buf_get_name(0)
  local dir = file ~= "" and vim.fn.fnamemodify(file, ":p:h") or vim.uv.cwd()
  local top = vim.fn.isdirectory(dir) == 1 and root(dir)
  local cwd = vim.uv.cwd()
  -- A buffer in the wrapper repo itself isn't what we want when child repos exist.
  local children = vim.fn.glob(cwd .. "/*/.git", false, true)
  if top and (top ~= cwd or #children == 0) then
    return cb(top)
  end
  if #children == 0 then
    return cb(cwd)
  end
  local repos = vim.tbl_map(function(g) return vim.fn.fnamemodify(g, ":h") end, children)
  vim.ui.select(repos, { prompt = "Repo", format_item = function(r) return vim.fn.fnamemodify(r, ":t") end }, function(r)
    if r then cb(r) end
  end)
end

-- Octo and gh read the cwd's remote, so move the tab into the repo first.
local function octo(cmd)
  return function()
    with_repo(function(repo)
      vim.cmd("tcd " .. vim.fn.fnameescape(repo))
      vim.cmd(cmd)
    end)
  end
end

local function diffview(args_fn)
  return function()
    with_repo(function(repo)
      vim.cmd("DiffviewOpen -C=" .. vim.fn.fnameescape(repo) .. args_fn(repo))
    end)
  end
end

return {
  -- Merge conflicts (3-way: ours | result | theirs) and PR-style diffs.
  -- In a conflict: <leader>co/ct/cb/ca pick ours/theirs/base/all.
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    opts = {},
    keys = {
      { "<leader>gd", diffview(function() return "" end), desc = "Diffview (working tree)" },
      { "<leader>gD", diffview(function() return " origin/HEAD...HEAD" end), desc = "Diffview (vs origin/HEAD)" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview file history" },
      { "<leader>gF", function() with_repo(function(r) vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(r)) end) end, desc = "Diffview branch history" },
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
      { "<leader>gop", octo("Octo pr list"), desc = "PRs (Octo)" },
      { "<leader>goi", octo("Octo issue list"), desc = "Issues (Octo)" },
      { "<leader>gor", octo("Octo review start"), desc = "Start review (Octo)" },
      { "<leader>gos", octo("Octo review submit"), desc = "Submit review (Octo)" },
    },
  },

  -- Snacks git pickers scoped to the buffer's repo (or a picked child repo).
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gs", function() with_repo(function(r) Snacks.picker.git_status({ cwd = r }) end) end, desc = "Git Status" },
    },
  },
}
