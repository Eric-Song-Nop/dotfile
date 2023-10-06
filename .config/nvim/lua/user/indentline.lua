local M = {
    {
        "shellRaining/hlchunk.nvim",
        cond = vim.g.vscode == nil,
        event = { "UIEnter" },
        config = function()
            local fn = vim.fn

            local function get_color(group, attr)
                return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
            end

            local hl = get_color("CursorLineNr", "fg#")

            require("hlchunk").setup {
                chunk = {
                    notify = false,
                    style = {
                        { fg = hl },
                    },
                },
                blank = {
                    enable = false,
                },
                line_num = {
                    { fg = hl },
                },
            }
        end,
    },
}

return M
