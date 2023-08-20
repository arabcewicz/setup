require('legendary').keymaps({
  {
    '<leader>ma',
    require("harpoon.mark").add_file,
    description = "harpoon: Add file"
  },
  {
    '<leader>ml',
    require("harpoon.ui").toggle_quick_menu,
    description = "harpoon: List files"
  },
  {
    '<leader>1',
    function() require("harpoon.ui").nav_file(1) end,
    description = "harpoon: Go to file 1"
  },
  {
    '<leader>2',
    function() require("harpoon.ui").nav_file(2) end,
    description = "harpoon: Go to file 2"
  },
  {
    '<leader>3',
    function() require("harpoon.ui").nav_file(3) end,
    description = "harpoon: Go to file 3"
  },
  {
    '<leader>4',
    function() require("harpoon.ui").nav_file(4) end,
    description = "harpoon: Go to file 4"
  },
})
