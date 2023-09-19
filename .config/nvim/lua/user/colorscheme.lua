local M = {
    {
        "sainnhe/gruvbox-material",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = { style = "moon" },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                flavour = "mocha",
                transparent_background = true,
            }
        end,
    },
}

return M
