used_buffer_line = "tabby"
require "options"
require "Lazy"
require "keymaps"
require "autocommands"

vim.o.background = "dark" -- or "light" for light mode
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_foreground = "original"
vim.g.gruvbox_material_transparent_background = 0
vim.cmd [[colorscheme gruvbox-material]]
