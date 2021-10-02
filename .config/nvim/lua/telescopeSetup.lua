local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["k"] = actions.move_selection_next,
        ["i"] = actions.move_selection_previous,
        ["E"] = actions.select_vertical,
        ["s"] = actions.select_horizontal,
        ["l"] = actions.select_default + actions.center,
        ["<C-i>"] = actions.preview_scrolling_up,
        ["<C-k>"] = actions.preview_scrolling_down,
        ["Q"] = actions.close
      },
    },
  }
}

require'telescope'.load_extension('project')
