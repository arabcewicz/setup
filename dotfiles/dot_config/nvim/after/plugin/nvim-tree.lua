-- local HEIGHT_RATIO = 0.8 -- You can change this
-- local WIDTH_RATIO = 0.5

-- --vim.cmd([[ :NvimTreeToggle<CR> ]])

-- local api = require("nvim-tree.api")

-- -- open file upon creation
-- api.events.subscribe(api.events.Event.FileCreated, function(file)
--   vim.cmd("edit " .. file.fname)
-- end)

-- local function edit_or_open()
--   local node = api.tree.get_node_under_cursor()

--   if node.nodes ~= nil then
--     -- expand or collapse folder
--     api.node.open.edit()
--   else
--     -- open file
--     api.node.open.edit()
--     -- Close the tree if file was opened
--     api.tree.close()
--   end
-- end

-- -- open as vsplit on current node
-- local function vsplit_preview()
--   local node = api.tree.get_node_under_cursor()

--   if node.nodes ~= nil then
--     -- expand or collapse folder
--     api.node.open.edit()
--   else
--     -- open file as vsplit
--     api.node.open.vertical()
--   end

--   -- Finally refocus on tree if it was lost
--   api.tree.focus()
-- end

-- local function my_on_attach(bufnr)
--   local function opts(desc)
--     return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--   end

--   -- default mappings
--   api.config.mappings.default_on_attach(bufnr)

--   -- custom mappings
--   vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
--   vim.keymap.set("n", "<S-l>", vsplit_preview, opts("Vsplit Preview"))
--   vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close"))
--   -- vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
-- end

-- require("nvim-tree").setup({
--   on_attach = my_on_attach,
--   disable_netrw = true,
--   hijack_netrw = true,
--   respect_buf_cwd = true,
--   sync_root_with_cwd = true,
--   -- hijack_cursor = false,
--   -- actions = {
--   -- open_file = {
--   -- quit_on_open = true,
--   -- },
--   -- },
--   view = {
--     side = "right",
--     --[[
--     float = {
--       enable = true,
--       open_win_config = function()
--         local screen_w = vim.opt.columns:get()
--         local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
--         local window_w = screen_w * WIDTH_RATIO
--         local window_h = screen_h * HEIGHT_RATIO
--         local window_w_int = math.floor(window_w)
--         local window_h_int = math.floor(window_h)
--         local center_x = (screen_w - window_w) / 2
--         local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
--         return {
--           border = "rounded",
--           relative = "editor",
--           row = center_y,
--           col = center_x,
--           width = window_w_int,
--           height = window_h_int,
--         }
--       end,
--     },
--     width = function()
--       return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
--     end,
--  ]]
--   },
--   renderer = {
--     group_empty = true,
--   },
-- })

-- --
-- vim.keymap.set("n", "<leader>fa", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
-- vim.keymap.set('n', '<M-1>', ':NvimTreeToggle<CR>', { silent = true, noremap = true })
-- vim.keymap.set('n', '<leader>fd', ':NvimTreeToggle<CR>', { silent = true, noremap = true })
-- vim.keymap.set('n', '<M-a>', ':NvimTreeFindFile<CR>', { silent = true, noremap = true })


-- -- Go to last used hidden buffer when deleting a buffer
-- -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#workaround-when-using-rmagattiauto-session
-- vim.api.nvim_create_autocmd("BufEnter", {
--   nested = true,
--   callback = function()
--     -- Only 1 window with nvim-tree left: we probably closed a file buffer
--     if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
--       -- Required to let the close event complete. An error is thrown without this.
--       vim.defer_fn(function()
--         -- close nvim-tree: will go to the last hidden buffer used before closing
--         api.tree.toggle({ find_file = true, focus = true })
--         -- re-open nivm-tree
--         api.tree.toggle({ find_file = true, focus = true })
--         -- nvim-tree is still the active window. Go to the previous window.
--         vim.cmd("wincmd p")
--       end, 0)
--     end
--   end
-- })
