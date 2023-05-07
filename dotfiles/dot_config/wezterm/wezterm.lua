local wezterm = require "wezterm"
local mux = wezterm.mux
local act = wezterm.action
local wsl_domains = wezterm.default_wsl_domains()

for _, domain in ipairs(wsl_domains) do
  domain.default_cwd = "~"
end

return {
--  font = wezterm.font('MonoLisa' ),
  default_prog = { 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe' },
  color_scheme = 'Gruvbox dark, pale (base16)',
  font = wezterm.font('JetBrainsMono Nerd Font'),
  font_size = 10,
  line_height = 1.05,
  enable_tab_bar=true,
  use_ime = true,
  -- treat_left_ctrlalt_as_altgr = true,
  --[[ window_background_opacity = 0.9,
  win32_system_backdrop = 'Acrylic', ]]
  enable_csi_u_key_encoding = true,
  allow_win32_input_mode = false, 
  -- debug_key_events = true,
  term = 'xterm-256color',
  -- term = 'wezterm',
  inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.7,
  },
  use_dead_keys = false,
  scrollback_lines = 5000,
  show_update_window = true,
  unicode_version = 14,
  -- adjust_window_size_when_changing_font_size = false
  window_frame = {
    font = wezterm.font { family = 'Noto Sans', weight = 'Regular' },
  },
  disable_default_key_bindings = true,
  leader = { key = ' ', mods = 'ALT|WIN', timeout_milliseconds = 2000 },
  keys = {
    -- paste from the clipboard
    { key = 'V', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    -- paste from the primary selection
    --{ key = 'V', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
    { key = 'p', mods = 'LEADER', action = act.ActivateCommandPalette },
    { key = 'h', mods = 'LEADER|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'l', mods = 'LEADER|SHIFT', action = act.ActivateTabRelative(1) },
    { key = 'h', mods = 'ALT|WIN', action = act.ActivatePaneDirection 'Left', },
    { key = 'l', mods = 'ALT|WIN', action = act.ActivatePaneDirection 'Right' },
    { key = 'j', mods = 'ALT|WIN', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'ALT|WIN', action = act.ActivatePaneDirection 'Up' },
    { key = 'h', mods = 'ALT|WIN|SHIFT', action = act.SplitPane { direction = 'Left' } },
    { key = 'l', mods = 'ALT|WIN|SHIFT', action = act.SplitPane { direction = 'Right' } },
    { key = 'j', mods = 'ALT|WIN|SHIFT', action = act.SplitPane { direction = 'Down' } },
    { key = 'k', mods = 'ALT|WIN|SHIFT', action = act.SplitPane { direction = 'Up' } },
    { key = 'h', mods = 'ALT|WIN|CTRL', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'l', mods = 'ALT|WIN|CTRL', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'j', mods = 'ALT|WIN|CTRL', action = act.AdjustPaneSize { 'Down', 5 } },
    { key = 'k', mods = 'ALT|WIN|CTRL', action = act.AdjustPaneSize { 'Up', 5 } },
    -- { key = 'Enter', mods = 'CMD', action = act.ActivateCopyMode },
    -- { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    { key = '=', mods = 'LEADER', action = act.IncreaseFontSize },
    { key = '-', mods = 'LEADER', action = act.DecreaseFontSize },
    { key = '0', mods = 'LEADER', action = act.ResetFontSize },
    -- { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    -- { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    -- { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    -- { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
    { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'f', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 't', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'LEADER', action = act.CloseCurrentTab{ confirm = false } },
    { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane{ confirm = false } },
    -- { key = 'b', mods = 'LEADER|CTRL', action = act.SendString '\x02', },
    { key = 'Enter', mods = 'LEADER', action = act.ActivateCopyMode, },
    -- { key = 'p', mods = 'LEADER', action = act.PastePrimarySelection, },
    --[[ { key = 'k', mods = 'CTRL|ALT', action = act.Multiple
      {
        act.ClearScrollback 'ScrollbackAndViewport'
        act.SendKey { key = 'L', mods = 'CTRL' }
      }
    } ]]
    -- { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false, } },
  },
  wsl_domains = wsl_domains,
}

