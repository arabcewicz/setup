require('kommentary.config').configure_language("default", {
  prefer_single_line_comments = true,
})

require('legendary').keymaps({
  {
    '<C-/>',
    { n = "<Plug>kommentary_line_default", v = "<Plug>kommentary_visual_default" },
    description = 'kommentary: Toggle comment',
  },
})
