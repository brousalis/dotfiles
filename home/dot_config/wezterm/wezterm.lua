-- WezTerm: the terminal on macOS, Linux and Windows.
--
-- tmux owns C-a and the pane keys everywhere, so WezTerm stays out of the way.
-- On Windows it opens into WSL, where tmux runs.

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find("windows") ~= nil

config.font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font", "JetBrains Mono" })
config.font_size = is_windows and 11 or 14
config.color_scheme = "One Dark (Gogh)"
config.window_decorations = "RESIZE"
config.window_padding = { left = 6, right = 6, top = 4, bottom = 4 }
config.scrollback_lines = 100000
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = not is_windows

config.keys = {
  -- Shift+Enter inserts a newline in Claude Code instead of submitting.
  { key = "Enter", mods = "SHIFT", action = act.SendString("\x1b\r") },
}

if not is_windows then
  -- Cmd+[ / Cmd+] never reach tmux, so send its prefix (C-a) plus the key:
  -- select the previous / next pane. This overrides WezTerm's default
  -- Cmd+[ / Cmd+] tab switching.
  table.insert(config.keys, { key = "[", mods = "SUPER", action = act.SendString("\x01[") })
  table.insert(config.keys, { key = "]", mods = "SUPER", action = act.SendString("\x01]") })
end

if is_windows then
  config.default_prog = { "wsl.exe", "--cd", "~" }
  config.launch_menu = {
    { label = "WSL", args = { "wsl.exe", "--cd", "~" } },
    { label = "PowerShell", args = { "pwsh.exe", "-NoLogo" } },
    { label = "Windows PowerShell", args = { "powershell.exe", "-NoLogo" } },
  }
end

-- Machine-only overrides in ~/.config/wezterm/local.lua, not in the repo:
--   return function(config) config.font_size = 13 end
local ok, local_config = pcall(require, "local")
if ok and type(local_config) == "function" then
  local_config(config)
end

return config
