-- WezTerm: the terminal on macOS, Linux and Windows.
--
-- On macOS and Linux, tmux owns C-a and the pane keys, so WezTerm stays out of
-- the way. On native Windows there is no tmux, so WezTerm's own multiplexer
-- takes the same keys as ~/.tmux.conf: C-a prefix, hjkl, s/v splits, F11/F12,
-- Alt+arrows to resize, Alt+0 to pick a workspace.

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

if is_windows then
  config.default_prog = { "pwsh.exe", "-NoLogo" }
  config.launch_menu = {
    { label = "PowerShell", args = { "pwsh.exe", "-NoLogo" } },
    { label = "WSL", args = { "wsl.exe", "--cd", "~" } },
    { label = "Windows PowerShell", args = { "powershell.exe", "-NoLogo" } },
  }

  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

  local tmux_keys = {
    -- C-a C-a cycles panes, as `bind ^A select-pane -t :.+` does in tmux.
    { key = "a", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Next") },
    -- C-a [ and C-a ] select the previous and next pane.
    { key = "[", mods = "LEADER", action = act.ActivatePaneDirection("Prev") },
    { key = "]", mods = "LEADER", action = act.ActivatePaneDirection("Next") },
    { key = "F1", action = act.ActivateTabRelative(-1) },
    { key = "F2", action = act.ActivateTabRelative(1) },
    { key = "F11", action = act.ActivateTabRelative(-1) },
    { key = "F12", action = act.ActivateTabRelative(1) },
    { key = "Escape", mods = "LEADER", action = act.ActivateCopyMode },
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = "s", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "v", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "0", mods = "ALT", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
    { key = "UpArrow", mods = "ALT", action = act.AdjustPaneSize({ "Up", 2 }) },
    { key = "DownArrow", mods = "ALT", action = act.AdjustPaneSize({ "Down", 2 }) },
    { key = "LeftArrow", mods = "ALT", action = act.AdjustPaneSize({ "Left", 2 }) },
    { key = "RightArrow", mods = "ALT", action = act.AdjustPaneSize({ "Right", 2 }) },
    { key = "R", mods = "LEADER|SHIFT", action = act.ReloadConfiguration },
    -- C-a C opens Claude Code to the right, as in tmux.
    {
      key = "C",
      mods = "LEADER|SHIFT",
      action = act.SplitPane({ direction = "Right", size = { Percent = 40 }, command = { args = { "pwsh.exe", "-NoLogo", "-NoExit", "-Command", "claude" } } }),
    },
    -- tmux defaults that the tmux config relies on.
    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },
    { key = "l", mods = "LEADER|SHIFT", action = act.ShowLauncher },
  }
  for i = 1, 9 do
    -- Windows (tabs) start at 1, like base-index 1 in tmux.
    table.insert(tmux_keys, { key = tostring(i), mods = "LEADER", action = act.ActivateTab(i - 1) })
  end
  for _, k in ipairs(tmux_keys) do
    table.insert(config.keys, k)
  end
end

-- Machine-only overrides in ~/.config/wezterm/local.lua, not in the repo:
--   return function(config) config.font_size = 13 end
local ok, local_config = pcall(require, "local")
if ok and type(local_config) == "function" then
  local_config(config)
end

return config
