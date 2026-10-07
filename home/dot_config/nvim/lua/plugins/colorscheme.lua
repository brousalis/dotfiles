-- Kanagawa Dragon: a warm, muted dark theme that sits well next to Claude
-- Code, with Claude's orange (#D77757) as the accent. WezTerm uses the same
-- palette, so the Claude pane and Neovim share one background.
local claude = "#D77757"

return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon",
      background = { dark = "dragon", light = "lotus" },
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      overrides = function(colors)
        local theme = colors.theme
        return {
          CursorLineNr = { fg = claude, bold = true },
          Search = { fg = theme.ui.bg, bg = claude },
          IncSearch = { fg = theme.ui.bg, bg = claude, bold = true },
          CurSearch = { fg = theme.ui.bg, bg = claude, bold = true },
          FloatBorder = { fg = theme.ui.nontext, bg = "none" },
          NormalFloat = { bg = "none" },
          FloatTitle = { fg = claude, bg = "none", bold = true },
          SnacksPickerMatch = { fg = claude, bold = true },
          FlashLabel = { fg = theme.ui.bg, bg = claude, bold = true },
          BlinkCmpLabelMatch = { fg = claude, bold = true },
          WhichKey = { fg = claude },
        }
      end,
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "kanagawa" } },
}
