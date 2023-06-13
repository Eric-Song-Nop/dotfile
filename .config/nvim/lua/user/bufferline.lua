if used_buffer_line == "bufferline" then
    local M = {
        "akinsho/bufferline.nvim",
        event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
        dependencies = {
            {
                "famiu/bufdelete.nvim",
            },
        },
    }
    function M.config()
        require("bufferline").setup {
            options = {
                close_command = "Bdelete! %d",       -- can be a string | function, see "Mouse actions"
                right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
                offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
                separator_style = "thin",            -- | "thick" | "thin" | { 'any', 'any' },
            },
            highlights = {
                fill = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                background = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                buffer_visible = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                close_button = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                close_button_visible = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                tab_selected = {
                    fg = { attribute = "fg", highlight = "Normal" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
                tab = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                tab_close = {
                    -- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
                    fg = { attribute = "fg", highlight = "TabLineSel" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
                duplicate_selected = {
                    fg = { attribute = "fg", highlight = "TabLineSel" },
                    bg = { attribute = "bg", highlight = "TabLineSel" },
                    italic = true,
                },
                duplicate_visible = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                    italic = true,
                },
                duplicate = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                    italic = true,
                },
                modified = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                modified_selected = {
                    fg = { attribute = "fg", highlight = "Normal" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
                modified_visible = {
                    fg = { attribute = "fg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                separator = {
                    fg = { attribute = "bg", highlight = "TabLine" },
                    bg = { attribute = "bg", highlight = "TabLine" },
                },
                separator_selected = {
                    fg = { attribute = "bg", highlight = "Normal" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
                indicator_selected = {
                    fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
                    bg = { attribute = "bg", highlight = "Normal" },
                },
            },
        }
    end

    return M
else
    local M = {
        "nanozuki/tabby.nvim",
        event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
    }

    function M.config()
        vim.o.showtabline = 2
        require("tabby.tabline").use_preset("active_wins_at_tail", {
            theme = {
                fill = "TabLineFill",       -- tabline background
                head = "TabLine",           -- head element highlight
                current_tab = "TabLineSel", -- current tab label highlight
                tab = "TabLine",            -- other tab label highlight
                win = "TabLine",            -- window highlight
                tail = "TabLine",           -- tail element highlight
            },
            nerdfont = true,                -- whether use nerdfont
            -- tab_name = {
            -- name_fallback = "function({tabid}), return a string",
            -- },
            buf_name = {
                mode = "'unique'|'relative'|'tail'|'shorten'",
            },
        })
    end

    return M
end
