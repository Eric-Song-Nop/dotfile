local M = {
    "nvim-tree/nvim-web-devicons",
    cond = vim.g.vscode == nil,
    event = "VeryLazy",
}

function M.config()
    require("nvim-web-devicons").setup {
        override = {
            zsh = {
                icon = "",
                color = "#428850",
                cterm_color = "65",
                name = "Zsh",
            },
        },
        color_icons = true,
        default = true,
    }
end

return M
