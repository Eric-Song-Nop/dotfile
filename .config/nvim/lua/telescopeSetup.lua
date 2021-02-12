local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["k"] = actions.move_selection_next,
        ["i"] = actions.move_selection_previous,
        ["E"] = actions.goto_file_selection_vsplit,
        ["s"] = actions.goto_file_selection_split,
        ["l"] = actions.goto_file_selection_edit + actions.center,
        ["<C-i>"] = actions.preview_scrolling_up,
        ["<C-k>"] = actions.preview_scrolling_down,
        ["Q"] = actions.close
      },
    },
  }
}
