local M = {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        jump = {
            autojump = true,
        },
        label = {
            after = { 0, 0 },
        },
    },
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                -- default options: exact mode, multi window, all directions, with a backdrop
                require("flash").jump()
            end,
        },
        {
            "S",
            mode = { "n", "o", "x" },
            function()
                require("flash").treesitter()
            end,
        },
    },
}

return M
