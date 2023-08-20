require("obsidian").setup({
  dir = "~/knowledgebase",
  notes_subdir = "notes",
  note_id_func = function(title)
    local name = ""
    if title ~= nil then
      name = title:gsub("[^A-Za-z0-9 -]", "")
    else
      for _ = 1, 4 do name = name .. string.char(math.random(65, 90)) end
    end
    return name
  end,
  disable_frontmatter = false,
  note_frontmatter_func = function(note) return { a = "asdf" } end,
  templates = {
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
  },
})
