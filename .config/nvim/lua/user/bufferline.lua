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
                close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
                right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
                offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
                separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
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
        local theme = {
            fill = "TabLineFill",
            -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
            head = "TabLine",
            current_tab = "TabLineSel",
            tab = "TabLine",
            win = "TabLine",
            tail = "TabLine",
        }
        require("tabby.tabline").set(function(line)
            return {
                {
                    { "  ", hl = theme.head },
                    line.sep("", theme.head, theme.fill),
                },
                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab or theme.tab
                    return {
                        line.sep("", hl, theme.fill),
                        tab.is_current() and "" or "󰆣",
                        tab.number(),
                        -- tab.name(),
                        tab.close_btn "",
                        line.sep("", hl, theme.fill),
                        hl = hl,
                        margin = " ",
                    }
                end),
                line.spacer(),
                line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                    return {
                        line.sep("", theme.win, theme.fill),
                        win.is_current() and "" or "",
                        win.buf_name(),
                        line.sep("", theme.win, theme.fill),
                        hl = theme.win,
                        margin = " ",
                    }
                end),
                {
                    line.sep("", theme.tail, theme.fill),
                    { "  ", hl = theme.tail },
                },
                hl = theme.fill,
            }
        end)
    end

    return M
end
