local M = {
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     event = "BufReadPre",
    --     opts = {
    --         char = "▏",
    --         show_trailing_blankline_indent = false,
    --         show_first_indent_level = true,
    --         use_treesitter = true,
    --         show_current_context = true,
    --         buftype_exclude = { "terminal", "nofile" },
    --         filetype_exclude = {
    --             "help",
    --             "packer",
    --             "NvimTree",
    --         },
    --     },
    -- },
    {
        "shellRaining/hlchunk.nvim",
        cond = vim.g.vscode == nil,
        event = { "UIEnter" },
        config = function()
            require("hlchunk").setup {
                chunk = {
                    notify = false,
                    style = {
                        { fg = "#FABD2F" },
                    },
                },
                blank = {
                    enable = false,
                },
                line_num = {
                    style = "#FABD2F",
                },
            }
        end,
    },
}

return M
