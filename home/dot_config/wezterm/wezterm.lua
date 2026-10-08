-- WezTerm: the terminal on macOS, Linux and Windows.
--
-- tmux owns C-a and the pane keys everywhere, so WezTerm stays out of the way.
-- On Windows it opens into WSL, where tmux runs. Native (non-WSL) panes get
-- tmux-style keys from WezTerm itself; WSL panes pass them through to tmux.

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple:find("windows") ~= nil

config.font = wezterm.font_with_fallback({ "Iosevka Nerd Font", "JetBrainsMono Nerd Font", "JetBrains Mono" })
config.font_size = is_windows and 11 or 14
-- Kanagawa Dragon (from rebelot/kanagawa.nvim); WezTerm has no built-in copy.
config.colors = {
  foreground = "#c5c9c5",
  background = "#181616",
  cursor_bg = "#c8c093",
  cursor_fg = "#181616",
  cursor_border = "#c8c093",
  selection_fg = "#c8c093",
  selection_bg = "#2d4f67",
  scrollbar_thumb = "#393836",
  split = "#393836",
  ansi = { "#0d0c0c", "#c4746e", "#8a9a7b", "#c4b28a", "#8ba4b0", "#a292a3", "#8ea4a2", "#c8c093" },
  brights = { "#a6a69c", "#e46876", "#87a987", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#c5c9c5" },
}
config.window_decorations = "RESIZE"
config.window_padding = { left = 6, right = 6, top = 4, bottom = 4 }
config.scrollback_lines = 100000
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- Send Ctrl+Shift chords as distinct keys (CSI u) so Neovim can bind them.
config.enable_csi_u_key_encoding = true

config.keys = {
  -- WezTerm's own Ctrl+Shift+F (search) and +P (command palette) would swallow the
  -- VS Code-style chords in Neovim (lua/config/vscode-keys.lua), so they move to
  -- Ctrl+Alt. Alt+Shift is taken there too (Alt+Shift+F formats). Ctrl+Shift+M
  -- is only disabled.
  { key = "F", mods = "CTRL|ALT", action = act.Search({ CaseSensitiveString = "" }) },
  { key = "P", mods = "CTRL|ALT", action = act.ActivateCommandPalette },
  { key = "F", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "P", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  { key = "M", mods = "CTRL|SHIFT", action = act.DisableDefaultAssignment },
  -- Shift+Enter inserts a newline in Claude Code instead of submitting.
  { key = "Enter", mods = "SHIFT", action = act.SendString("\x1b\r") },
  -- Ctrl+Shift+B shows / hides the tab bar for this window (resets on reload).
  {
    key = "B",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(function(window)
      local overrides = window:get_config_overrides() or {}
      overrides.enable_tab_bar = overrides.enable_tab_bar == false
      window:set_config_overrides(overrides)
    end),
  },
}

if not is_windows then
  -- Cmd+[ / Cmd+] never reach tmux, so send its prefix (C-a) plus the key:
  -- select the previous / next pane. This overrides WezTerm's default
  -- Cmd+[ / Cmd+] tab switching.
  table.insert(config.keys, { key = "[", mods = "SUPER", action = act.SendString("\x01[") })
  table.insert(config.keys, { key = "]", mods = "SUPER", action = act.SendString("\x01]") })
end

if is_windows then
  -- Windows-style copy/paste. Ctrl+C copies only when text is selected, so it
  -- still interrupts otherwise; Ctrl+V pastes; right-click pastes. tmux mouse
  -- selections already reach the clipboard via OSC 52; Shift+drag selects in
  -- WezTerm itself and now copies on release too.
  table.insert(config.keys, {
    key = "c",
    mods = "CTRL",
    action = wezterm.action_callback(function(window, pane)
      local sel = window:get_selection_text_for_pane(pane)
      if sel ~= "" then
        window:perform_action(act.CopyTo("Clipboard"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act.SendKey({ key = "c", mods = "CTRL" }), pane)
      end
    end),
  })
  table.insert(config.keys, { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") })
  config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "SHIFT",
      action = act.CompleteSelection("ClipboardAndPrimarySelection"),
    },
    { event = { Down = { streak = 1, button = "Right" } }, mods = "NONE", action = act.PasteFrom("Clipboard") },
  }

  -- tmux-style keys for native (non-WSL) panes, e.g. PowerShell. WSL panes run
  -- the real tmux, so every key below is passed straight through to it there.
  local function in_wsl(pane)
    local name = pane:get_foreground_process_name() or ""
    return name:lower():find("wsl", 1, true) ~= nil
  end

  -- A binding that runs `action` in native panes and sends the key on in WSL.
  local function native(key, mods, action)
    return {
      key = key,
      mods = mods,
      action = wezterm.action_callback(function(window, pane)
        if in_wsl(pane) then
          window:perform_action(act.SendKey({ key = key, mods = mods }), pane)
        else
          window:perform_action(action, pane)
        end
      end),
    }
  end

  local function prefix(key, mods, action)
    return { key = key, mods = mods or "NONE", action = action }
  end

  local claude = { "pwsh.exe", "-NoLogo", "-NoExit", "-Command", "claude" }
  local prefix_keys = {
    -- C-a C-a cycles panes, as `bind ^A select-pane -t :.+` does in tmux.
    prefix("a", "CTRL", act.ActivatePaneDirection("Next")),
    prefix("[", nil, act.ActivatePaneDirection("Prev")),
    prefix("]", nil, act.ActivatePaneDirection("Next")),
    prefix("Escape", nil, act.ActivateCopyMode),
    prefix("h", nil, act.ActivatePaneDirection("Left")),
    prefix("j", nil, act.ActivatePaneDirection("Down")),
    prefix("k", nil, act.ActivatePaneDirection("Up")),
    prefix("l", nil, act.ActivatePaneDirection("Right")),
    prefix("s", nil, act.SplitHorizontal({ domain = "CurrentPaneDomain" })),
    prefix("v", nil, act.SplitVertical({ domain = "CurrentPaneDomain" })),
    prefix("R", "SHIFT", act.ReloadConfiguration),
    -- C-a C opens Claude Code to the right, as in tmux.
    prefix("C", "SHIFT", act.SplitPane({ direction = "Right", size = { Percent = 40 }, command = { args = claude } })),
    prefix("c", nil, act.SpawnTab("CurrentPaneDomain")),
    prefix("n", nil, act.ActivateTabRelative(1)),
    prefix("p", nil, act.ActivateTabRelative(-1)),
    prefix("x", nil, act.CloseCurrentPane({ confirm = true })),
    prefix("z", nil, act.TogglePaneZoomState),
    prefix("w", nil, act.ShowLauncherArgs({ flags = "FUZZY|TABS" })),
    prefix("L", "SHIFT", act.ShowLauncher),
  }
  -- Windows (tabs) start at 1, like base-index 1 in tmux.
  for i = 1, 9 do
    table.insert(prefix_keys, prefix(tostring(i), nil, act.ActivateTab(i - 1)))
  end
  config.key_tables = { tmux = prefix_keys }

  local direct_keys = {
    native("a", "CTRL", act.ActivateKeyTable({ name = "tmux", one_shot = true, timeout_milliseconds = 1000 })),
    native("F1", "NONE", act.ActivateTab(0)),
    native("F2", "NONE", act.ActivateTab(1)),
    native("F3", "NONE", act.ActivateTab(2)),
    native("F4", "NONE", act.ActivateTab(3)),
    native("F5", "NONE", act.ActivateTab(4)),
    native("F11", "NONE", act.ActivateTabRelative(-1)),
    native("F12", "NONE", act.ActivateTabRelative(1)),
    native("[", "ALT", act.ActivatePaneDirection("Prev")),
    native("]", "ALT", act.ActivatePaneDirection("Next")),
    native("0", "ALT", act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })),
    native("UpArrow", "ALT", act.AdjustPaneSize({ "Up", 2 })),
    native("DownArrow", "ALT", act.AdjustPaneSize({ "Down", 2 })),
    native("LeftArrow", "ALT", act.AdjustPaneSize({ "Left", 2 })),
    native("RightArrow", "ALT", act.AdjustPaneSize({ "Right", 2 })),
  }
  for _, k in ipairs(direct_keys) do
    table.insert(config.keys, k)
  end

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
