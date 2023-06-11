local wezterm = require "wezterm"

local mux = wezterm.mux
local act = wezterm.action
local wsl_domains = wezterm.default_wsl_domains()

for _, domain in ipairs(wsl_domains) do
  domain.default_cwd = "~"
end

return {
  color_scheme = 'Gruvbox dark, pale (base16)',
  font = wezterm.font('JetBrainsMono NF'),
  font_size = 9.9,
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
  scrollback_lines = 10000,
  show_update_window = true,
  unicode_version = 14,
  adjust_window_size_when_changing_font_size = false,
  force_reverse_video_cursor = true,
  window_close_confirmation = 'NeverPrompt',
--  window_background_opacity = 0.9,
--  text_background_opacity = 0.9,
  window_frame = {
    font = wezterm.font { family = 'Noto Sans', weight = 'Regular' },
    font_size = 9,
    active_titlebar_bg = '#282828',
    inactive_titlebar_bg = '#928374',
  },
  colors = {
    tab_bar = {
      inactive_tab_edge = '#fabd2f',
    },
  },
  window_padding = {
    left = 8,
    right = 8,
    bottom = 0,
    top = 0,
  },
  disable_default_key_bindings = true,
  audible_bell = 'Disabled',
  -- leader = { key = ' ', mods = 'ALT|WIN', timeout_milliseconds = 2000 },
  keys = {
    -- paste from the clipboard
    { key = 'V', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    -- paste from the primary selection
    --{ key = 'V', mods = 'CTRL', action = act.PasteFrom 'PrimarySelection' },
    { key = 'Space', mods = 'ALT|WIN', action = act.ActivateCommandPalette },
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
    -- { key = 'Enter', mods = 'CMD',= act.ActivateCopyMode },
    -- { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    { key = '.', mods = 'ALT|WIN', action = act.IncreaseFontSize },
    { key = ',', mods = 'ALT|WIN', action = act.DecreaseFontSize },
    { key = '/', mods = 'ALT|WIN', action = act.ResetFontSize },
    -- { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    -- { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
    -- { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    -- { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
    --[[ { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) }, ]]
    { key = 'u', mods = 'ALT|WIN', action = act.ActivateTabRelative(-1) },
    { key = 'p', mods = 'ALT|WIN', action = act.ActivateTabRelative(1) },

    { key = 'v', mods = 'ALT|WIN', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'ALT|WIN', action = act.CloseCurrentTab{ confirm = false } },
    { key = 'x', mods = 'ALT|WIN', action = act.CloseCurrentPane{ confirm = false } },
    -- { key = 'b', mods = 'LEADER|CTRL', action = act.SendString '\x02', },
    { key = 'Enter', mods = 'ALT|WIN', action = act.ActivateCopyMode, },
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

